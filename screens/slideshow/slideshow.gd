extends Node


@onready var control: Control = %Control
@onready var toolbar_container: PanelContainer = %ToolbarContainer
@onready var toolbar_split: HSplitContainer = %ToolbarSplit
@onready var slide_slider: HSlider = %SlideSlider
@onready var count_label: Label = %CountLabel

var slide_quantity: int = 10


func _ready() -> void:
	control.theme = ThemeManager.current_theme.ui_theme
	
	var toolbar_extras_scene := ThemeManager.current_theme.toolbar_extras_scene
	if toolbar_extras_scene != null:
		var toolbar_extras_instance := toolbar_extras_scene.instantiate()
		toolbar_split.add_child(toolbar_extras_instance)
	
	slide_slider.max_value = slide_quantity - 1
	slide_slider.drag_ended.connect(_slide_slider_drag_ended)
	SlideshowManager.slide_quantity = slide_quantity
	SlideshowManager.slide_changed.connect(change_slide)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		set_toolbar_visibility_from_cursor_position(event.position)


func set_toolbar_visibility_from_cursor_position(pos: Vector2) -> void:
	if pos.y <= toolbar_container.size.y and not toolbar_container.visible:
		toolbar_container.show()
	elif pos.y > toolbar_container.size.y and toolbar_container.visible:
		toolbar_container.hide()


func _slide_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		change_slide(slide_slider.value)


func change_slide(index: int) -> void:
	print("change slide to " + str(index))
	count_label.text = str(index + 1) + "/" + str(slide_quantity)
