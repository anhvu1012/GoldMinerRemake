extends Node2D

# For now
func _on_skip_level_pressed():
	get_tree().change_scene_to_file("res://Scenes/level_2.tscn")
