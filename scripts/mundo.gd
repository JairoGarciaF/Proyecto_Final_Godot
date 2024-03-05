extends Node2D

@export var next_level: PackedScene = null
@export var is_final_level:bool = false

@onready var player = $Player
@onready var uilayer = $UILayer
@onready var start_scenario = $Start
@onready var exit_area = $Portal
@onready var parallax = $MidParallax

var winner = false

func _ready():
	player.global_position = start_scenario.get_spawn_possition()
	exit_area.body_entered.connect(_on_exit_body_entered)

func _on_exit_body_entered(body):
	if body is Player:
		winner = true
		body.set_active(false)
		if is_final_level || next_level == null:
			uilayer.show_win_screen()
		elif next_level != null:
			parallax.show()
			await get_tree().create_timer(8).timeout
			get_tree().change_scene_to_packed(next_level)
			parallax.hide()


func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):		
		get_tree().reload_current_scene()
