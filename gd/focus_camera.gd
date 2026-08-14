extends Node3D

@export var focus: Node3D
@export var mouse_sensitivity: float = 0.005
@export var zoom: float = 4
@export var fov: int = 80

@onready var arm = $SpringArm3D
@onready var camera = $SpringArm3D/camera

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	arm.spring_length = zoom
	camera.fov = fov

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		arm.rotation.y -= event.relative.x * mouse_sensitivity
		arm.rotation.x -= event.relative.y * mouse_sensitivity
	if event.is_action_pressed("mouse_lock_toggle"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(_delta: float) -> void:
	camera.look_at(focus.position)
	arm.position = focus.position
