extends Area2D

var explosionParticle = preload("res://Scenes/TNT_Explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func explode():
	var _particle = explosionParticle.instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)

func _on_area_entered(area):
	if (area.is_in_group("Claw")):
		# Start Timer; Delete object in .5s
		$ExplosionTimer.start(0.5)
		$Sprite2D.visible = false
		# enable explosion hitbox, disble TNT hitbox
		$ExplosionHitbox/Collision_Explosion.set_deferred("disabled", false)
		$Collision_TNT.set_deferred("disabled", true)
		# play explosion animation
		explode()


func _on_explosion_timer_timeout():
	queue_free()
