extends Node


signal scene_changed(scene_path: String)


func go_to_slideshow() -> void:
	var scene_path := &"res://screens/slideshow/slideshow.tscn"
	get_tree().change_scene_to_file(scene_path)
	scene_changed.emit(scene_path)


func go_to_start_menu() -> void:
	var scene_path := &"res://screens/start_menu/start_menu.tscn"
	get_tree().change_scene_to_file(scene_path)
	scene_changed.emit(scene_path)
