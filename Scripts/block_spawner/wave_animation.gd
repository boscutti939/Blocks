extends AnimationPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 1.0;
onready var global = $"/root/Global";

# Called when the node enters the scene tree for the first time.
func _ready():
	$tween.interpolate_property(self, "speed", 1.0, global.waveMaxSpeed, global.secondsToMax,Tween.TRANS_CUBIC, Tween.EASE_OUT);
	$tween.start();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	playback_speed = speed * global.timescale;
