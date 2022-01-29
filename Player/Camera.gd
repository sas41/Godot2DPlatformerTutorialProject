extends Node2D

export(Vector2)var max_distance = Vector2(50, 50)
var player : Player = null

func _ready():
	player = get_parent() as Player
	print_debug(player.position)
	print_debug(self.position)
	pass

func _physics_process(delta):
	var momentum_without_y = player.momentum
	momentum_without_y.y = 0
	
	var target_position = momentum_without_y
	var momentum_length = momentum_without_y.length()
	
	if (momentum_length > max_distance.length()):
		target_position = momentum_without_y.normalized() * max_distance
	
	self.position = target_position
