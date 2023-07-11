extends CharacterBody2D


@export var speed = 250
@export var hor_speed = 60
@export var barrier = 600
var direction = 1;

var knockback : Vector2 = Vector2(0,0)
var twen

func _physics_process(delta):
	
	var res = move_and_collide(Vector2(hor_speed * clamp( 1 -(position.x / barrier), 0, 1) * delta, direction * speed * delta) + knockback)
	
	if res:
		if res.get_collider_velocity().x != 0:
			twen = get_tree().create_tween()
			knockback = Vector2(-10, 0)
			twen.parallel().tween_property(self, "knockback", Vector2(), 0.3)
			res.get_collider().call("destroy")
		direction *= -1
