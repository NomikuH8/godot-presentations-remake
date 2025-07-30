extends Node


signal slide_started_animation()
signal slide_finished_animation()
signal slide_changed(index: int)


var current_slide_index: int = 0
var slide_quantity: int = 1


func next_slide() -> void:
	go_to_slide(current_slide_index + 1)


func previous_slide() -> void:
	go_to_slide(current_slide_index - 1)


func go_to_slide(index: int) -> void:
	if index < 0 or index > slide_quantity - 1:
		return
	
	current_slide_index = index
	slide_changed.emit(index)
