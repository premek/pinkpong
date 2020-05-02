extends KinematicBody2D

signal hit

func _on_Zone_hit():
	$HitSound.play()
