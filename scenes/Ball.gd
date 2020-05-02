extends KinematicBody2D

signal hit

export var speed = 400
var velocity = Vector2()
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * speed * delta)
	if collision:
		emit_signal("hit")
		velocity = velocity.bounce(collision.normal)
		#$CollisionShape2D.disabled = true
		collision.collider.emit_signal("hit") # emit the other object's hit signal

func start(pos):
	position = pos
	enable_collisions()

func enable_collisions():
	$CollisionShape2D.disabled = false
