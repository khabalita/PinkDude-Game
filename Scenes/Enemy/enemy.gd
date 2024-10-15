extends CharacterBody2D
class_name Enemy

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play("idle")

func _physics_process(delta):
	pass
