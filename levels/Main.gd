extends Node2D

var crosshair = preload("res://assets/Player/Gun/Crosshair/crosshair.png")
var enemies_count

func _ready():
	#Input.set_custom_mouse_cursor(null) # para poner el cursor del mouse por default
	Input.set_custom_mouse_cursor(crosshair, Input.CURSOR_ARROW, Vector2(16,16))
	Globals.connect("killed", self, "enemy_count")
	enemies_count = $Enemies.get_child_count()
	print("Total Enemies: ", enemies_count)

func _on_Player_hp_changed(new_hp):
	if new_hp <= 0:
		$GameOverScreen.visible = true

func enemy_count():
	print("Enemies Killed: ", Globals.enemies_killed)
	if enemies_count == Globals.enemies_killed:
		print("NO MORE ENEMIES")
		#$EndLevelDoor.visible = true
		#$EndLevelDoor/AnimationPlayer.play("show")
