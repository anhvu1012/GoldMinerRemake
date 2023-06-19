extends Node2D

func _ready():
	# Start the timer countdown
	$Timer.start()

func _on_timer_timeout():
	# reset variables
	GameManager.money = 0
	GameManager.current_level = 1
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
