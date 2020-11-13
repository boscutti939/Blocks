extends AudioStreamPlayer2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_tree().paused == true:
		stop();
		$beep_timer.stop();
		$"../fuse_time".stop();
		$"../delay_time".stop();

func _on_beep_timer_timeout():
	play();
