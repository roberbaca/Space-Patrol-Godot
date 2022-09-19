extends Node

signal killed

var enemies_killed = 0
var enemies_total = 0
var current_stage = 1
var next_stage = current_stage + 1

func restart_game():
	enemies_killed = 0
	enemies_total = 0
	current_stage = 0
	get_tree().reload_current_scene()
	
func load_next_stage():
	enemies_killed = 0
	current_stage += 1
	if get_tree().current_scene.name != "Level2":
		get_tree().change_scene("res://levels/Level" + str(current_stage) + ".tscn")
	else:
		get_tree().change_scene("res://menu/TheEndScreen.tscn")
	
	
func enemy_killed():
	enemies_killed += 1
	emit_signal("killed")

