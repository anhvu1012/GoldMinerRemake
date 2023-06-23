extends Area2D

# hook variables
# useful when picked up different objects with different weights
var initial_move_speed 
var claw_max_depth = 550
var hook_depth
var hook_direction = 1
@export var hook_drop_speed = 500
@export var hook_drop_speed_BigGold = 200
@export var hook_drop_speed_NormalGold = 350
@export var hook_drop_speed_Stone = 225

var rope_position
var hook_move_down = false
var hook_move_up = false
var pulled_gold = false

var claw_position 

@onready var rope = get_parent().get_parent().get_node("Rope")
@onready var foundGold = $found_gold_sound
@onready var foundStone = $found_stone_sound # TODO
@onready var foundDiamond = $found_diamond_sound # TODO


signal hook_move_down_status(is_moving_down: bool)

# called when start
func _ready():
	# -- Check for active Power-Ups --
	if GameManager.energy_drink:
		print("Energy Drink activated")
		hook_drop_speed += 200
		hook_drop_speed_BigGold += 200
		hook_drop_speed_NormalGold += 200
		hook_drop_speed_Stone += 200
		
	rope_position = rope.position
	#print(rope_position)
	initial_move_speed = hook_drop_speed
	hook_depth = rope.position.y
	#print(hook_depth)

func _process(delta):
	claw_position = Vector2(position.x, position.y)
	#check_InPut()
	if hook_move_down:
		move_Rope_Down(delta)
	check_Claw_out_of_Bound()
	
	#reset claw move speed
	#hook_drop_speed = initial_move_speed
	
	if not hook_move_down and hook_move_up:
		move_Rope_Up(delta)

	check_Reach_the_Ground()
	
func check_InPut():
	if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_accept"):
		hook_drop_speed = initial_move_speed # Reset drop speed
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
		check_InPut()
		
# Function checking for collision
func _on_area_entered(area):
	if (area.is_in_group("Big_Gold")):
		# Speed for Big Gold
		hook_drop_speed = hook_drop_speed_BigGold
		hook_move_down = false
		hook_move_up = true
		$CollisionShape2D.set_deferred("disabled", true)
		foundGold.play()
		print("Found Gold!")
		
	elif (area.is_in_group("Normal_Gold")):
		# Speed for Normal Gold
		hook_drop_speed = hook_drop_speed_NormalGold
		hook_move_down = false
		hook_move_up = true
		$CollisionShape2D.set_deferred("disabled", true)
		foundGold.play()
		print("Found Gold!")
		
	elif (area.is_in_group("Small_Gold")):
		hook_move_down = false
		hook_move_up = true
		$CollisionShape2D.set_deferred("disabled", true)
		foundGold.play()
		print("Found Gold!")
		
	elif (area.is_in_group("Stone") or area.is_in_group("MoneyBag")):
		# Speed for Stone
		hook_drop_speed = hook_drop_speed_Stone
		hook_move_down = false
		hook_move_up = true
		$CollisionShape2D.set_deferred("disabled", true)
		foundStone.play() # --- TODO: Add "fail" sound for grabbing stone
			
	elif (area.is_in_group("Diamond")):
		hook_move_down = false
		hook_move_up = true
		$CollisionShape2D.set_deferred("disabled", true)
		foundDiamond.play() # --- TODO: Add "success" sound for grabbing diamond
		
	elif (area.is_in_group("TNT")):
		hook_move_down = false
		hook_move_up = true
