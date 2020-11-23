extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global = $"/root/Global";

var muted = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Particles2D.emitting = true;
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$explosion_sound.pitch_scale = rand_range(0.9, 1.2) * global.timescale;
	$Particles2D.speed_scale = 1.5 * global.timescale;
	if $Particles2D.emitting == false:
		queue_free();
