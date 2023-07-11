extends CharacterBody2D
# Behaviour Regarding the king

@export var speed = 250
@export var hor_speed = 60
@export var barrier = 600
var direction = 1;



func _physics_process(delta):
	stunned_sprite.modulate.a = stunned_alpha
	var res = move_and_collide(
		Vector2( hor_speed * clamp( 1 -(position.x / barrier), 0, 1) * delta, direction * speed * delta) if stunned_alpha == 0 else Vector2(0,0)
			+ _stunned_knockback * delta * -1)
	
	if res:
		on_knockback(res)


@export_group("Knockback Settings")
## How long the king will be knocked back for
@export var knockback_time : float = 0.3
## How long the king will stay stunned after a collision
@export var stun_time : float = 0.1
## How much the user will be knocked back
@export var stunned_knockback : float = 0
## The stunned Sprite/Animation
@export var stunned_sprite : Sprite2D

var stunned_alpha : float = 0
var _stunned_knockback : Vector2 = Vector2(0,0)
var stunned_tween : Tween

# Does stunning and knocking back
func on_knockback(res):
	if res.get_collider_velocity().x !=0:
		#Handles the stunning and knockback over time
		stunned_tween = get_tree().create_tween();
		_stunned_knockback = Vector2(stunned_knockback,0)
		stunned_alpha = 1
		stunned_tween.parallel().tween_property(self, "_stunned_knockback", Vector2(), knockback_time)
		stunned_tween.parallel().tween_property(self, "stunned_alpha", 0, stun_time)
		#Destroys the object the king collided with
		res.get_collider().call("destroy")
	direction *= -1 #Turn around
	
