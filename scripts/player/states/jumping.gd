extends PlayerState

func enter(previous_state_path: String, data := {} ):
	player.velocity.y = player.JUMP_VELOCITY

func physics_update(delta: float):
	
	if player.velocity.y > 0 :
		finished.emit(FALLING)
