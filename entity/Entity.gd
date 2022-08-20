extends KinematicBody2D
class_name Entity # clase padre que se utilizara para todos los personajes

export (int) var hp: int = 100
export (int) var hp_max: int = 100
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
