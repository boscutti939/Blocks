extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y = get_node("/root/field/sceneCamera").position.y;
	modulate = Color(1, 1, 1, $visibleTimer.time_left / $visibleTimer.wait_time)

func _on_Timer_timeout():
	queue_free()
