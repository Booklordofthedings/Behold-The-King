@tool
extends HBoxContainer

@export var text : String = ""
@export var image : Texture2D = load("res://Assets/Sprites/Common/coin.png")

var TextLabel : Label
var txt : TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	TextLabel = get_child(1)
	txt = get_child(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	TextLabel.text = text
	txt.texture = image
