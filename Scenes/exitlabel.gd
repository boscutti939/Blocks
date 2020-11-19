extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global = $"/root/Global";

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Press " + OS.get_scancode_string(global.keys["BACKKEY"]) + " to exit.";


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
