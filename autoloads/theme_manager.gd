extends Node


signal theme_changed(theme: GPTheme)


var themes_dir: String = "res://themes/"
var current_theme: GPTheme


func get_themes() -> Array[GPTheme]:
	var dir := DirAccess.open(themes_dir)
	
	if dir == null:
		DirAccess.make_dir_recursive_absolute(themes_dir)
		dir = DirAccess.open(themes_dir)
	
	var themes: Array[GPTheme] = []
	for directory in dir.get_directories():
		var script := themes_dir + directory + "/theme.tres"
		if FileAccess.file_exists(script):
			var loaded_script: GPTheme = load(script)
			themes.append(loaded_script)
	
	return themes


func set_theme(theme: GPTheme):
	current_theme = theme
	theme_changed.emit(theme)
