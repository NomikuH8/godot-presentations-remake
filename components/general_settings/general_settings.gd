extends HBoxContainer


const ASPECT_RATIO_4_3 := 0
const ASPECT_RATIO_16_9 := 1

@onready var full_screen_check_box: CheckBox = $FullScreenCheckBox
@onready var aspect_ratio: OptionButton = $AspectRatio

var aspect_ratio_container: AspectRatioContainer


func _ready() -> void:
	var popup := aspect_ratio.get_popup()
	
	popup.index_pressed.connect(_aspect_ratio_dropdown_changed)
	full_screen_check_box.toggled.connect(_full_screen_check_box_toggled)
	
	aspect_ratio_container = get_tree().get_first_node_in_group("AspectRatioContainer")
	_change_aspect_ratio(GeneralSettingsManager.aspect_ratio)
	GeneralSettingsManager.changed_aspect_ratio.connect(_change_aspect_ratio)
	
	call_deferred("_set_default_selected_option")


func _set_default_selected_option():
	var selected_ratio_is_4_3 := GeneralSettingsManager.aspect_ratio == 4.0 / 3.0
	if selected_ratio_is_4_3:
		aspect_ratio.select(ASPECT_RATIO_4_3)
	if not selected_ratio_is_4_3:
		aspect_ratio.select(ASPECT_RATIO_16_9)


func _change_aspect_ratio(ratio: float) -> void:
	aspect_ratio_container.ratio = ratio


func _aspect_ratio_dropdown_changed(index: int) -> void:
	var popup := aspect_ratio.get_popup()
	var text := popup.get_item_text(index)
	
	match text:
		"16:9":
			GeneralSettingsManager.set_aspect_ratio(16.0 / 9.0)
		"4:3":
			GeneralSettingsManager.set_aspect_ratio(4.0 / 3.0)


func _full_screen_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
