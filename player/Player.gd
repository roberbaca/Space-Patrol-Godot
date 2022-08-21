extends Entity

const SMOOTH := 0.1 #movimiento gradual de la camara
var is_alive : bool = true

export (PackedScene) var bullet: PackedScene = preload("res://bullet/PlayerBullet.tscn")

onready var muzzle = $Weapon/Muzzle
onready var weapon = $Weapon
onready var sight = $Weapon/Sight
onready var fire_rate = $FireRate


func _process(delta: float):
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	if is_alive:
		# Animaciones
		if mouse_direction.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
		elif mouse_direction.x < 0 and not animated_sprite.flip_h:
			animated_sprite.flip_h = true

		if move_direction != Vector2.ZERO: # player se esta moviendo
			anim_player.play("run")
		else:
			anim_player.play("idle") # player esta quieto
			
		# Disparo de proyectiles
		if Input.is_action_pressed("ui_fire") and fire_rate.is_stopped():
			fire()
	
		# Rotacion del arma
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

func fire():
	if bullet:
		var bullet_instance = bullet.instance()
		get_tree().current_scene.add_child(bullet_instance)
		bullet_instance.position = muzzle.global_position
		bullet_instance.rotation_degrees = weapon.rotation_degrees
		fire_rate.start()

func _on_Player_died():
	weapon.visible = false
	is_alive = false
	anim_player.play("death")

func _on_Player_hp_changed(new_hp):
	print("ouch")
