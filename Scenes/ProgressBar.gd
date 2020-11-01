extends ProgressBar

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		value = $jumptimer.time_left / $jumptimer.wait_time


func _on_jumptimer_timeout():
	visible = false
