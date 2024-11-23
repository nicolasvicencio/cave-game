extends PlayerState

func enter(previous_state_path: String, data := {} ):
	player.animation_player.play('crouch')

func physics_update(delta:float):
	player.velocity.x = player.direction.x * player.CROUCH_SPEED
	player.velocity.z = player.direction.z * player.CROUCH_SPEED
	player.move_and_slide()
	
	if Input.is_action_just_pressed("crouch") && !player.shape_cast_3d.is_colliding():
		player.animation_player.play('crouch_off')
		finished.emit(IDLE)
	if Input.is_action_just_pressed("crawl"):
		finished.emit(CRAWLING)
	if !player.is_on_floor():
		finished.emit(FALLING)
