extends Label

func _process(_delta):
	self.text = "Level: " + "1" #for now, later it will be GameManager.current_level
