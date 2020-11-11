extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global = get_node("/root/Global");
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

onready var maxheightlabel = $sceneCamera/hud/maxheightlabel;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not has_node("player"):
		global.gameOver = true;
		get_tree().set_pause(true);
	maxheightlabel.text = "Maximum height climbed: " + str(global.playerMaxBlockHeight);
	
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene();
