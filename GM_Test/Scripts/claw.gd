extends Area2D

# hook variables
# useful when picked up different objects with different weights
var initial_move_speed 
var claw_max_depth = 550
var hook_depth
var hook_direction = 1
@export var hook_drop_speed = 400
var rope_position
var hook_move_down = false
var hook_move_up = false
var pulled_gold = false

var claw_position 

@onready var rope = get_parent().get_parent().get_node("Rope")
@onready var foundGold = $found_gold_sound

signal hook_move_down_status(is_moving_down: bool)

# called when start
func _ready():
	rope_position = rope.position
	#print(rope_position)
	initial_move_speed = hook_drop_speed
	hook_depth = rope.position.y
	#print(hook_depth)

func _process(delta):
	claw_position = Vector2(position.x, position.y)
	check_InPut()
	if hook_move_down:
		move_Rope_Down(delta)
	check_Claw_out_of_Bound()
	
	if not hook_move_down and hook_move_up:
		move_Rope_Up(delta)

	check_Reach_the_Ground()
	
func check_InPut():
	if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_accept"):
		hook_move_down = true
		hook_move_down_status.emit(hook_move_down)
		
func move_Rope_Down(delta):
	claw_position += transform.y * hook_direction * hook_drop_speed * delta
	set_position(claw_position)

func check_Claw_out_of_Bound():
	#print(claw_position)
	if claw_position.y >= claw_max_depth:
		print("reached the ground")
		hook_move_down = false
		hook_move_up = true

func move_Rope_Up(delta):
	claw_position -= transform.y * hook_direction * hook_drop_speed * delta
	set_position(claw_position)
	
func check_Reach_the_Ground():
	#print(claw_position)
	if claw_position.y <= 0:
		$CollisionShape2D.set_deferred("disabled", false)
		hook_move_up = false
		hook_move_down_status.emit(hook_move_down) # now start rotate again
		
# Function checking for collision
func _on_area_entered(area):
	if (area.is_in_group("Gold")):
		hook_move_down = false
		hook_move_up = true
		$CollisionShape2D.set_deferred("disabled", true)
		foundGold.play()
		print("Found Gold!")
