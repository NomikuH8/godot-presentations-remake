extends HBoxContainer


@export var aspect_ratio_container: AspectRatioContainer

@onready var full_screen_check_box: CheckBox = $FullScreenCheckBox
@onready var aspect_ratio: OptionButton = $AspectRatio


func _ready() -> void:
	var popup := aspect_ratio.get_popup()
	popup.index_pressed.connect(_aspect_ratio_changed)
	full_screen_check_box.toggled.connect(_full_screen_check_box_toggled)


func _aspect_ratio_changed(index: int) -> void:
	if not aspect_ratio_container:
		return
	
	var popup := aspect_ratio.get_popup()
	var text := popup.get_item_text(index)
	
	match text:
		"16:9":
			aspect_ratio_container.ratio = 16.0 / 9.0
		"4:3":
			aspect_ratio_container.ratio = 4.0 / 3.0


func _full_screen_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
