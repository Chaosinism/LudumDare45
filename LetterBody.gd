extends KinematicBody2D
onready var Blood = preload("res://Blood.tscn")

var velocity = Vector2(250, 250)

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var manager=get_parent().get_parent()
		var letter1=get_parent()
		var letter2=collision_info.collider.get_parent()
		var absHeight=get_global_position()[0]

		if letter1.isAttached==1 and letter2.isAttached==0 and letter2.dying==0:
			if letter1.isTop==1 and collision_info.position[0]<absHeight:
				letter2.Attach(letter1.column,letter1.row-1)
				letter2.isTop=1
				letter1.isTop=0
				manager.currentWords[letter1.column+3]=letter2.get_node('LetterBody/Label').text+manager.currentWords[letter1.column+3]
				if letter2.type==2:
					manager.health-=1
					var blood=Blood.instance()
					manager.add_child(blood)
					manager.get_node("Sound_hit").play()

			if letter1.isBottom==1 and collision_info.position[0]>absHeight:
				letter2.Attach(letter1.column,letter1.row+1)
				letter2.isBottom=1
				letter1.isBottom=0
				manager.currentWords[letter1.column+3]=manager.currentWords[letter1.column+3]+letter2.get_node('LetterBody/Label').text
				if letter2.type==2:
					manager.health-=1
					var blood=Blood.instance()
					manager.add_child(blood)
					manager.get_node("Sound_hit").play()
			
			var wordToCheck=manager.currentWords[letter1.column+3]	
			if len(wordToCheck)>2 and wordToCheck in manager.scrabbleDict and manager.isFinished[letter1.column+3]==0:
				print(manager.currentWords[letter1.column+3])
				manager.isFinished[letter1.column+3]=1