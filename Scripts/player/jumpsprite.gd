extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	region_enabled = true;
	region_filter_clip = true;
	visible = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		region_rect = Rect2(0,32,32,-($jumptimer.time_left / $jumptimer.wait_time * 32))
		offset = Vector2(0,(1-($jumptimer.time_left / $jumptimer.wait_time))*16-32)


func _on_jumptimer_timeout():
	visible = false;
