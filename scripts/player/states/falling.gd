extends PlayerState

func enter(previous_state_path: String, data := {} ):
	pass

func physics_update(delta:float):
	
	player.move_and_slide()
	if player.is_on_floor():
		finished.emit(IDLE)
