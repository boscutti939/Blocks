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
#	visible = true;
#	text = str(get_tree().paused);
	visible = global.paused;
