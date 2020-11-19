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
		if Input.is_key_pressed(global.keys["BACKKEY"]):
			if global.paused == false and paused == false and get_tree().is_paused() == false:
				AudioServer.set_bus_effect_enabled(2, 0, true);
				get_tree().set_pause(true);
				paused = true;
				global.paused = true;
			if global.paused == true and paused == false and get_tree().is_paused() == true:
				AudioServer.set_bus_effect_enabled(2, 0, false);
				get_tree().set_pause(false);
				global.paused = false;
				paused = true;
		if not Input.is_key_pressed(global.keys["BACKKEY"]) and paused == true:
			paused = false;
