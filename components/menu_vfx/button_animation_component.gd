class_name ButtonAnimationComponent
extends Node


@export_category("Animation")
@export var from_center: bool = true
@export var duration: float = 0.2
@export var transition_type: Tween.TransitionType = Tween.TRANS_SINE
@export var offset_position: Vector2 = Vector2(0.0, 0.0)
@export var target_scale: Vector2 = Vector2(1.0, 1.0)

var parent: BaseButton
var default_position: Vector2
var default_scale: Vector2


func _ready() -> void:
	var parent_button = get_parent()
	
	if parent_button is not BaseButton:
		queue_free()
		return
	
	parent = parent_button
	
	default_position = parent.global_position
	default_scale = parent.scale
	
	if from_center:
		parent.pivot_offset = parent.size / 2.0
	
	parent.mouse_entered.connect(_parent_mouse_entered)
	parent.mouse_exited.connect(_parent_mouse_exited)


func _parent_mouse_entered() -> void:
	var target_position := parent.position + offset_position
	
	var tween_position := get_tree().create_tween()
	tween_position \
		.tween_property(parent, "position", target_position, duration) \
		.set_trans(transition_type)
	
	var tween_scale := get_tree().create_tween()
	tween_scale \
		.tween_property(parent, "scale", target_scale, duration) \
		.set_trans(transition_type)


func _parent_mouse_exited() -> void:
	if not is_inside_tree():
		return
	
	var tween_position := get_tree().create_tween()
	tween_position.tween_property(parent, "position", default_position, duration).set_trans(transition_type)
	
	var tween_scale := get_tree().create_tween()
	tween_scale.tween_property(parent, "scale", default_scale, duration).set_trans(transition_type)
