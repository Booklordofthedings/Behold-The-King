extends CharacterBody2D
# Behaviour Regarding the king

@export var speed = 250
@export var hor_speed = 60
@export var barrier = 600
@export var player : AudioStreamPlayer
var direction = 1;

func _ready():
	var l = get_node("/root/DataStore").read("less_stun", false)
	if l:
		stun_time = 0.3
	var r = get_node("/root/DataStore").read("more_right", false)
	if not r:
		barrier = 500
	var k = get_node("/root/DataStore").read("less_knockback", false)
	if k:
		stunned_knockback  = 450

func _physics_process(delta):
	stunned_sprite.modulate.a = stunned_alpha
	var res = move_and_collide(
		Vector2( hor_speed * clamp( 1 -(position.x / barrier), 0, 1) * delta, direction * speed * delta) if stunned_alpha == 0 else Vector2(0,0)
			+ _stunned_knockback * delta * -1)
	
	if res:
		on_knockback(res)
	
	if position.x < -20:
		get_node("/root/Scorekeeper").stop_scoring()
		get_tree().change_scene_to_file("res://Scenes/DeathMenu.tscn")


@export_group("Knockback Settings")
## How long the king will be knocked back for
@export var knockback_time : float = 0.3
## How long the king will stay stunned after a collision
@export var stun_time : float = 0.6
## How much the user will be knocked back
@export var stunned_knockback : float = 650
## The stunned Sprite/Animation
@export var stunned_sprite : Sprite2D

var stunned_alpha : float = 0
var _stunned_knockback : Vector2 = Vector2(0,0)
var stunned_tween : Tween

# Does stunning and knocking back
func on_knockback(res):
	if res.get_collider_velocity().x !=0:
		player.play()
		#Handles the stunning and knockback over time
		stunned_tween = get_tree().create_tween();
		_stunned_knockback = Vector2(stunned_knockback,0)
		stunned_alpha = 1
		stunned_tween.parallel().tween_property(self, "_stunned_knockback", Vector2(), knockback_time)
		stunned_tween.parallel().tween_property(self, "stunned_alpha", 0, stun_time)
		#Destroys the object the king collided with
		res.get_collider().call("destroy")
	direction *= -1 #Turn around
	
