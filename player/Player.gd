extends Entity

const SMOOTH := 0.1 #movimiento gradual de la camara
var is_alive : bool = true

func _process(delta: float):
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	if is_alive:
		if mouse_direction.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
		elif mouse_direction.x < 0 and not animated_sprite.flip_h:
			animated_sprite.flip_h = true

		if move_direction != Vector2.ZERO: # player se esta moviendo
			anim_player.play("run")
		else:
			anim_player.play("idle") # player esta quieto
			
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


