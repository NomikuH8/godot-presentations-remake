extends Node


@onready var control: Control = %Control

var aspect_ratio_container: AspectRatioContainer
var slides_container: Control
var toolbar: PanelContainer


func _ready() -> void:
	aspect_ratio_container = get_tree().get_first_node_in_group("AspectRatioContainer")
	GeneralSettingsManager.changed_aspect_ratio.connect(_change_aspect_ratio)
	_change_aspect_ratio(GeneralSettingsManager.aspect_ratio)
	
	slides_container = get_tree().get_first_node_in_group("SlidesContainer")
	toolbar = get_tree().get_first_node_in_group("Toolbar")
	
	var slides_container_scene := ThemeManager.current_theme.slides_container_scene
	if slides_container_scene != null:
		var slides_container_instance := slides_container_scene.instantiate()
		slides_container.add_child(slides_container_instance)
	
	control.theme = ThemeManager.current_theme.ui_theme
	
	SlideshowManager.slide_changed.connect(_change_slide)
	_change_slide(SlideshowManager.initial_slide_index)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_set_toolbar_visibility_from_cursor_position(event.position)


func _change_aspect_ratio(new_aspect_ratio: float) -> void:
	aspect_ratio_container.ratio = new_aspect_ratio


func _set_toolbar_visibility_from_cursor_position(pos: Vector2) -> void:
	if pos.y <= toolbar.size.y and not toolbar.visible:
		toolbar.show()
	elif pos.y > toolbar.size.y and toolbar.visible:
		toolbar.hide()


func _change_slide(index: int) -> void:
	print("change slide to " + str(index))
