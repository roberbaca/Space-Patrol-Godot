extends Control

func _ready():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state

func _on_Continue_pressed():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
