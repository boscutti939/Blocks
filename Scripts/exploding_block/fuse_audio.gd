extends AudioStreamPlayer2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global = $"/root/Global";
# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pitch_scale = global.timescale;
	if get_tree().paused == true and global.gameOver == true:
		stop();
		$"../fuse_time".stop();
		$"../delay_time".stop();

func _on_Timer_timeout():
	play();
