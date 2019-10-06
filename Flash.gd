extends Control
onready var Summary = preload("res://Ending.tscn")

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if $White.modulate[3]<1:
		$White.modulate[3]+=0.01
	else:
		var summary=Summary.instance()
		add_child(summary)
		summary.words=get_parent().finishedWords
		summary.goldCount=get_parent().collectedGolds
		summary.healthCount=get_parent().health
		summary.timeConsumed=get_parent().timer
		summary.Calculate()