extends Control

@export var coin_label : Label

func _ready():
	var coins = get_node("/root/DataStore").read("coins", 0)
	coin_label.text = str(int(coins))
