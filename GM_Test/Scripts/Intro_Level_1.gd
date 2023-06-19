extends Node2D

func _ready():
	# Start the timer countdown
	$Timer.start()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
