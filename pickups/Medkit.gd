extends Area2D

export (int) var health_value = 25

# chequeamos si el body con el que colisiona tiene la funcion "heal"
func _on_Medkit_body_entered(body):
	if body.has_method("heal"):
		body.heal(health_value)
		queue_free()
