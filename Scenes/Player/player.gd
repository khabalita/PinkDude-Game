extends CharacterBody2D
class_name Player

const move_speed : float = 120
const jump_speed : float = 300
@onready var animated_sprite = $AnimatedSprite
@onready var jump_sound = $Sound/Jump
@onready var hurt_sound = $Sound/Hurt
@onready var low_health_sound = $Sound/Low_Health
var low_life : bool = false
var is_facing_right : bool = true
var life : int = 3
var hit : bool = false
#uso la variable gravity accediento a la configuracion del proyecto
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	life_sprite()
	
func _process(delta):
	pass
	
#Todas las fisicas se ejecutan en esta funcion
func _physics_process(delta):
	damage_taken()
	life_sprite()
	move_x()
	flip()
	jump(delta)
	update_animations()
	move_and_slide()

#logica que mueve al personaje en eje x
func move_x():
	var input_axis = Input.get_axis("move_left","move_right")
	velocity.x = input_axis * move_speed

#logica que gira al personaje entrando al atributo scale en x (horizontal)
func flip():
	if (is_facing_right and velocity.x < 0) or (not is_facing_right and velocity.x > 0):
		animated_sprite.scale.x *= -1
		is_facing_right = not is_facing_right

#logica de salto verificando que solo salte cuando esta en el piso
func jump(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_speed
		jump_sound.play()
	
	if not is_on_floor():
		velocity.y += gravity * delta

#logica que anima al personaje dependiendo de en que situacion este
func update_animations():
	if not is_on_floor():
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
		return
	if velocity.x:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")

func damage_taken():
	if hit == true:
		if life > 0:
			life -=1
			hit = false
			hurt_sound.play()
		if life <= 0:
			get_tree().reload_current_scene()

func life_sprite():
	if life == 3:
		$gui/Life1.frame = 0
		$gui/Life2.frame = 0
		$gui/Life3.frame = 0
	if life == 2:
		$gui/Life1.frame = 0
		$gui/Life2.frame = 0
		$gui/Life3.frame = 1
	if (life == 1 and !low_life):
		$gui/Life1.frame = 0
		$gui/Life2.frame = 1
		$gui/Life3.frame = 1
		low_health_sound.play()
		low_life = true
	if life == 0:
		$gui/Life1.frame = 1
		$gui/Life2.frame = 1
		$gui/Life3.frame = 1

func die():
	queue_free()
