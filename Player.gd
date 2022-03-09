extends KinematicBody2D

var motion = Vector2(0,0)

const SPEED = 1500
const GRAVITY = 150
const UP = Vector2(0,-1)
const JUMP_SPEED = 3500
const WORLD_LIMIT = 4000
const BOOST_MULTIPLIER = 1.5

signal animate

func _physics_process(delta):
	apply_gravity()
	jump()
	move()
	animate()
	move_and_slide(motion, UP)
	
func apply_gravity():
	if position.y > WORLD_LIMIT:
		get_tree().call_group("GameState", "end_game")
	if is_on_floor():
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1		
	else:
		motion.y += GRAVITY
		
func jump():
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			motion.y -= JUMP_SPEED
			$AudioStreamPlayer2D.stream = load("res://assets/SFX/jump1.ogg")
			$AudioStreamPlayer2D.play()
			
func boost():
	position.y -= 1
	yield(get_tree(), "idle_frame")
	motion.y -= JUMP_SPEED * BOOST_MULTIPLIER
			
func move():
	if Input.is_action_pressed("left") and Input.is_action_pressed("right"):
		motion.x = 0
	elif Input.is_action_pressed("left"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right"):
		motion.x = SPEED
	else:
		motion.x = 0

func animate():
	emit_signal ("animate", motion)

func hurt():
	position.y -= 1
	yield(get_tree(), "idle_frame")
	motion.y -= JUMP_SPEED
	$AudioStreamPlayer2D.stream = load("res://assets/SFX/pain.ogg")
	$AudioStreamPlayer2D.play()

	
	
