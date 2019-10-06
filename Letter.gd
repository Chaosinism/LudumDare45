extends Node2D

var isAttached = 0
var column=0
var row=0
var type=0    # 0 - normal, 1 - gold, 2 - red
var isTop=0
var isBottom=0
var visAlpha=.0
var dying=0
var colorList=[Color(0,0.2,0.3,1),Color(0,0.2,0.4,1),Color(0,0.2,0.5,1),Color(0,0.2,0.6,1),Color(0,0.2,0.7,1),Color(0,0.2,0.8,1),Color(0,0.2,0.9,1)]

func Attach(x,y):
	isAttached=1
	column=x
	row=y
	$LetterBody.velocity=Vector2(0,0)
	$LetterBody.position=Vector2(0,0)
	updateColor()
	get_parent().get_node("Player").connect("cleanup", self, "_purged")

func Die():
	dying=1
	isTop=0
	isBottom=0
	
func _purged():
	if row==0:
		isTop=1
		isBottom=1
	else:
		isAttached=0
		$LetterBody.velocity=Vector2(100,0).rotated(rand_range(0,2*PI))
		Die()

func _achieved(col):
		if isAttached==1 and column==col:
			$LetterBody.velocity=Vector2(0,-100)
			Die()
			if type==1:
				get_parent().collectedGolds+=1

func updateColor():
	if isAttached==1:
		if type==1:
			$LetterBody/Label.add_color_override("font_color", Color(.83,.74,.13,1))
		else:
			$LetterBody/Label.add_color_override("font_color", colorList[column+3])
	elif type==1:
		$LetterBody/Label.add_color_override("font_color", Color(.83,.74,.13,1))
	elif type==2:
		$LetterBody/Label.add_color_override("font_color", Color(1,0,0,1))
	else:
		$LetterBody/Label.add_color_override("font_color", Color(0.2,0.2,0.2,1))
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	var aeiou=[97,101,105,111,117,116,110,115,104,114]
	var ascii_code=randi()%26+97
	if rand_range(0,1)<0.5:
		ascii_code=aeiou[randi()%10]
	$LetterBody/Label.text=PoolByteArray([ascii_code]).get_string_from_ascii()

	modulate=Color(1,1,1,visAlpha)

func _physics_process(delta):
	# fade-in
	if visAlpha<1 and dying==0:
		visAlpha=visAlpha+0.02
		modulate=Color(1,1,1,visAlpha)
		
	# fade-out
	if dying==1:
		visAlpha=visAlpha-0.02
		modulate=Color(1,1,1,visAlpha)
		if visAlpha<=0:
			queue_free()
			
	if isAttached==1:
		var host = get_parent().get_node("Player").position
		position=Vector2(host[0]+row*30,host[1]+column*30)
		$LetterBody.position=Vector2(0,0)