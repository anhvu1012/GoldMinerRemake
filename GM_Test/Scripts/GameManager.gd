extends Node2D

var current_level = 0
var money = 0
var goal = 0

var current_play_node: String

var game_paused: bool = false

signal toggle_game_paused(is_paused : bool)

func _process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		game_paused = !game_paused
		toggle_game_paused.emit(game_paused)


func _on_pause_pressed():
	game_paused = true
	toggle_game_paused.emit(game_paused)
