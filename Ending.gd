extends Control

var goldCount=0
var healthCount=0
var timeConsumed=7200
var words=[]

func Calculate():
	var score2=goldCount*100
	var score3=healthCount*25
	var score1=0
	for i in words:
		score1+=int(10*pow(2,len(i)))
	var rate=7200.0/float(timeConsumed)
	var totalScore=int(rate*(score1+score2+score3))
	$ScoreValue.text=str(score1)+'\n+'+str(score2)+'\n+'+str(score3)+'\n*'+str(rate)+'\n\n'+str(totalScore)
	$WordSummary.text='What you pursued throughout the life:\n\n'
	for i in words:
		$WordSummary.text+='  '+i+'\n'
	
func _ready():
	Calculate()

func _on_Button_pressed():
	get_parent().get_parent().queue_free()
	get_tree().get_root().get_node("Main").show()
	get_tree().get_root().get_node("Main").inGame=0


func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_SPACE:
			_on_Button_pressed()