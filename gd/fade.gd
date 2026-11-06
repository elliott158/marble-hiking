extends Control

@export var label: Label
@export var text: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not label:
		assert(false, "Label not set, aborting.")
	label.text = text
	label.modulate = Color(1,1,1,0)
	var fade = get_tree().create_tween()
	fade.tween_property(label, "modulate", Color(1,1,1,1), 4)
	fade.tween_property(label, "modulate", Color(1,1,1,0), 4)
	fade.tween_callback(queue_free)
