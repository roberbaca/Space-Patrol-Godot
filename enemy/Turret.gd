extends StaticBody2D

export (PackedScene) var bullet: PackedScene = preload("res://bullet/EnemyBullet.tscn")
export (PackedScene) var explosion: PackedScene = preload("res://enemy/Explosion.tscn")

var target: Node2D = null
export (float) var turret_speed = 100
export (float) var turret_hp = 50

onready var gun = $Gun
onready var cannon1 = $Gun/Cannon1
onready var cannon2 = $Gun/Cannon2
onready var ray_cast = $RayCast2D
onready var reload_timer = $RayCast2D/ReloadTimer
onready var player: KinematicBody2D = get_tree().current_scene.get_node("Player")
onready var anim_player = $AnimationPlayer
onready var coll_shape = $CollisionShape2D

func _ready():
	# esperamos 1 frame para asegurarnos que se cargaron todos los nodos
	yield(get_tree(), "idle_frame") 
	target = find_target()

func _process(delta):
	if target != null:
		# rotation del raycast
		var angle_to_target: float = global_position.direction_to(target.global_position).angle()
		ray_cast.global_rotation = angle_to_target
		
		# giramos la torreta
		var target_dir = (target.global_position - global_position).normalized()
		var current_dir = Vector2(1 ,0).rotated(gun.global_rotation)
		gun.global_rotation = current_dir.linear_interpolate(target_dir, turret_speed * delta).angle()  
		
		#detectamos colision con el jugador y si el timer lo permite, dispara
		if ray_cast.is_colliding():         
			if reload_timer.is_stopped(): 
				anim_player.play("shoot")
				shoot()
	
	if turret_hp <= 0:
		coll_shape.disabled = true
		explode()
		Globals.enemy_killed()
		queue_free()


func shoot():
	ray_cast.enabled = false
	
	# creamos los proyectiles
	if bullet: 
		var bullet_instance1: Node2D = bullet.instance()
		var bullet_instance2: Node2D = bullet.instance()
		get_tree().current_scene.add_child(bullet_instance1)
		get_tree().current_scene.add_child(bullet_instance2)
		bullet_instance1.global_position = cannon1.global_position
		bullet_instance1.global_rotation  = ray_cast.global_rotation		
		bullet_instance2.global_position = cannon2.global_position
		bullet_instance2.global_rotation  = ray_cast.global_rotation
	
	reload_timer.start()

func find_target(): 
	# buscamos al jugador
	var new_target: Node2D = null
	
	if player:
		new_target = player
	
	return new_target

func _on_ReloadTimer_timeout():
	ray_cast.enabled = true

func _on_Area2D_area_entered(hitbox):
	# la torreta recibe daño
	if hitbox.name == "PlayerBullet":
		turret_hp -= hitbox.damage
		hitbox.destroy()
		
func explode():
	# creamos una explosion
	var explosion_instance: Node2D = explosion.instance()
	get_tree().current_scene.add_child(explosion_instance)
	explosion_instance.global_position = global_position

