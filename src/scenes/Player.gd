extends CharacterBody2D

signal hit
signal score

@export var maxspeed = 800
@export var score1 = 0
var speed = 0
var screen_size
var dragging = false
var drag_radius = 180

func _ready():
	screen_size = get_viewport_rect().size


func _input(event):
	if event is InputEventScreenDrag and (event.position - position).length() < drag_radius:
		position.y = clamp(event.position.y, 50, screen_size.y - 50)

func goal():
	score1 = score1 + 1
	emit_signal("score")


func _on_Player_hit():
	$HitSound.play()
