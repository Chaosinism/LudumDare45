extends Node2D
onready var Letter = preload("res://Letter.tscn")
onready var Flash = preload("res://Flash.tscn")
signal levelup(col)

var min_speed = 50  
var max_speed = 100  
var min_scale = 0.3
var max_scale = 0.5
var goldRate = 0.15
var redRate = 0.1
var timer=0
var spawnInterval=60
var scrabbleDict={}
var initWord=['n','o','t','h','i','n','g']
var currentWords=['n','o','t','h','i','n','g']
var finishedWords=[]
var isFinished=[0,0,0,0,0,0,0]
var collectedGolds=0
var level=0
var health=10
var gameover=0

func SpawnLetter():
	if gameover==0:
		$MobPath/MobSpawnLocation.set_offset(randi())
		var mob = Letter.instance()
		var direction = $MobPath/MobSpawnLocation.rotation + PI / 2 + rand_range(-PI / 8, PI / 8)
		add_child(mob)
		mob.position = $MobPath/MobSpawnLocation.position
		var scale = rand_range(min_scale,max_scale)
		mob.scale = Vector2(scale,scale)
		var speed=rand_range(min_speed,max_speed)
		
		mob.get_node("LetterBody").velocity=Vector2(speed,0).rotated(direction)
		connect("levelup",mob,"_achieved")
		
		if rand_range(0,1)<goldRate:
			mob.type=1
			mob.updateColor()
		elif rand_range(0,1)<redRate:
			mob.type=2
			mob.updateColor()

func Gameover():
	gameover=1
	var flash=Flash.instance()
	add_child(flash)

func Levelup():
	$Sound_lvup.play()
	$BGM_low.volume_db+=2
	$BGM_high.volume_db-=2
	print('level'+str(level))
	if level==1:
		spawnInterval-=10
		$Control.SetMessage('More options came to your life.\n(Letters appear more frequently.)')
		$Figure.animation='2'
	if level==2:
		spawnInterval-=10
	if level==3:
		spawnInterval-=10
		max_speed+=50
		$Control.SetMessage('The pace of life is becoming faster.\n(Letters move faster.)')
		$Figure.animation='3'
	if level==4:
		redRate+=.1
		max_speed+=50
	if level==5:
		spawnInterval-=10
		redRate+=.2
		$Control.SetMessage('You are more vulnerable with aging.\n(More red letters appear.)')
		$Figure.animation='4'
	if level==6:
		redRate+=.2
	if level==7:
		Gameover()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	$BGM_mid.play()
	$BGM_high.play()
	$BGM_low.play()
	
	for i in range(7):
		var mob = Letter.instance()
		add_child(mob)
		mob.scale=Vector2(0.4,0.4)
		mob.get_node("LetterBody/Label").text=initWord[i]
		mob.Attach(i-3,0)
		mob.isTop=1
		mob.isBottom=1
		connect("levelup",mob,"_achieved")
		
	var file = File.new()
	file.open("res://dictionary.json", file.READ)
	var text = file.get_as_text()
	scrabbleDict=parse_json(text)
	file.close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if gameover==0:
		timer=timer+1
		if timer%spawnInterval==0:
			SpawnLetter()
	
		for i in range(7):
			if isFinished[i]==1:
				isFinished[i]=2
				finishedWords.append(currentWords[i])
				level=level+1
				Levelup()
				emit_signal("levelup",i-3)
				
		if health<1:
			Gameover()