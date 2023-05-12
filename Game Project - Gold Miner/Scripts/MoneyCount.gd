extends Label

func _process(_delta):
	self.text = "Money: " + str(Money.money)
