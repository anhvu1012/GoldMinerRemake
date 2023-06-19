extends Node2D

var current_level = 1
var money = 0
var goal: int

# Shop Items
var energy_drink = false
var stonks = false

var current_play_node: String

func _process(_delta):
	if current_level == 1:
		goal = 5000
	elif current_level == 2:
		goal = 10000
