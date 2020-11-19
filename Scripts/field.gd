extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global = get_node("/root/Global");
onready var maxheightlabel = $sceneCamera/gameOverSplash/maxheightlabel;

# Called when the node enters the scene tree for the first time.
func _ready():
	global.gameOver = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not has_node("player"):
		maxheightlabel.text = "Maximum height climbed: " + str(global.playerMaxBlockHeight) + " blocks";
		if global.gameOver == false:
			$sceneCamera/gameOverSplash/AnimationPlayer.play("gameoverappearanimation");
		global.gameOver = true;
		get_tree().paused = true;
		if Input.is_key_pressed(global.keys["RESTARTKEY"]):
			get_tree().reload_current_scene();
		elif Input.is_key_pressed(global.keys["BACKKEY"]):
			get_tree().change_scene("res://Scenes/Menu.tscn");
