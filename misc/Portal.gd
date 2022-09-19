extends StaticBody2D

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		Globals.load_next_stage()
