extends CharacterBody2D

class_name Player

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 150
var player_alive = true

var attack_in_progress = false

var current_sign : Sign = null
var current_sign2 : Sign2 = null
var current_sign3 : Sign3 = null
var current_sign4 : Sign4 = null
var current_sign5 : Sign5 = null
var current_sign6 : Sign6 = null
var current_sign7 : Sign7 = null
var current_sign8 : Sign8 = null
var current_sign9 : Sign9 = null
var current_sign10 : Sign10 = null
var current_sign11 : Sign11 = null
var current_sign12 : Sign12 = null
var current_sign13 : Sign13 = null
var current_sign14 : Sign14 = null
var current_sign15 : Sign15 = null

var current_sign16 : Sign16 = null
var current_sign17 : Sign17 = null
var current_sign18 : Sign18 = null
var current_sign19 : Sign19 = null
var current_sign20 : Sign20 = null
var current_sign21 : Sign21 = null
var current_sign22 : Sign22 = null

var sign_in_range = false
var sign_in_progress = false

const speed = 200
var current_dir = "none"
@onready var playerSprite = $AnimatedSprite2D

func _ready():
	playerSprite.play("idle") # Inicia la animación "idle" cuando el jugador está listo.

func _physics_process(_delta):
	player_movement() # Llama a la función para manejar el movimiento del jugador.
	enemy_attack() # Llama a la función para manejar el ataque del enemigo.
#	attack()

	if sign_in_range:
		show_dialog()
	
	if health <= 0:
		player_alive = false
		health = 0
		print("player has been killed")
		self.queue_free() # Destruye el objeto si la salud del jugador es menor a 0.

var active = true

func set_active(player_active: bool):
	active = player_active
	if not active:
		velocity = Vector2.ZERO

func show_dialog():
	if Input.is_action_just_pressed("speak"):
		if current_sign:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "main")
			current_sign = null
		if current_sign2:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "main2")
			current_sign2 = null
		if current_sign3:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "main3")
			current_sign3 = null
		if current_sign4:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "main4")
			current_sign4 = null
		if current_sign5:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "main5")
			current_sign5 = null
		if current_sign6:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "main6")
			current_sign6 = null
		if current_sign7:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "main7")
			current_sign7 = null
		if current_sign8:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "main8")
			current_sign8 = null
		if current_sign9:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "main9")
			current_sign9 = null
		if current_sign10:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "main10")
			current_sign10 = null
		if current_sign11:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "main11")
			current_sign11 = null
		if current_sign12:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "main12")
			current_sign12 = null
		if current_sign13:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "main13")
			current_sign13 = null
		if current_sign14:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "main14")
			current_sign14 = null
		if current_sign15:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "main15")
			current_sign15 = null
		
		if current_sign16:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/mundo1.dialogue"), "main")
			current_sign16 = null
		if current_sign17:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/mundo1.dialogue"), "main2")
			current_sign17 = null
		if current_sign18:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/mundo1.dialogue"), "main3")
			current_sign18 = null
		if current_sign19:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/mundo1.dialogue"), "main4")
			current_sign19 = null
		if current_sign20:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/mundo1.dialogue"), "main5")
			current_sign20 = null
		if current_sign21:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/mundo1.dialogue"), "main6")
			current_sign21 = null
		if current_sign22:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/mundo1.dialogue"), "main7")
			current_sign22 = null
	return

func player_movement():
	
	if active == true:
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
	
	if active == true:
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
#	print("warning")
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
#		print("player life ",health) # Imprime la salud actual del jugador.

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

func _on_dialog_zone_body_entered(body):
	
	if body is Sign:
		current_sign = body
		sign_in_range = true
	if body is Sign2:
		current_sign2 = body
		sign_in_range = true
	if body is Sign3:
		current_sign3 = body
		sign_in_range = true
	if body is Sign4:
		current_sign4 = body
		sign_in_range = true
	if body is Sign5:
		current_sign5 = body
		sign_in_range = true
	if body is Sign6:
		current_sign6 = body
		sign_in_range = true
	if body is Sign7:
		current_sign7 = body
		sign_in_range = true
	if body is Sign8:
		current_sign8 = body
		sign_in_range = true
	if body is Sign9:
		current_sign9 = body
		sign_in_range = true
	if body is Sign10:
		current_sign10 = body
		sign_in_range = true
	if body is Sign11:
		current_sign11 = body
		sign_in_range = true
	if body is Sign12:
		current_sign12 = body
		sign_in_range = true
	if body is Sign13:
		current_sign13 = body
		sign_in_range = true
	if body is Sign14:
		current_sign14 = body
		sign_in_range = true
	if body is Sign15:
		current_sign15 = body
		sign_in_range = true
	if body is Sign16:
		current_sign16 = body
		sign_in_range = true
	if body is Sign17:
		current_sign17 = body
		sign_in_range = true
	if body is Sign18:
		current_sign18 = body
		sign_in_range = true
	if body is Sign19:
		current_sign19 = body
		sign_in_range = true
	if body is Sign20:
		current_sign20 = body
		sign_in_range = true
	if body is Sign21:
		current_sign21 = body
		sign_in_range = true
	if body is Sign22:
		current_sign22 = body
		sign_in_range = true

func _on_dialog_zone_body_exited(_body):
	sign_in_range = false
