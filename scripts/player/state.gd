class_name State extends Node

signal finished(next_stage_path: String, data: Dictionary)

func handle_input(event: InputEvent) -> void:
	pass
	
func update(dalta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
	
func enter(previous_state_path: String, data := {} )  -> void:
	pass

func exit() -> void: 
	pass
