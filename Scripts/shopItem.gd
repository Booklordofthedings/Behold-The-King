@tool
extends PanelContainer

@export_group("Item Variables")
@export var id : String = "default"
@export var cost : int = 100
@export var title : String = "Pettable Dogs"
@export_multiline var description : String = "Makes dogs even more pettable"
@export var texture : Texture2D = load("res://Assets/Sprites/Common/x64.png")

@export_group("Intern")
@export var item_title_label : Label
@export var item_cost_label : Label
@export var item_description_label : Label
@export var item_icon : TextureRect
@export var item_unavailable : Panel
@export var sound : AudioStreamPlayer

var coins : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	item_icon.texture = texture
	item_title_label.text = title
	item_cost_label.text = str(cost)
	item_description_label.text = description
	try_retrieve_coins()
	if coins >= cost and not Engine.is_editor_hint():
		item_unavailable.visible = false
	if get_node("/root/DataStore").read(id, 0):
		visible = false
		
func _process(delta):
	if not Engine.is_editor_hint():
		if Input.is_action_just_pressed("player_action") and in_focus and coins >= cost:
			sound.play()
			get_node("/root/DataStore").write("coins", coins - cost)
			get_node("/root/DataStore").write(id,"1")
			get_tree().change_scene_to_file("res://Scenes/Shop.tscn")
	
func try_retrieve_coins():
	coins = get_node("/root/DataStore").read("coins", 0)


var in_focus : bool = false
func on_entered():
	in_focus = true
func on_exited():
	in_focus = false
