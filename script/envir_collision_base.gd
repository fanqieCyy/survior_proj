extends StaticBody2D

const DROPPER = preload("res://scenes/dropper.tscn")

var dropper_possibility := 50

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(randi_range(1, 100) > dropper_possibility):
		var dropper = DROPPER.instantiate()
		get_tree().current_scene.add_child(dropper)
		dropper.z_index = 1
		dropper.position = self.position
	queue_free()
	area.get_parent().queue_free()
