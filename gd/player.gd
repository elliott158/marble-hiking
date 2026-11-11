extends RigidBody3D

var SPEED: float = 50
var LINEAR_SPEED: float = 50

var linear_force = Vector3()
var torque = Vector3()
@export var camera_parent: Node3D

@onready var face: MeshInstance3D = $face

func _ready() -> void:
	if camera_parent == null:
		push_error("camera_parent is null. please set.")

func _process(_delta: float):
	# runs every frame, cosmetics and such
	face.global_rotation = camera_parent.get_child(0).global_rotation

func _physics_process(_delta: float):
	apply_force(Vector3())
	
	# rolling
	var input_dir := Input.get_vector("right","left","up","down")
	var direction := (Vector3(input_dir.y, 0, input_dir.x)).normalized()
	
	# match direction to camera
	direction = direction.rotated(Vector3.UP, camera_parent.get_child(0).global_rotation.y)
	torque = direction*SPEED

	apply_torque(torque)
	
	# mid-air movement and extra control
	
	# get linear force
	linear_force = Vector3(-input_dir.x,0,input_dir.y).rotated(Vector3.UP, camera_parent.get_child(0).global_rotation.y) * LINEAR_SPEED
	apply_force(linear_force)
