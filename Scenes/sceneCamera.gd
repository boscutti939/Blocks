extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global = get_node("/root/Global");

export var intensity = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset = Vector2(0,0);	
	if global.gameOver == true:
		position.x -= 640 / 2 * delta;
		position.y -= 480 / 2 * delta;
		zoom.x += 1 * delta;
		zoom.y += 1 * delta
	else:
		get_parent().get_node("TileMap").position.y = position.y
		if get_parent().has_node("player") and get_parent().get_node("player").position.y < position.y + 480-192+16 and get_parent().get_node("player").is_on_floor():
			position.y -= 96;
		elif get_parent().has_node("player") and get_parent().get_node("player").position.y > position.y + 480-64 and position.y < 0:
			position.y += 96;
		if not $shakeTime.is_stopped() and get_parent().has_node("player"):
			var shakeratio = $shakeTime.time_left / $shakeTime.wait_time;
			offset.x += rand_range(-(intensity)*shakeratio, intensity*shakeratio);
			offset.y += rand_range(-(intensity)*shakeratio, intensity*shakeratio);
		if not $smallShakeTime.is_stopped() and get_parent().has_node("player"):
			var smallshakeratio = $smallShakeTime.time_left / $smallShakeTime.wait_time;
			offset.x += rand_range(-smallshakeratio, smallshakeratio);
			offset.y += rand_range(-smallshakeratio, smallshakeratio);
