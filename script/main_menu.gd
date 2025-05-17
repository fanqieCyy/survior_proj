extends Control
@onready var new_game: Button=$CenterContainer/MainMenu/play

func _ready() -> void:
	new_game.grab_focus()
#UI基本实现的代码
func _on_play_pressed() -> void:
	#测试场景
	get_tree().change_scene_to_file("res://background.tscn")
	#载入新手关
	#get_tree().change_scene_to_file("res://scenes/stages/tutorial_stage.tscn") 

func _on_setting_pressed() -> void:
	$CenterContainer/MainMenu.visible=false
	$CenterContainer/SETTING.visible=true

func _on_credits_pressed() -> void:
	$CenterContainer/CREDITS.visible=true
	$CenterContainer/MainMenu.visible=false

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_back_pressed() -> void:
	$CenterContainer/SETTING.visible=false
	$CenterContainer/CREDITS.visible=false
	$CenterContainer/MainMenu.visible=true
