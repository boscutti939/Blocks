extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Particles2D.emitting = true;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Particles2D.emitting == false:
		queue_free();