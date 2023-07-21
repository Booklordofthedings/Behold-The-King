extends Node

var score : float = 0
var doScore : bool = false
var scoreMult = 0.5


func _ready():
	var pi = get_node("/root/DataStore").read("coins", 0)
	if pi:
		scoreMult = 0.8

func barrel_destroyed():
	if doScore:
		score += 0.2

func start_scoring():
	doScore = true
	score = 0
	
func stop_scoring():
	var coins = get_node("/root/DataStore").read("coins", 0)
	coins += int(score)
	get_node("/root/DataStore").write("coins", coins)
	
	var highscore = get_node("/root/DataStore").read("highscore", 0)
	if score < highscore:
		get_node("/root/DataStore").write("highscore", score)
	
	doScore = false

func _process(delta):
	if doScore:
		score = score + delta * scoreMult
