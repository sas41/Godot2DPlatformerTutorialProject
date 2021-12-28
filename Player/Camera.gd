extends Node2D

export(Vector2)var max_distance = Vector2(200, 100)
var player : Player = null

func _ready():
	player = get_parent() as Player
	print_debug(player.position)
	print_debug(self.position)
	pass

func _physics_process(delta):
	var target_position = player.momentum
	var momentum_length = player.momentum.length()
	
	if (momentum_length > max_distance.length()):
		target_position = player.momentum.normalized() * max_distance
		
	self.position = target_position
