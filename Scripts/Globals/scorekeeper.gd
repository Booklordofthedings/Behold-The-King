extends Node

var score : float = 0
var doScore : bool = false



func barrel_destroyed():
	if doScore:
		score += 1

func start_scoring():
	doScore = true
	score = 0
	
func stop_scoring():
	doScore = false

func _process(delta):
	if doScore:
		score = score + delta / 2
