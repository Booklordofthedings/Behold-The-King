extends Node

@export var toSpawn : PackedScene
@export var lbl : Label
var timer = 1;

func _ready():
	get_node("/root/Scorekeeper").start_scoring()
	randomize()

func _process(delta):
	lbl.text = str(round(get_node("/root/Scorekeeper").score))
	
	if timer < 0:
		timer = 0.2
		var spwn = toSpawn.instantiate()
		add_child(spwn)
	timer = timer - delta
