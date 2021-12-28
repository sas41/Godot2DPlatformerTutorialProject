extends Area2D
class_name Coin

func _on_Coin_body_entered(body):
	if(body is Player):
		(body as Player).coins += 1
		self.queue_free()
