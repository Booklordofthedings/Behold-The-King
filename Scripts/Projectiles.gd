extends CharacterBody2D

func _physics_process(delta):
	rotate(15 * delta)
	var res  = move_and_collide(Vector2(200 * delta,0))
	if res:
		res.get_collider().call("destroy")
		queue_free()
	if position.x > 670:
		queue_free()
