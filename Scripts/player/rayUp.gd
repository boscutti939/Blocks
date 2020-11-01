extends RayCast2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	cast_to = Vector2(0, 0);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if get_parent().motion.y < 0:
		enabled = true;
		cast_to = Vector2(0, get_parent().motion.y * delta - 16);
	else:
		enabled = false;
