extends PlayerState

func enter(previous_state_path: String, data := {} ):
	player.animation_player.play('crawl')

func physics_update(delta:float):
	
	player.velocity.x = player.direction.x * player.CRAWL_SPEED
	player.velocity.z = player.direction.z * player.CRAWL_SPEED
	player.move_and_slide()
	
	if Input.is_action_just_pressed("crawl") && !player.shape_cast_3d.is_colliding():
		player.animation_player.play('crawl_off')
		finished.emit(IDLE)
	if Input.is_action_just_pressed("crouch"):
		finished.emit(CRAWLING)
	if !player.is_on_floor():
		finished.emit(FALLING)
