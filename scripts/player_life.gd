extends CanvasLayer

# Exporta la variable player_node como NodePath
@export var player_node : NodePath

# Declara la variable player y obtén el nodo del jugador en la inicialización
@onready var player : Node = get_node(player_node)


func _process(_delta):

	$TextureProgressBar.value = player.health
