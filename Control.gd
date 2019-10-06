extends Control
var messageActivated=0

func SetMessage(sentence):
	$Message.text=sentence
	messageActivated=1

func _physics_process(delta):
	$Display_gold.text=str(get_parent().collectedGolds)
	$Display_health.text=str(get_parent().health)
	$Display_time.text=str(int(get_parent().timer/60))