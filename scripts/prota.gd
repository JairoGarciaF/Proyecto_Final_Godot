extends CharacterBody2D

@export var speed = 100  # Velocidad de movimiento

@onready var player = $Sprite2D

func _physics_process(delta):
	var direction_x = Input.get_axis("move_left", "move_right")
	var direction_y = Input.get_axis("move_up", "move_down")

	if direction_x != 0:
		player.flip_h = (direction_x == -1)
	velocity.x = direction_x * speed
	velocity.y = direction_y * speed

	move_and_slide()
