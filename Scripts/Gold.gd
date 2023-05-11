extends Area2D

var grabbed = false
var claw

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (grabbed):
		global_position.x = claw.global_position.x
		global_position.y = claw.global_position.y + 50
		#print(global_position.y)
		if global_position.y <= 200:
			var rng = RandomNumberGenerator.new()
			Money.money += rng.randi_range(10, 30)
			queue_free()
	
func _on_area_entered(area):
	grabbed = true
	claw = area
	

