extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global = $"/root/Global";

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"../exploding_block".state == $"../exploding_block".STATE_FUSE:
		text = str(ceil(get_node("../exploding_block").maxfusetime - get_node("../exploding_block").fusetimer));
