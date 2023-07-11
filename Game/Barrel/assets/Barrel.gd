extends CharacterBody2D

@export var speed = 200;
@export var sprite : Sprite2D

func _ready():
	position.x = 800
	position.y = 50 + randi() % 200

func _physics_process(delta):
	if position.x < -50:
		queue_free()
	var res = move_and_collide(Vector2(-speed * delta, 0))
	sprite.rotate(-1 * delta)

func destroy():
	queue_free()
