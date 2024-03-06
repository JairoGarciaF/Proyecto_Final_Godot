extends ParallaxLayer

func _process(delta):
	#Cantidad o posicion que se va a mover en relacion al jugador
	motion_offset.x += 35 * delta

