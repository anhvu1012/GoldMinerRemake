extends Label

@export var money = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	# Script is currently in Autoload (Project -> Project Settings -> Autoload)
	# that's why I adjust the values here
	# TODO: Maybe Interface scene can be put in Autload too?
	position.x = 15
	position.y = 15
	add_theme_font_size_override("font_size", 30)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# update Label text on runtime
	text = "Money: %s" % money
