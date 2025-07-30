extends PanelContainer


@onready var toolbar_split: HSplitContainer = $ToolbarSplit
@onready var slide_slider: HSlider = %SlideSlider
@onready var count_label: Label = %CountLabel


func _ready() -> void:
	var toolbar_extras_scene := ThemeManager.current_theme.toolbar_extras_scene
	if toolbar_extras_scene != null:
		var toolbar_extras_instance := toolbar_extras_scene.instantiate()
		toolbar_split.add_child(toolbar_extras_instance)
	
	slide_slider.max_value = SlideshowManager.slide_quantity - 1
	slide_slider.drag_ended.connect(_slide_slider_drag_ended)
	
	SlideshowManager.slide_changed.connect(
		change_count_label.bind(SlideshowManager.slide_quantity)
	)
	
	call_deferred("_initial_update_count_label")


func _initial_update_count_label():
	change_count_label(
		SlideshowManager.current_slide_index,
		SlideshowManager.slide_quantity
	)


func change_count_label(current_slide_index: int, slide_quantity: int) -> void:
	count_label.text = str(current_slide_index + 1) + "/" + str(slide_quantity)


func _slide_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		SlideshowManager.go_to_slide_by_index(slide_slider.value)


func _on_previous_button_pressed() -> void:
	SlideshowManager.previous_slide()


func _on_next_button_pressed() -> void:
	SlideshowManager.next_slide()
