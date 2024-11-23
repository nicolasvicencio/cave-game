extends PlayerState

func enter(previous_state_path: String, data := {} ):
	pass
func physics_update(delta: float) -> void:
	player.velocity.x = player.direction.x * player.WALK_SPEED
	player.velocity.z = player.direction.z * player.WALK_SPEED
	player.move_and_slide()
	
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
	elif player.input_axis == Vector2.ZERO:
		finished.emit(IDLE)
	
