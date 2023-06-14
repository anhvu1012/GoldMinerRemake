extends Label

func _process(_delta):
	self.text = "Goal: " + str(GameManager.goal) #for now, later it will be GameManager.goal
