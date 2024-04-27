extends Area2D

var speed = 1000
@onready var visibility_notifier = $VisibilityNotifier
@onready var death_timer = $DeathTimer

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body):
	if not body.is_in_group("player"):
		body.queue_free()
		queue_free()

func _on_visibility_notifier_screen_exited():
	death_timer.start(1)

func _on_death_timer_timeout():
	print("deleting bullet")
	queue_free()
