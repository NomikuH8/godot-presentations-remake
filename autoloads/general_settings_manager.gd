extends Node


signal changed_aspect_ratio(new_aspect_ratio: float)


var aspect_ratio: float = 16.0 / 9.0


func set_aspect_ratio(new_aspect_ratio: float) -> void:
	aspect_ratio = new_aspect_ratio
	changed_aspect_ratio.emit(new_aspect_ratio)
