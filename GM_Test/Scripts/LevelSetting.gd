extends Label

func _process(_delta):
	self.text = "Level: " + str(GameManager.current_level)
