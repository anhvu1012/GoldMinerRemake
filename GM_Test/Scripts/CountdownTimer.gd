extends Control

var timer_label: Label

func _ready():
	timer_label = get_node("CountDownTimer")
	$Timer.start()
	
func _process(_delta):
	#print($Timer.time_left)
	update_timer_label()

func update_timer_label():
	if $Timer.time_left < 10:
		timer_label.text = "Time: "+ "00:0" + str(int($Timer.time_left))
	else:
		timer_label.text = "Time: "+ "00:" + str(int($Timer.time_left))

func _on_timer_timeout():
	# Disable active Power-Ups
	GameManager.energy_drink = false
	GameManager.stonks = false
	
	if GameManager.money >= GameManager.goal: # move to outro scene and shop
		get_tree().change_scene_to_file("res://Scenes/outro_level.tscn")
	else: 
		get_tree().change_scene_to_file("res://Scenes/goal_not_reached.tscn")
