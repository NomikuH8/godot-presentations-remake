extends OptionButton


@onready var option_button: OptionButton = $OptionButton


func _ready() -> void:
	reload_themes()
	
	var popup := option_button.get_popup()
	popup.id_pressed.connect(load_theme)


func reload_themes() -> void:
	var themes := ThemeManager.get_themes()
	
	var popup := option_button.get_popup()
	popup.clear()
	
	for id in themes.size():
		var current_theme := themes[id]
		popup.add_item(current_theme.name, id)


func load_theme(id: int):
	var theme_script: GPTheme = ThemeManager.get_themes()[id]
	ThemeManager.set_theme(theme_script)
