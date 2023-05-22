extends Node2D

@export var claw_rotate_speed = 100
var claw_direction = 1
@export var claw_range = 70
var claw_rotate_angle = 0
var can_rotate = true

func _process(delta):
	if can_rotate:
		custom_rotate(delta)
	#get_node("Line2D").set_point_position(0, position)
	#get_node("Line2D").set_point_position(1, claw.position)

func custom_rotate(delta):
	claw_rotate_angle += claw_direction * claw_rotate_speed * delta
	if abs(claw_rotate_angle) > claw_range:
		claw_direction *= -1
	# rotate by rotate_angle on z axis
	set_rotation_degrees(claw_rotate_angle)
	
func _on_claw_hook_move_down_status(is_moving_down):
	if is_moving_down:
		can_rotate = false
	else: 
		can_rotate = true
