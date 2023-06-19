extends Node2D

@export var price_energy = 150
@export var price_stonks = 400

# For now
func _on_skip_level_pressed():
	GameManager.current_level += 1
	
	if GameManager.current_level == 2: 
		get_tree().change_scene_to_file("res://Scenes/intro_level_2.tscn")
	elif GameManager.current_level == 3: 
		get_tree().change_scene_to_file("res://Scenes/intro_level_3.tscn")


func _on_energy_drink_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		if GameManager.money >= price_energy:
			GameManager.energy_drink = true
			GameManager.money -= price_energy
			$Items/EnergyDrink_Area/EnergySprite.visible = false
			$Items/EnergyDrink_Area/Energy_Label.visible = false
			$Items/EnergyDrink_Area/Energy_CollisionShape2D.disabled = true
			$BuyingItems.play()

func _on_stonks_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		if GameManager.money >= price_stonks:
			GameManager.stonks = true
			GameManager.money -= price_stonks
			$Items/Stonks_Area/StonksSprite.visible = false
			$Items/Stonks_Area/Stonks_Label.visible = false
			$Items/Stonks_Area/Stonks_CollisionShape2D.disabled = true
			$BuyingItems.play()
