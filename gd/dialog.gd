extends Node3D

@export var text: String = ""
@onready var dialog = preload("res://scenes/dialog.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().root.add_child.call_deferred(dialog.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
