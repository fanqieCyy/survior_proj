extends StaticBody2D

const DROPPER = preload("res://scenes/dropper.tscn")

var dropper_possibility := 50

func _on_area_2d_area_entered(area: Area2D) -> void:
	push_error(0)
	if(area.get_parent().is_in_group("weapon")):
		generate_dropper(1, area)

func generate_dropper(dropper_id, area : Area2D) -> void:
	if(randi_range(1, 100) > dropper_possibility):
		var dropper = DROPPER.instantiate()
		get_tree().current_scene.add_child(dropper)
		dropper.z_index = 1
		dropper.position = position
	queue_free()
	if(area.get_parent().has_method("check_penetrate")):
		area.get_parent().check_penetrate()
	else:
		print("[error]: has not check_penetrate")
