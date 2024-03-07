extends Control

#func _ready():
#	AudioPlayer.play_sfx("intro")

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/mundo.tscn")
	
func _on_quit_button_pressed():
	get_tree().quit()
