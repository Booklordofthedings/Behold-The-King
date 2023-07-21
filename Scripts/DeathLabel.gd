extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(int(get_node("/root/DataStore").read("coins", 0))-int(get_node("/root/Scorekeeper").score)) + " + " + str(int(get_node("/root/Scorekeeper").score))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
