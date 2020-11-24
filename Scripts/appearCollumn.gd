extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global = $"/root/Global";

# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0);
	$Tween.start();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$appearSound.pitch_scale = global.timescale;
	position.y = get_node("/root/field/sceneCamera").position.y;

func _on_Timer_timeout():
	queue_free()
