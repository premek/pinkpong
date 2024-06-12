extends CharacterBody2D

signal hit

func _on_Wall_hit():
	$HitSound.play()
