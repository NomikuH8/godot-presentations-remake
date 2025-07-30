extends HBoxContainer


var author_prefix: String = "Author: "

@onready var option_button: OptionButton = $OptionButton
@onready var author_label: Label = $AuthorLabel


func _ready() -> void:
	reload_themes()
	load_theme(0)
	
	var popup := option_button.get_popup()
	popup.id_pressed.connect(load_theme)


func reload_themes() -> void:
	var themes := ThemeManager.get_themes()
	
	var popup := option_button.get_popup()
	popup.clear()
	
	for id in themes.size():
		var current_theme := themes[id]
		popup.add_item(current_theme.name, id)
	
	if themes.size() > 0:
		option_button.select(0)


func load_theme(id: int):
	var theme_script: GPTheme = ThemeManager.get_themes()[id]
	ThemeManager.set_theme(theme_script)
	author_label.text = author_prefix + theme_script.author


func _on_reload_button_pressed() -> void:
	reload_themes()
