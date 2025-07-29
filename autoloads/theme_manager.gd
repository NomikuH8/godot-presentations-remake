extends Node

signal theme_changed(theme: String)

var current_theme: String = ""

func set_theme(theme: String):
	current_theme = theme
	theme_changed.emit(theme)
