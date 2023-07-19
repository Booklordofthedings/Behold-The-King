extends Node
@export var curve : Curve
@export var toSpawn : PackedScene
@export var lbl : Label
var timer = 1;
var spawn_timer = 0

func _ready():
	get_node("/root/Scorekeeper").start_scoring()
	randomize()


var stunned_tween : Tween

func _process(delta):
	spawn_timer += delta
	lbl.text = str(round(get_node("/root/Scorekeeper").score))
	
	if timer <= 0:
		timer = curve.sample(min(spawn_timer/120,1))
		var spwn = toSpawn.instantiate()
		add_child(spwn)
	timer = timer - delta
