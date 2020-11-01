extends RayCast2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	cast_to = Vector2(0, 0);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if get_parent().motion.x < 0:
		enabled = true;
		cast_to = Vector2(get_parent().motion.x * delta - 16, 0);
	else:
#		enabled = false;
		cast_to = Vector2(-16, 0);
