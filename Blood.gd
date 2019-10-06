extends Control

var fade_in=1

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if fade_in==1:
		if $Red.modulate[3]<.8:
			$Red.modulate[3]+=0.02
		else:
			fade_in=0
	else:
		$Red.modulate[3]-=0.02
		if $Red.modulate[3]<0:
			queue_free()