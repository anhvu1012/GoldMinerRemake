extends Control

func _ready():
	hide()

func _on_resume_pressed():
	hide()
	get_tree().paused = false

func _on_quit_pressed():
	# reset variables
	GameManager.money = 0
	GameManager.current_level = 1
	
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	get_tree().paused = false

func _on_level_1_toggle_game_paused(is_paused):
	if is_paused:
		show()
		get_tree().paused = true
		
	else: 
		hide()
		get_tree().paused = false
