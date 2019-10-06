extends Area2D

func _on_Border_body_entered(victim):
	var letter = victim.get_parent()
	if letter.isAttached==0:
		letter.Die()
	else:
		get_parent().get_node("Player").playerSpeed[0]=-get_parent().get_node("Player").playerSpeed[0]*1.2
		get_parent().get_node("Player").playerSpeed[1]=-get_parent().get_node("Player").playerSpeed[1]*1.2