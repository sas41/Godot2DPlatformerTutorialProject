extends Area2D
class_name PowerupExtraJump

var jumps_to_add = 2
var owning_player : Player = null

func _on_PowerupExtraJump_body_entered(body):
	if(body is Player):
		owning_player = (body as Player)
		owning_player.jump_count += jumps_to_add
		$Timer.start()
		self.visible = false
		set_deferred("monitoring", false)
		set_deferred("monitorable", false)

func _on_Timer_timeout():
	if(owning_player != null):
		owning_player.jump_count -= jumps_to_add
		self.queue_free()
