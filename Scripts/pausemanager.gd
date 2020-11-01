extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var paused = false;
onready var global = get_node("/root/Global");
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.gameOver == false:
		if Input.is_key_pressed(KEY_ESCAPE):
			if paused == false and get_tree().paused == false:
				AudioServer.set_bus_effect_enabled(2, 0, true);
				get_tree().paused = true;
				paused = true;
			if paused == false and get_tree().paused == true:
				AudioServer.set_bus_effect_enabled(2, 0, false);
				get_tree().paused = false;
				paused = true;
		if not Input.is_key_pressed(KEY_ESCAPE) and paused == true:
			paused = false;
