extends Area2D

var speed = 1000

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body):
	if not body.is_in_group("player"):
		body.queue_free()
		queue_free()
