extends Entity

var can_shoot: bool = true
var target = null
var laser_color = Color(1.0, .329, .298) #rojo

onready var parent = get_parent()
onready var muzzle = $Weapon/Muzzle
onready var weapon = $Weapon
onready var sight = $Weapon/Sight
onready var ray_cast = $RayCast2D
onready var reload_timer = $RayCast2D/ReloadTimer

export (PackedScene) var alien_bullet: PackedScene = preload("res://bullet/AlienBullet.tscn")
export (float) var weapon_speed
export (String, "aim", "patrol") var patrol_type = "patrol" # estados posibles


func _on_AlienDude_hp_changed(new_hp):
	pass

func _on_AlienDude_died():
	speed = 0
	weapon.visible = false
	anim_player.play("death")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "death":
		Globals.enemy_killed()
		queue_free()

func _physics_process(delta):
	update() # para dibujar
	
	# si el state es "patrol", entonces el el enmigo se mueve siguiendo el path
	if patrol_type == "patrol":
		if parent is PathFollow2D:
			parent.set_offset(parent.get_offset() + speed * delta)
			anim_player.play("run")
			position = Vector2()
	
func _process(delta):
	if target and self.hp > 0:
		# rotation del raycast
		var angle_to_target: float = global_position.direction_to(target.global_position).angle()
		ray_cast.global_rotation = angle_to_target
		
		# apuntamos el arma al target
		if target.name == "Player":
			var target_dir = (target.global_position - global_position).normalized()
			var current_dir = Vector2(1,0).rotated($Weapon.global_rotation)
			$Weapon.global_rotation = current_dir.linear_interpolate(target_dir, weapon_speed * delta).angle()
		
			# el enemigo mira al target
			if target.global_position.x < global_position.x:
				weapon.flip_v = true
				animated_sprite.flip_h = true
			else:
				weapon.flip_v = false
				animated_sprite.flip_h = false
			
		# detectamos colision con el jugador
		# cambia el estado a "aim", el enemigo deja de moverse 
		# y si el timer lo permite, dispara al target
		if ray_cast.is_colliding(): 
			var collision = ray_cast.get_collider()
			if collision.name == "Player":
				patrol_type = "aim"
				anim_player.play("idle")
				if can_shoot:
					shoot()
			else:
				patrol_type = "patrol"

func shoot():
	if alien_bullet:
		var alien_bullet_instance = alien_bullet.instance()
		get_tree().current_scene.add_child(alien_bullet_instance)
		alien_bullet_instance.global_position = muzzle.global_position
		alien_bullet_instance.rotation_degrees = weapon.rotation_degrees
		can_shoot = false
	reload_timer.start()

func _on_DetectRadius_body_entered(body):
	target = body

func _on_DetectRadius_body_exited(body):
	if body == target:
		target = null

func _on_ReloadTimer_timeout():
	can_shoot = true

func _draw():
	# dibujamos un mira laser
	if target != null and self.hp > 0:
		draw_circle((target.global_position - muzzle.global_position).rotated(-rotation), 1, laser_color)
		draw_line(Vector2(), (target.global_position  - muzzle.global_position).rotated(-rotation), laser_color)
