extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var opacity = (((AudioServer.get_bus_peak_volume_left_db(2,0) + AudioServer.get_bus_peak_volume_right_db(2,1)) / 2) + 32) / 32 * 0.1;
	modulate.a = clamp(opacity, 0.0, 0.1)
