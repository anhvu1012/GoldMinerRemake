extends Area2D

var move_diamond = false
var claw

@export var value_diamond = 1250

@onready var receivedDiamond = $ReceivedDiamond

func _ready():
	# -- Check for active Power-Ups --
	if GameManager.stonks:
		value_diamond *= 1.5

func _process(_delta):
	if move_diamond:
		if claw.global_rotation >= 0.5:
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
			move_diamond = false
			GameManager.money += value_diamond
			#$CollisionPolygon2D.set_deferred("disabled", false)
			$Sprite2D.visible = false
			
			receivedDiamond.play() # --- TODO: Possibly use another received Sound?
			# Stop script until sound is completed
			await receivedDiamond.finished
			queue_free()

func _on_area_entered(area):
	if (area.is_in_group("Claw")):
		move_diamond = true
		claw = area
		$CollisionPolygon2D.set_deferred("disabled", true)
		
	elif (area.is_in_group("TNT_Explosion")):
		queue_free()
