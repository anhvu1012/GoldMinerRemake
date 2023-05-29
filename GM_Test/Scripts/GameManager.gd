extends Node2D

var money = 0

#func frameFreeze(timeScale, duration):
#	Engine.time_scale = timeScale
#	await get_tree().create_timer(duration * timeScale).timeout
#	Engine.time_scale = 1.0
