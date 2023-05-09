extends Area2D

var grabbed = false
var claw

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (grabbed):
		# --- Adjust position for Gold on the Left
		# harcdcoded values for rotation, sorry
		# tried accurate grabbing with help of PinJoint-Node but no success :( me dumb
		# may be overkill tho
		if claw.global_rotation >= 0.5:
			print("left")
			global_position.x = claw.global_position.x - 30
			global_position.y = claw.global_position.y + 30
			
		# --- Adjust position for Gold on the Right
		elif claw.global_rotation <= -0.5:
			global_position.x = claw.global_position.x + 30
			global_position.y = claw.global_position.y + 30
			
		# --- Normal Position for Gold in middle area
		else:
			global_position.x = claw.global_position.x
			global_position.y = claw.global_position.y + 40
			
		# --- Delete Gold/Add money when claw reaches inital pos
		# kinda hardcoded, maybe get initial pos of claw before? 
		# but reference to claw is only aquired on collision so too late...
		if global_position.y <= 200:
			var rng = RandomNumberGenerator.new()
			Money.money += rng.randi_range(10, 30)
			queue_free()

func _on_area_entered(area):
	grabbed = true
	claw = area
