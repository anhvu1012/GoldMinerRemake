extends Area2D

var grabbed_Gold = false

# claw variables
@export var claw_rotate_speed = 50
var claw_direction = 1
@export var claw_range = 65
var claw_rotate_angle = 0
var can_rotate = true

# hook variables
# useful when picked up different objects with different weights
var initial_move_speed 
@export var hook_max_depth = 500
var hook_depth = 0
var hook_direction = 1
@export var hook_drop_speed = 200
var hook_move_down = false

# called when start
func _ready():
	hook_depth = position.y
	print(position.x," ", position.y)
	initial_move_speed = hook_drop_speed

func _process(delta):
	custom_rotate(delta)
	get_input()
	MoveRope(delta)
		
func custom_rotate(delta):
	if not can_rotate: # if not rotate atm, exist func
		return

	claw_rotate_angle += claw_direction * claw_rotate_speed * delta
	if abs(claw_rotate_angle) > claw_range:
		claw_direction *= -1
	# rotate by rotate_angle on z axis
	set_rotation_degrees(claw_rotate_angle)

# check if down arrow pressed => stop rotating, start moving down
func get_input(): 
	if Input.is_action_just_pressed("ui_down") and can_rotate and not hook_move_down:
		can_rotate = false
		hook_move_down = true
		hook_direction = 1
		print("down")
	
func MoveRope(delta):
	if can_rotate: # if rotating, exist func
		return

	if !can_rotate: 
		var hook_position = position

		if hook_move_down:
			hook_position += transform.y * hook_direction * hook_drop_speed * delta
			
			if hook_position.y >= hook_max_depth or hook_position.x >= 1050 or hook_position.x <= 100 or grabbed_Gold:
				hook_direction *= -1
				
			if hook_position.y <= hook_depth:
				hook_move_down = false
				can_rotate = true
				hook_drop_speed = initial_move_speed
			set_position(hook_position)


# Function checking for collision
func _on_area_entered(area):
	if (area.is_in_group("Gold")):
		grabbed_Gold = true
		print("Found Gold!")


		
