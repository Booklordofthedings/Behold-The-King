extends CharacterBody2D

@export var speed : float = 10
@export var attack : Area2D
@export var ability : TextureProgressBar
@export var dash_abilit : TextureProgressBar
@export var toRotate : Sprite2D
@export var projectile : PackedScene
var tween : Tween
var dash : Tween
var dash_timer = 100
var timer = 100

var attack_timer = 1

func _ready():
	var q = get_node("/root/DataStore").read("quick_attack",false)
	if q:
		attack_timer = 0.5
	position.x = 500
	position.y = 300

	
func _physics_process(delta):
	var mov = Input.get_vector("player_left","player_right","player_up","player_down").normalized()
	velocity = mov * speed * delta * 100
	move_and_slide()
	if position.x < 0:
		position.x = 0
		
	ability.value = timer
	dash_abilit.value = dash_timer
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
		
		toRotate.rotation = 0
		tween = get_tree().create_tween()
		timer = 0
		tween.parallel().tween_property(self, "timer", 100, attack_timer)
		tween.parallel().tween_property(toRotate, "rotation_degrees", 90, 0.1)
		
		var to_instantiate = projectile.instantiate()
		owner.add_child(to_instantiate)
		to_instantiate.position = global_position
		
	if Input.is_action_just_pressed("player_dash") and dash_timer == 100:
		dash_timer = 0
		var base_speed =  speed
		speed = speed * 4
		dash = get_tree().create_tween()
		dash.parallel().tween_property(self, "speed", base_speed, 0.3)
		dash.parallel().tween_property(self, "dash_timer", 100, 3)
		
		
		
		
		
		
func attack_end():
	attack.visible = false
	attack.monitoring = false
		
