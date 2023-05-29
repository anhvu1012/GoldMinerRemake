extends Area2D

var move_gold = false
var claw

@export var value_smallGold = 300

@onready var receivedGold = $ReceivedGold

func _process(_delta):
	if move_gold:
		if claw.global_rotation >= 0.5:
			print("left")
			global_position.x = claw.global_position.x - 10
			global_position.y = claw.global_position.y + 20
			
		# --- Adjust position for Gold on the Right
		elif claw.global_rotation <= -0.5:
			global_position.x = claw.global_position.x + 10
			global_position.y = claw.global_position.y + 20
			
		# --- Normal Position for Gold in middle area
		else:
			global_position.x = claw.global_position.x
			global_position.y = claw.global_position.y + 20
		
		if global_position.y <= 210:
			GameManager.money += value_smallGold
			receivedGold.play()
			$CollisionPolygon2D.set_deferred("disabled", false)
			queue_free()

func _on_area_entered(area):
	move_gold = true
	claw = area
	$CollisionPolygon2D.set_deferred("disabled", true)

