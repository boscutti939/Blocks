extends Tween

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var tweeninterpolated = 0.5;

# Called when the node enters the scene tree for the first time.
func _ready():
	interpolate_property(get_parent().texture.gradient, "offsets", [0,0,1], [0,1,1], 1, Tween.TRANS_LINEAR, Tween.EASE_IN);
	start();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;
