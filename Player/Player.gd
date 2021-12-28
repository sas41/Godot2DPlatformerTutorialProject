extends KinematicBody2D
class_name Player

export(float) var mass = 20
export(float) var movement_speed = 450
export(float) var acceleration_time = 0.35
export(float) var deceleration_time = 0.25
export(float) var jump_strength = 500
export(int) var jump_count = 2

onready var coins = 0
onready var momentum = Vector2()
onready var direction = 1
onready var jumps_left = jump_count

func _ready():
	pass

func _physics_process(delta):
	
	momentum += horizontal_movement(delta)
	momentum += gravity(delta)
	
	if(self.is_on_floor()):
		jumps_left = jump_count
		
	if(can_jump()):
		jumps_left = jumps_left - 1
		momentum.y = Vector2.UP.y * jump_strength
	
	momentum = clamp_x(momentum, movement_speed)
	
	momentum = self.move_and_slide(momentum, Vector2.UP)
	pass

func horizontal_movement(delta):
	var going_left = Input.is_action_pressed("ui_left")
	var going_right = Input.is_action_pressed("ui_right")
	
	var movement_direction = Vector2()
	if(going_left):
		movement_direction.x += -movement_speed
		direction = -1
	if(going_right):
		movement_direction.x += movement_speed
		direction = 1
		
	var deceleration_ratio = delta * (1.0 / deceleration_time)
	var acceleration_ratio = delta * (1.0 / acceleration_time)
	
	var step = movement_direction * acceleration_ratio
	
	# Not moving if vector length is 0
	if(movement_direction.length() == 0):
		var reverse_dir = Vector2(momentum.x, 0) * -1
		var deceleration_length = movement_speed * deceleration_ratio
		var horizontal_length = reverse_dir.length()
		var effective_length = min(horizontal_length, deceleration_length)
		step = reverse_dir.normalized() * effective_length
	
	return step

func gravity(delta):
	var gravityVec = Vector2()
	if(self.is_on_floor() == false):
		if(momentum.y < 0 && Input.is_action_pressed("ui_up")):
			gravityVec = Vector2(0, 98 * mass/2.5)
		else:
			gravityVec = Vector2(0, 98 * mass)
	
	return gravityVec * delta

func can_jump():
	var have_jumps = jumps_left > 0
	var is_pressing_jump = Input.is_action_just_pressed("ui_up")
	return have_jumps && is_pressing_jump

func clamp_x(input_vector, max_length):
	var final = Vector2(input_vector.x, 0)
	if(final.length() > max_length):
		final = final.normalized() * max_length
	final.y = input_vector.y
	return final



func _process(delta):
	if (direction == -1):
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false

	if (momentum.length() < 0.01):
		set_animation("idle")
	elif (abs(momentum.y) < 0.01):
		if (sign(direction) != sign(momentum.x)):
			set_animation("skid")
		else:
			set_animation("walk")
	else:
		set_animation("jump")


func set_animation(animation):
	if ($AnimatedSprite.animation != animation):
		$AnimatedSprite.animation = animation
