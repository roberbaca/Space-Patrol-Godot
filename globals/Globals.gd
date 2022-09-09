extends Node

signal killed

var enemies_killed = 0
var enemies_total = 0
var current_stage = 1

func restart_game():
	enemies_killed = 0
	enemies_total = 0
	current_stage = 0
	get_tree().reload_current_scene()
	
func next_stage():
	enemies_killed = 0
	get_tree().reload_current_scene()
	
func enemy_killed():
	enemies_killed += 1
	emit_signal("killed")

