extends CharacterBody2D

@onready var body = $body
@onready var gun = $gun
@onready var ship = $ship
@onready var gun_tip = $gun/gun_tip
@onready var shoot_timer = $shoot_timer
#@onready var colider = $colider as CollisionPolygon2D

@export var speed = 100
@export var rotation_speed = 0
@export var cannonball : PackedScene
@export var fire_rate = 0.5

var rotation_direction = 0
var gunRotationDegrees = 0
var can_shoot = true


func _draw():
	draw_line(to_local(gun_tip.global_position), get_local_mouse_position(), Color.BLACK, 5)


func _on_body_entered(body):
	body.queue_free()
	queue_free()


func get_input():
	gunRotationDegrees = rad_to_deg(
			to_local(gun.global_position)
			.angle_to_point(get_local_mouse_position())
	)
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot()
		shoot_timer.wait_time = fire_rate
		shoot_timer.start()
		shoot_timer.timeout.connect(set_can_shoot)
		can_shoot = false
		print("shooot")
	
	var forwardDrive = Input.get_axis("down", "up")
	# if w pressed, move with double speed; if no Input, then assign 1
	if forwardDrive == 1:
		forwardDrive = 2
	elif forwardDrive == 0:
		forwardDrive = 1
	var inertia = 0.95
	velocity = velocity * inertia + (transform.x * forwardDrive * speed) * (1 - inertia)
	
	var rotationDrive = Input.get_axis("left", "right")
	var rotation_inertia = 0.5
	var mov_impact = 1
	var base_rotation_speed = 1
	rotation_direction = rotationDrive * sign(forwardDrive)
	rotation_speed =\
		rotation_speed * rotation_inertia\
		+ velocity.length() / speed * mov_impact\
		+ base_rotation_speed


func set_can_shoot():
	can_shoot = true
	print("can shot true")


func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	gun.rotation_degrees = gunRotationDegrees
	
	move_and_slide()
	queue_redraw()


func shoot():
	var b = cannonball.instantiate()
	owner.add_child(b)
	b.transform = $gun/gun_tip.global_transform
