extends Line2D

@export var first_target: Node2D
@export var second_target: Node2D

func _ready():
	first_target = get_parent().get_parent().get_node("Rope")
	second_target = get_parent().get_node("Claw")
	
	points = [ Vector2.ZERO, Vector2.ZERO]
	
func _process(_delta):
	if is_instance_valid(first_target) and is_instance_valid(second_target):
		points[0] = to_local(first_target.global_position)
		points[1] = to_local(second_target.global_position)
