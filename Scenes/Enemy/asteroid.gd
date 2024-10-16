extends Area2D
class_name Asteroid

func _ready():
	pass

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.hit = true
