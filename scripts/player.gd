extends CharacterBody2D

const speed = 200
var current_dir = "none"
@onready var player = $AnimatedSprite2D

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	player_movement()

func player_movement():
	if Input.is_action_pressed("move_right"):
		current_dir = "right"
		play_animation(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("move_left"):
		current_dir = "left"
		play_animation(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("move_down"):
		current_dir = "down"
		play_animation(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("move_up"):
		current_dir = "up"
		play_animation(1)
		velocity.x = 0
		velocity.y = -speed
	elif Input.is_action_pressed("attack"):
		current_dir = "right_attack"
		play_animation(1)
		velocity.x = 0
		velocity.y = 0
	else:
		play_animation(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()

func play_animation(movement):
	var dir = current_dir
	
	if dir == "right":
		player.flip_h = false
		if movement == 1:
			player.play("walk")
		elif movement == 0:
			player.play("idle")
	
	if dir == "left":
		player.flip_h = true
		if movement == 1:
			player.play("walk")
		elif movement == 0:
			player.play("idle")
	
	if dir == "down":
		player.flip_h = true
		if movement == 1:
			player.play("front_walk")
		elif movement == 0:
			player.play("front_idle")
	
	if dir == "up":
		player.flip_h = true
		if movement == 1:
			player.play("back_walk")
		elif movement == 0:
			player.play("back_idle")
	
	if dir == "right_attack":
		player.flip_h = false
		if movement == 1:
			player.play("attack")
		elif movement == 0:
			player.play("idle")
	
