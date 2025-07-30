extends Node


@onready var aspect_ratio_container: AspectRatioContainer = $UI/AspectRatioContainer
@onready var menu: Control = %Menu
@onready var node: Node2D = $Node2D


func _ready() -> void:
	reload()


func reload() -> void:
	for child in menu.get_children():
		child.queue_free()
	
	for child in node.get_children():
		child.queue_free()
	
	var current_theme := ThemeManager.current_theme
	var menu_scene := current_theme.start_menu_scene
	
	if menu_scene != null:
		var menu_instance := menu_scene.instantiate()
		menu.add_child(menu_instance)
	
	var bg_scene := current_theme.start_menu_background_scene
	
	if bg_scene != null:
		var bg_instance := bg_scene.instantiate()
		node.add_child(bg_instance)
