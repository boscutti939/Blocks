extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global = get_node("/root/Global");
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

onready var maxheightlabel = $sceneCamera/gameOverSplash/maxheightlabel;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not has_node("player"):
		if global.gameOver == false:
			$sceneCamera/gameOverSplash/AnimationPlayer.play("gameoverappearanimation");
		global.gameOver = true;
		get_tree().paused = true;
	maxheightlabel.text = "Maximum height climbed: " + str(global.playerMaxBlockHeight) + " blocks";
	
	if Input.is_key_pressed(KEY_F5):
		get_tree().reload_current_scene();
