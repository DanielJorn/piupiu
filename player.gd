extends CharacterBody2D

# attaching script to Node allows us to read Node's children using $<child/deeper_child>
# onready is must have for some reason idk
@onready var body = $body
@onready var gun = $gun
@onready var ship = $ship
@onready var gun_tip = $gun/gun_tip

# export експортує в едітор змінні які ти можеш через ползунки мінять
@export var speed = 400
@export var rotation_speed = 1.5

var rotation_direction = 0
var gunRotationDegrees = 0

# функція CanvasItem яка малює. Ctrl + click щоб побачити доку
func _draw():
	# локальна позиція - відносно рутової ноди, глобальна - глобально лол
	# перевод в локальну з глобальної треба, бо повертаючи пушку, локально кординати дула залишаються такі ж
	draw_line(to_local(gun_tip.global_position), get_local_mouse_position(), Color.BLACK, 10)

func get_input():
	gunRotationDegrees = rad_to_deg(to_local(gun.global_position).angle_to_point(get_local_mouse_position()))
	rotation_direction = Input.get_axis("left", "right")
	velocity = transform.x * Input.get_axis("down", "up") * speed

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta

	move_and_slide()
	gun.rotation_degrees = gunRotationDegrees
	queue_redraw()

func _ready():
	pass

func _process(delta):
	pass
