extends CharacterBody2D


const SPEED = 150.0
const ACCELERATION = 1000
const JUMP_VELOCITY = -280.0
const MAX_JUMP_COUNT = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	handle_gravity(delta)
	handle_jump()
	handle_left_right_move(delta)

	move_and_slide()

func handle_gravity(delta):
	if not is_on_floor():
		# Add the gravity.
		velocity.y += gravity * delta

var jump_count = MAX_JUMP_COUNT
func handle_jump():
	if is_on_floor():
		jump_count = MAX_JUMP_COUNT
	
	if Input.is_action_just_pressed("ui_accept") and jump_count > 0:
		velocity.y = JUMP_VELOCITY
		jump_count -= 1
		
	# Handle short jump.
	# If space is released before we are at JUMP_VELOCITY, shorten it.
	const short_jump = JUMP_VELOCITY / 3
	if Input.is_action_just_released("ui_accept") and velocity.y < short_jump:
		velocity.y = short_jump

func handle_left_right_move(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, ACCELERATION * delta)
