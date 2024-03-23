extends CharacterBody2D

const ACCELERATION = 500
const FRICTION = 1500
const MAX_SPEED = 300

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	move(delta)

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			var key_name = OS.get_keycode_string(event.keycode)
			print("Key pressed: ", key_name)
		else:
			var key_name = OS.get_keycode_string(event.keycode)
			print("Key released: ", key_name)


func move(delta):
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	
	if input_vector.length() > 0:
		# Directly set the target velocity based on input, without interpolation
		velocity = input_vector * MAX_SPEED
	else:
		# Apply friction to slow down the velocity towards zero
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move_and_slide()  # Use move_and_slide without arguments




func apply_friction(amount) -> void:
	var friction = velocity.normalized() * amount
	velocity -= friction
	if velocity.length() < 50:
		velocity = Vector2()

func apply_movement(amount) -> void:
	velocity += amount
	velocity = velocity.limit_length(MAX_SPEED)
	move_and_slide()
