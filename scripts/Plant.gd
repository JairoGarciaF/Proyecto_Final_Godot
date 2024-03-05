extends ParallaxLayer

# se utiliza para definir la logina que va a ser ejecutada
# en cada frame
func _process(delta):
	#Cantidad o posicion que se va a mover en relacion al jugador
	motion_offset.x += 90 * delta
