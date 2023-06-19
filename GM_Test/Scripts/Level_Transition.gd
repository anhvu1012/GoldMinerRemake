extends Node2D

var game_paused: bool = false

signal toggle_game_paused(is_paused : bool)

func _process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		game_paused = !game_paused
		toggle_game_paused.emit(game_paused)

func _on_pause_pressed():
	game_paused = true
	toggle_game_paused.emit(game_paused)

func _on_skip_level_pressed():
	# Disable active Power-Ups
	GameManager.energy_drink = false
	GameManager.stonks = false
	
	if GameManager.money >= GameManager.goal: # move to outro scene and shop
		get_tree().change_scene_to_file("res://Scenes/outro_level.tscn")
	else: 
		get_tree().change_scene_to_file("res://Scenes/goal_not_reached.tscn")
