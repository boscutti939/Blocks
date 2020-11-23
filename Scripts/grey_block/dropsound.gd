extends AudioStreamPlayer2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var baseblock = get_parent();
onready var global = $"/root/Global";

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pitch_scale = global.timescale;
	if baseblock.drop == true:
		play()
		get_node("/root/field/sceneCamera/smallShakeTime").start()
		baseblock.drop = false;
