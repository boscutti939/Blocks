extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"../Tween".interpolate_property(self, "modulate", Color(1.0, 1.0, 1.0, 1.0), Color(1.0, 1.0, 1.0, 0.0), $"../Particles2D".lifetime, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.0);
	$"../Tween".start();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = get_parent().txt;
	margin_top -= 32 * delta;
