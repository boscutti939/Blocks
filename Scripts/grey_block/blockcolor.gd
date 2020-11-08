extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global = get_node("/root/Global")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var opacityx = (global.blockOpacityRange - global_position.distance_to(get_node("/root/field/player").global_position) + 32) / global.blockOpacityRange;
	opacityx = clamp(opacityx, 0.0, 1.0)
	var opacityy = opacityx * opacityx;
	modulate.a = clamp(opacityy, 0.2, 1.0)
