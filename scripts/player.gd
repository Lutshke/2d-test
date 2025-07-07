extends CharacterBody2D


const SPEED = 175.0

func _process(delta: float) -> void:
	rotate_player()
	

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left", "right", "up", "down")
	
	if get_global_mouse_position().x < global_position.x:
		$Sprites.scale.x = -1;
	else:
		$Sprites.scale.x = 1;
		
	if direction:
		$"Animator/Player Animator".play("walk")
		velocity = direction * SPEED
	else:
		$"Animator/Player Animator".stop()
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()


func rotate_player():
	var look_at_pos = get_global_mouse_position();
	var look_angle = rad_to_deg(get_angle_to(look_at_pos));
	if get_global_mouse_position().x < global_position.x:
		look_angle = abs(look_angle) - 180
		if get_global_mouse_position().y < global_position.y:
			look_angle = -look_angle;
		
		
	print(look_angle)
	
	$Sprites.rotation_degrees = clamp(look_angle, -50, 50)
