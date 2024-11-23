class_name Player extends CharacterBody3D

const WALK_SPEED = 5.0
const CROUCH_SPEED = 3.0
const CRAWL_SPEED = 1.0
const SPRINT_SPEED = 7.0
const JUMP_VELOCITY = 4.5
const GRAVITY = 9.8
@export var SENSITIVITY = 0.01
@export var BOB_FREQ = 2.0
@export var BOB_AMP = 0.11
var t_bob = 0.0
var input_axis 
var direction

@onready var head: Node3D = $head
@onready var camera_3d: Camera3D = $head/Camera3d
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shape_cast_3d: ShapeCast3D = $ShapeCast3D
@onready var actionable_area: Area3D = $ActionableArea

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera_3d.rotate_x(-event.relative.y * SENSITIVITY)
		camera_3d.rotation.x = clamp(camera_3d.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		
func _physics_process(delta: float) -> void:
	handle_movement(delta)
	handle_gravity(delta)
	if shape_cast_3d.is_colliding():
		var collider = shape_cast_3d.get_collider(0)
		print(collider)
	if Input.is_action_just_pressed('action'):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED
	
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera_3d.transform.origin = handle_bob(t_bob)
	move_and_slide()
	
func handle_gravity(delta: float):
	if !is_on_floor():
		velocity += get_gravity() * delta
	
func handle_movement(delta:float):
	input_axis = Input.get_vector("move_left", "move_right", "move_foward", "move_backwards")
	direction = (head.transform.basis * Vector3(input_axis.x, 0, input_axis.y)).normalized()

func handle_bob(time) -> Vector3: 
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos


func _on_actionable_area_area_entered(area: Area3D) -> void:
	if area.is_in_group('rope'):
		print('hey')
