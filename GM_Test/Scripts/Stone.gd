extends Area2D

var move_stone = false
var claw

@export var value_stone = 50

@onready var receivedStone = $ReceivedStone

func _process(_delta):
	if move_stone:
		if claw.global_rotation >= 0.5:
			global_position.x = claw.global_position.x - 30
			global_position.y = claw.global_position.y + 30
			
		# --- Adjust position for Stone on the Right
		elif claw.global_rotation <= -0.5:
			global_position.x = claw.global_position.x + 30
			global_position.y = claw.global_position.y + 30
			
		# --- Normal Position for Stone in middle area
		else:
			global_position.x = claw.global_position.x
			global_position.y = claw.global_position.y + 40
		
		if global_position.y <= 210:
			move_stone = false
			GameManager.money += value_stone
			#$CollisionPolygon2D.set_deferred("disabled", false)
			$Sprite2D.visible = false
			
			receivedStone.play() # --- TODO: Possibly use another received Sound?
			# Stop script until sound is completed
			await $ReceivedStone.finished

func _on_area_entered(area):
	if (area.is_in_group("Claw")):
		move_stone = true
		claw = area
		$CollisionShape2D.set_deferred("disabled", true)
		
	elif (area.is_in_group("TNT_Explosion")):
		queue_free()
