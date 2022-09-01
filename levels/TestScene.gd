extends Node2D

var crosshair = preload("res://assets/Player/Gun/Crosshair/crosshair.png")

func _ready():
	#Input.set_custom_mouse_cursor(null) # para poner el cursor del mouse por default
	Input.set_custom_mouse_cursor(crosshair, Input.CURSOR_ARROW, Vector2(16,16))
