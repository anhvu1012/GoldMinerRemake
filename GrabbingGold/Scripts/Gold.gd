extends Area2D

var grabbed = false
var claw

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (grabbed):
		global_position.x = claw.global_position.x
		global_position.y = claw.global_position.y + 50


func destroy():
	queue_free()
	
	

func _on_area_entered(area):
	grabbed = true
	claw = area
	$DespawnTimer.start(4.0)


func _on_despawn_timer_timeout():
	destroy()
