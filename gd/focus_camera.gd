extends Node3D

@export var focus: Node3D
@export var mouse_sensitivity: float = 0.005
@export var zoom: float = 5
@export var fov: int = 80

@export_range(-90.0, 0.0, 0.1, "radians_as_degrees") var min_vertical_angle: float = -PI/3
@export_range(0.0, 90.0, 0.1, "radians_as_degrees") var max_vertical_angle: float = PI/4

@onready var arm = $SpringArm3D
@onready var camera = $SpringArm3D/camera

const max_zoom: int = 15
const min_zoom: int = 3

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	arm.spring_length = zoom
	camera.fov = fov

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		arm.rotation.y -= event.relative.x * mouse_sensitivity
		arm.rotation.y = wrapf(arm.rotation.y, 0.0, TAU)
		
		arm.rotation.x -= event.relative.y * mouse_sensitivity
		arm.rotation.x = clamp(arm.rotation.x, min_vertical_angle, max_vertical_angle)
	if event.is_action_pressed("mouse_lock_toggle"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("zoom_out"):
		if (arm.spring_length + 1 ) <= max_zoom:
			arm.spring_length += 1
	if event.is_action_pressed("zoom_in"):
		if (arm.spring_length - 1) >= min_zoom:
			arm.spring_length -= 1

func _process(_delta: float) -> void:
	camera.look_at(focus.position)
	arm.position = focus.position
