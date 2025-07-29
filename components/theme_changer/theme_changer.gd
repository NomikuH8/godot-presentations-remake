extends OptionButton


var themes: Dictionary[String, String] = {}


func _ready() -> void:
	var dir := DirAccess.open("res://themes")
	
	for file in dir.get_files():
		if file.ends_with(".tres"):
			var key := file.substr(file.rfind("/") + 1).replace(".tres", "")
			themes[key] = file
	
	var popup := get_popup()
	for id in themes.keys().size():
		var key: String = themes.keys()[id]
		popup.add_item(key, id)
	
	popup.id_pressed.connect(load_theme)


func load_theme(id: int):
	var new_theme: String = themes.values()[id]
	ThemeManager.set_theme(new_theme)
