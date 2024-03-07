extends Node

var boss = preload("res://audio/Boss.mp3")
var intro = preload("res://audio/Intro.mp3")
var mundo1 = preload("res://audio/mundo1.mp3")
var mundo2 = preload("res://audio/mundo2.mp3")
var princess = preload("res://audio/Princess.mp3")

func play_sfx(sfx: String):
	var sfx_temp = null
	
	if sfx == "boss":
		sfx_temp = boss
	if sfx == "intro":
		sfx_temp = intro
	if sfx == "mundo1":
		sfx_temp = mundo1
	if sfx == "mundo2":
		sfx_temp = mundo2
	if sfx == "princess":
		sfx_temp = princess

	if sfx_temp != null:
		var asp = AudioStreamPlayer2D.new()
		asp.stream = sfx_temp
		asp.name = sfx
		asp.volume_db = -15
		add_child(asp)
		asp.play()
		await asp.finished
		asp.queue_free()
