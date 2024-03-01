extends CanvasLayer


@onready var black_screen = $black_screen

func show_black_screen():
	black_screen.visible = true

func hide_black_screen():
	black_screen.visible = false
