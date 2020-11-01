extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global = get_node("/root/Global")

var startpos;

# Called when the node enters the scene tree for the first time.
func _ready():
	startpos = position;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var opacity = (global.blockOpacityRange - global_position.distance_to(get_node("/root/field/player").global_position) + 32) / global.blockOpacityRange;
	modulate.a = clamp(opacity, 0.5, 1.0)
	
