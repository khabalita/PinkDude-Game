extends Area2D
class_name Spike

func _ready():
	pass



func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.hit = true
