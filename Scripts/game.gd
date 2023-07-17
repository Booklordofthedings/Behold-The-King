extends Node

@export var toSpawn : PackedScene
@export var lbl : Label
var timer = 1;
var spawn_delay = 5

func _ready():
	get_node("/root/Scorekeeper").start_scoring()
	randomize()
	stunned_tween = get_tree().create_tween()
	stunned_tween.set_trans(Tween.TRANS_QUAD)
	stunned_tween.tween_property(self, "spawn_delay", 0.1, 40)


var stunned_tween : Tween

func _process(delta):
	lbl.text = str(round(get_node("/root/Scorekeeper").score))
	
	if timer < 0:
		timer = spawn_delay
		var spwn = toSpawn.instantiate()
		add_child(spwn)
	timer = timer - delta
