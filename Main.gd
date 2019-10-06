extends Control
onready var Game = preload("res://GamePlay.tscn")

var inGame=0

func _unhandled_input(event):
	if event is InputEventKey and inGame==0:
		if event.pressed and event.scancode == KEY_SPACE:
			_on_Start_pressed()

func _on_Start_pressed():
	if inGame==0:
		inGame=1
		var game=Game.instance()
		get_tree().get_root().add_child(game)
		hide()

