extends Area2D

export (ShaderMaterial) var whiten_material
const WHITEN_DURATION = 0.15

# utilizamo el shader para cambiar el color de la textura a blanco
func _on_Hurtbox_area_entered(area):
	if  get_parent().name == "Player":
		whiten_material.set_shader_param("whiten", true)
		yield(get_tree().create_timer(WHITEN_DURATION), "timeout")
		whiten_material.set_shader_param("whiten", false)
