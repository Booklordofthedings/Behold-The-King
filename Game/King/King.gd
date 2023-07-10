extends CharacterBody2D


@export var speed = 750
var direction = 1;

func _physics_process(delta):
	var res = move_and_collide(Vector2(100 * delta if position.x < 800 else 0, direction * speed * delta))
	
	if res:
		direction *= -1
