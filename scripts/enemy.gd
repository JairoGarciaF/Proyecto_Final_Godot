extends CharacterBody2D  # Extiende la clase CharacterBody2D, indicando que este script controla un objeto con cuerpo 2D.

@export var speed = 80  # Velocidad a la que el enemigo se moverá.
var player_chase = false  # Indica si el enemigo está persiguiendo al jugador.
var player = null  # Referencia al jugador.

@export var health = 100  # Salud del enemigo.
var player_in_attack_zone = false  # Indica si el jugador está dentro del rango de ataque.
var can_take_damage = true  # Indica si el enemigo puede recibir daño.

@onready var enemySprite = $AnimatedSprite2D  # Referencia al AnimatedSprite2D asociado al enemigo.

func _ready():
	enemySprite.play("idle")  # Inicia la animación "idle" cuando el enemigo está listo.

func _physics_process(_delta):
	deal_with_damage()  # Lógica para tratar el daño.
	update_health()

	if player_chase:
		position += (player.position - position)/speed  # Mueve al enemigo hacia la posición del jugador.
		enemySprite.play("walk")  # Cambia la animación a "walk" cuando el enemigo persigue al jugador.
		if(player.position.x - position.x) < 0:
			enemySprite.flip_h = true  # Voltea el sprite horizontalmente si el jugador está a la izquierda.
		else:
			enemySprite.flip_h = false  # No voltea el sprite si el jugador está a la derecha.
	else:
		enemySprite.play("idle")  # Cambia la animación a "idle" cuando el enemigo no persigue al jugador.

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true  # Activa la persecución cuando el jugador entra en el área de detección.

func _on_detection_area_body_exited(_body):
	player = null
	player_chase = false  # Desactiva la persecución cuando el jugador sale del área de detección.

func enemy():
	pass  # Función vacía llamada "enemy".

func _on_hit_zone_body_entered(body):
	if body.has_method("player"):
		player_in_attack_zone = true  # Activa la indicación de que el jugador está en el rango de ataque.

func _on_hit_zone_body_exited(body):
	if body.has_method("player"):
		player_in_attack_zone = false  # Desactiva la indicación de que el jugador está en el rango de ataque.

func deal_with_damage():	
	if player_in_attack_zone and global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20  # Reduce la salud del enemigo en 20.
			$take_damage_cooldown.start()  # Inicia el temporizador de recuperación después de recibir daño.
			can_take_damage = false  # Desactiva la capacidad de recibir daño temporalmente.
#			print("monster equals = ", health)  # Imprime la salud actual del enemigo.
			if health <= 0:
				self.queue_free()  # Libera el objeto si la salud es igual o inferior a 0.

func _on_take_damage_cooldown_timeout():
	can_take_damage = true  # Activa la capacidad de recibir daño después de que el temporizador de recuperación ha terminado.


func update_health():
	
	var healthBar = $healthBar
	healthBar.value = health
	
	if health >= 200:
		healthBar.visible = false
	else:
		healthBar.visible = true
