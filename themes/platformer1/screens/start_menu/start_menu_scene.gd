extends Control


@onready var start_button: Button = %StartButton
@onready var exit_button: Button = %ExitButton


func _ready() -> void:
	start_button.pressed.connect(SceneManager.go_to_slideshow)
	exit_button.pressed.connect(get_tree().quit)
