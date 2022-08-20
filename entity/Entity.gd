extends KinematicBody2D
class_name Entity # clase padre que se utilizara para todos los personajes

#custom signals
signal hp_changed( new_hp)         
signal hp_max_changed( new_hp_max) 
signal died 

export (int) var hp_max: int = 100 setget set_hp_max
export (int) var hp: int = hp_max setget set_hp, get_hp
export (int) var acc: int = 40          # aceleracion
export (int) var max_speed: int = 100   # velocidad maxima de movimiento

const FRICTION: float = 0.15

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")
onready var coll_shape = $CollisionShape2D
onready var anim_player = $AnimationPlayer
onready var hurtbox = $Hurtbox

var move_direction: Vector2 = Vector2.ZERO  # vector movimiento
var velocity: Vector2 = Vector2.ZERO        # vector velocidad

func _physics_process(delta: float):
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2.ZERO, FRICTION) # interpolamos la velocidad para un movimiento mas natural
	move()
	
func move():
	move_direction = move_direction.normalized()  # normalizamos el vector movimiento
	velocity += move_direction * acc 
	velocity = velocity.clamped(max_speed)        # limitamos la velocidad a la velocidad maxima	

func die():
	queue_free()

func receive_damage(damage: int):
	self.hp -= damage
	print(name + " received " + str(damage) + " damage")

func _on_Hurtbox_area_entered(hitbox):
	receive_damage(hitbox.damage)
	if hitbox.is_in_group("bullet"):
		hitbox.destroy()

func set_hp(value):
	if value != hp:
		hp = clamp(value, 0, hp_max) # la vida solo puede ser mayor que cero y menor que el maximo
		emit_signal("hp_changed", hp)
		if hp == 0:
			emit_signal("died")

func get_hp():
	return hp
	
func set_hp_max(value):
	if value != hp_max:
		hp_max = max(0, value)
		emit_signal("hp_max_changed", hp_max)
		self.hp = hp

func _on_Entity_died():
	die()
