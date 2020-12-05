extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (PackedScene) var explosionScene;
onready var shakeTime = get_node("../sceneCamera/shakeTime");

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass;

func explode(pos, snd):
	shakeTime.start();
	var explosion = explosionScene.instance();
	explosion.position = pos;
	explosion.muted = not snd;
	add_child(explosion);
