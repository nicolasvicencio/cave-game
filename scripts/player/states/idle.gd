extends PlayerState

func enter(previous_state_path: String, data := {} ):
	player.velocity.x = 0.0
	player.velocity.z = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:

	if Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif Input.is_action_just_pressed("crouch"):
		finished.emit(CROUCHING)
	elif Input.is_action_just_pressed("crawl"):
		finished.emit(CRAWLING)
	elif Input.is_action_just_pressed("sprint"):
		finished.emit(RUNNING)
	elif !player.is_on_floor():
		finished.emit(FALLING)
	elif player.input_axis :
		finished.emit(WALKING)
	
	
	
