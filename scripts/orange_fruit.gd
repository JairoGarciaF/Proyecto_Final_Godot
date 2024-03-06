extends CharacterBody2D

@export var healtFruit: int 

func _on_area_2d_body_entered(body):
	if body is Player:
		self.queue_free()
		body.health += healtFruit;
		if body.health >= 150:
			body.health = 150
