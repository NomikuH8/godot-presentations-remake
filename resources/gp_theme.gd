class_name GPTheme
extends Resource


@export_category("Info")
@export var name: String = ""
@export var author: String = ""


@export_category("UI")
@export var ui_theme: Theme


@export_category("Scenes")
@export var start_menu_scene: PackedScene
@export var start_menu_background_scene: PackedScene
@export var slides_container_scene: PackedScene
@export var background_scene: PackedScene
@export var toolbar_extras_scene: PackedScene
