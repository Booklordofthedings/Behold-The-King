extends Node

@export var toSpawn : PackedScene
var timer = 1;

func _ready():
	randomize()

func _process(delta):
	if timer < 0:
		timer = 0.2
		var spwn = toSpawn.instantiate()
		add_child(spwn)
	timer = timer - delta
