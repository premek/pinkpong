extends KinematicBody2D

signal hit
signal score

export var maxspeed = 800
export var score = 0
var speed = 0
	
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):

	if Input.is_action_pressed("ui_down"):
		speed += 0.2
	if Input.is_action_pressed("ui_up"):
		speed -= 0.2
		
	speed *= 0.8
		
	position.y += clamp(speed*maxspeed, -maxspeed, maxspeed) * delta
	position.y = clamp(position.y, 50, screen_size.y - 50)

func goal():
	score = score + 1
	emit_signal("score")
	


func _on_Player_hit():
	$HitSound.play()
