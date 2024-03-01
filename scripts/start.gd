extends StaticBody2D

@onready var starting_position = $StartingPosition

func get_spawn_possition():
	return starting_position.global_position
