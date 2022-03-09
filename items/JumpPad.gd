extends Area2D


func _on_JumpPad_body_entered(body):
	print("body entered")
	$AnimationPlayer.play("boost")
	body.boost()
