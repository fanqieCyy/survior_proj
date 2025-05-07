extends StaticBody2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	queue_free()
	area.get_parent().queue_free()
