extends Entity

const SMOOTH := 0.1 #movimiento gradual de la camara
var is_alive : bool = true
var can_fire = true

export var bullet_speed = 400
export var fire_rate = 0.2

onready var muzzle = $Weapon/Muzzle
onready var weapon = $Weapon
onready var sight = $Weapon/Sight

func _process(delta: float):
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()

	
	if is_alive:
		if mouse_direction.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
		elif mouse_direction.x < 0 and not animated_sprite.flip_h:
			animated_sprite.flip_h = true

		if Input.is_action_pressed("ui_fire") and can_fire:
			print("diparando bullet")
			can_fire = false
			yield(get_tree().create_timer(fire_rate), "timeout")
			can_fire = true
	
		if move_direction != Vector2.ZERO: # player se esta moviendo
			anim_player.play("run")
		else:
			anim_player.play("idle") # player esta quieto
		
		weapon.look_at(get_global_mouse_position())
		if get_global_mouse_position().x < position.x:
			weapon.flip_v = true
		else:
			weapon.flip_v = false
			
		handle_camera()
		get_input()

func get_input():
	move_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		move_direction += Vector2.DOWN
	if Input.is_action_pressed("ui_up"):
		move_direction += Vector2.UP
	if Input.is_action_pressed("ui_left"):
		move_direction += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		move_direction += Vector2.RIGHT

func handle_camera():
	var new_camera_position = global_position + (get_global_mouse_position() - global_position) * SMOOTH
	$Camera.global_position = new_camera_position




func _on_Player_died():
	print("died")
