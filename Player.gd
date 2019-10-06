extends Node2D
signal cleanup

var playerSpeed=Vector2(0,0)
var maxSpeed=200
var accel=20
var debugMode=0

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_SPACE:
			emit_signal("cleanup")
			for i in range(7):
				if get_parent().isFinished[i]==0:
					get_parent().currentWords[i]=get_parent().initWord[i]
		if event.pressed and event.scancode == KEY_ESCAPE and debugMode==1:
			get_parent().Gameover()

func _physics_process(delta):
	if Input.is_key_pressed(KEY_W):
		playerSpeed[1]=playerSpeed[1]-accel
		if playerSpeed[1]<-maxSpeed:
			playerSpeed[1]=-maxSpeed
	elif Input.is_key_pressed(KEY_S):
		playerSpeed[1]=playerSpeed[1]+accel
		if playerSpeed[1]>maxSpeed:
			playerSpeed[1]=maxSpeed
	else:
		playerSpeed[1]=playerSpeed[1]*0.9
		
	if Input.is_key_pressed(KEY_A):
		playerSpeed[0]=playerSpeed[0]-accel
		if playerSpeed[0]<-maxSpeed:
			playerSpeed[0]=-maxSpeed
	elif Input.is_key_pressed(KEY_D):
		playerSpeed[0]=playerSpeed[0]+accel
		if playerSpeed[0]>maxSpeed:
			playerSpeed[0]=maxSpeed
	else:
		playerSpeed[0]=playerSpeed[0]*0.9

	position=position+playerSpeed*delta



