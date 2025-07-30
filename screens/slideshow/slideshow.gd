extends Node


@onready var control: Control = %Control

var toolbar: PanelContainer


func _ready() -> void:
	control.theme = ThemeManager.current_theme.ui_theme
	
	SlideshowManager.slide_changed.connect(_change_slide)
	_change_slide(SlideshowManager.initial_slide_index)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_set_toolbar_visibility_from_cursor_position(event.position)


func _set_toolbar_visibility_from_cursor_position(pos: Vector2) -> void:
	if pos.y <= toolbar.size.y and not toolbar.visible:
		toolbar.show()
	elif pos.y > toolbar.size.y and toolbar.visible:
		toolbar.hide()


func _change_slide(index: int) -> void:
	print("change slide to " + str(index))
