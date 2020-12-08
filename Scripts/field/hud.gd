extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global = $"/root/Global";

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var milliseconds = str(stepify(get_node("/root/field").time, 0.001)).split(".");
	var seconds = str(int(floor(get_node("/root/field").time)) % 60);
	var minutes = str(floor(get_node("/root/field").time / 60));
	if milliseconds.size() == 2:
		$time/timelabel.text = minutes + ":" + seconds + "." + milliseconds[1];
	$time/timecontrol/timesprite/minuteline.rotation_degrees += 360 * delta;
	$time/timecontrol/timesprite/hourline.rotation_degrees += 360 * delta / 12;
