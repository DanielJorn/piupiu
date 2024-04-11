extends CharacterBody2D

@onready var body = $body
@onready var gun = $gun
@onready var ship = $ship

@export var speed = 400
@export var rotation_speed = 1.5

var rotation_direction = 0

func get_input():
	rotation_direction = Input.get_axis("left", "right")
	velocity = transform.y * Input.get_axis("up", "down") * speed

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()

func _ready():
	pass

func _process(delta):
	pass
