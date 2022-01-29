extends Node2D



func _on_Area2D_body_entered(body):
	if(body is Player):
		$KinematicBody2D.collision_layer = 0
		$KinematicBody2D.collision_mask = 0
		$DoorSprite/AnimationPlayer.play("DoorOpen")


func _on_Area2D_body_exited(body):
	if(body is Player):
		$KinematicBody2D.collision_layer = 1
		$KinematicBody2D.collision_mask = 1
		$DoorSprite/AnimationPlayer.play_backwards("DoorOpen")
