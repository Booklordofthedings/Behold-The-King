extends CharacterBody2D

@export var speed : float = 10
@export var attack : Area2D
@export var ability : TextureProgressBar
var tween : Tween
var timer = 100

func _ready():
	position.x = 500
	position.y = 300

	
func _physics_process(delta):
	var mov = Input.get_vector("player_left","player_right","player_up","player_down").normalized()
	velocity = mov * speed * delta * 100
	move_and_slide()
	if position.x < 0:
		position.x = 0
		
	ability.value = timer
	if Input.is_action_just_pressed("player_action") and timer == 100:
		#Attack 
		attack.visible = true
		attack.monitoring = true
		var _timer = Timer.new()
		add_child(_timer)
		_timer.wait_time = 0.1
		_timer.one_shot = true
		_timer.start()
		_timer.timeout.connect(attack_end)
		
		
		tween = get_tree().create_tween();
		timer = 0
		tween.parallel().tween_property(self, "timer", 100, 1.2)
		
		
func attack_end():
	attack.visible = false
	attack.monitoring = false
		
