extends Control

func _ready():
	hide()

func _on_resume_pressed():
	hide()
	get_tree().paused = false

func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn") # for now
	# here requires a game restart function

func _on_game_manager_toggle_game_paused(is_paused):
	if is_paused:
		show()
		get_tree().paused = true
		
	else: 
		hide()
		get_tree().paused = false
