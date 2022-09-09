extends Label

func _process(delta):
	self.text = "kills " + str(Globals.enemies_killed) + "/" + str(Globals.enemies_total)
	
