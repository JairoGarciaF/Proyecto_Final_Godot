extends CharacterBody2D

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 200
var player_alive = true

var attack_in_progress = false

const speed = 200
var current_dir = "none"
@onready var playerSprite = $AnimatedSprite2D

func _ready():
	playerSprite.play("idle") # Inicia la animación "idle" cuando el jugador está listo.

func _physics_process(delta):
	player_movement() # Llama a la función para manejar el movimiento del jugador.
	enemy_attack() # Llama a la función para manejar el ataque del enemigo.
#	attack()
	
	if health <= 0:
		player_alive = false
		health = 0
		print("player has been killed")
		self.queue_free() # Destruye el objeto si la salud del jugador es menor a 0.

func player_movement():
	# Maneja el movimiento del jugador según las teclas presionadas.
	# También inicia la animación correspondiente y ajusta la velocidad.
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
	
	# Si se presiona la tecla de ataque, llama a la función attack().
	elif Input.is_action_just_pressed("attack"):
		attack()
	# Si no se presiona ninguna tecla de movimiento, detiene la animación y la velocidad.
	else:
		play_animation(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide() # Utiliza la función de Godot para mover y deslizar el cuerpo.

func play_animation(movement):
	# Maneja la reproducción de animaciones del jugador según la dirección y el tipo de movimiento.
	# Además, verifica si el ataque está en progreso para decidir qué animación reproducir.
	var dir = current_dir
	
	if dir == "right":
		playerSprite.flip_h = false
		if movement == 1:
			playerSprite.play("walk")
		elif movement == 0:
			if attack_in_progress == false:
				playerSprite.play("idle")
	
	if dir == "left":
		playerSprite.flip_h = true
		if movement == 1:
			playerSprite.play("walk")
		elif movement == 0:
			if attack_in_progress == false:
				playerSprite.play("idle")
	
	if dir == "down":
		playerSprite.flip_h = true
		if movement == 1:
			playerSprite.play("front_walk")
		elif movement == 0:
			if attack_in_progress == false:
				playerSprite.play("front_idle")
	
	if dir == "up":
		playerSprite.flip_h = true
		if movement == 1:
			playerSprite.play("back_walk")
		elif movement == 0:
			if attack_in_progress == false:
				playerSprite.play("back_idle")

func player():
	pass

func _on_hit_zone_body_entered(body):
	print("warning")
	if body.has_method("enemy"):
		enemy_in_attack_range = true # Activa la indicación de que un enemigo está en el rango de ataque.


func _on_hit_zone_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = false # Desactiva la indicación de que un enemigo está en el rango de ataque.

func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		# Reduce la salud del jugador y activa un temporizador de cooldown.
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print("player life ",health) # Imprime la salud actual del jugador.

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true # Activa el cooldown después de que el temporizador ha terminado.
	
func attack():
	# Maneja el ataque del jugador al ser presionada la tecla de ataque.
	# Inicia el temporizador de ataque y establece que el jugador está en un ataque.
	var dir = current_dir
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_in_progress = true
		if dir == "right":
			playerSprite.flip_h = false
			playerSprite.play("side_attack")
			$deal_attack_timer.start()
		if dir == "left":
			playerSprite.flip_h = true
			playerSprite.play("side_attack")
			$deal_attack_timer.start()
		if dir == "down":
			playerSprite.play("front_attack")
			$deal_attack_timer.start()
		if dir == "up":
			playerSprite.play("back_attack")
			$deal_attack_timer.start()

func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop() # Detiene el temporizador de ataque.
	global.player_current_attack = false # Desactiva la indicación de que el jugador está atacando.
	attack_in_progress = false # Desactiva la indicación de que el ataque está en progreso.
