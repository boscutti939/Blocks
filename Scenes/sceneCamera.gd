extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global = get_node("/root/Global");

export var intensity = 8
var olddest = position;
var newdest = position;

func updatePosition():
	$smoothTween.interpolate_property(self, "position", olddest, newdest, 0.35, Tween.TRANS_SINE, Tween.EASE_OUT, 0);
	$smoothTween.start();
	get_tree().set_pause(true);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset = Vector2(0,0);
	if global.gameOver == true:
		pass;
	else:
		if position == newdest and global.paused == false:
			get_tree().set_pause(false);
		if get_parent().has_node("player") and get_node("../player").died == false:
			if get_parent().get_node("player").position.y < newdest.y + 480-192+16 and get_parent().get_node("player").onfloor and get_parent().get_node("player").is_on_floor():
				olddest = newdest;
				newdest.y -= olddest.y + 480 - stepify($"../player".position.y, 16) - 16 - 32;
				updatePosition();
			elif get_parent().get_node("player").position.y > newdest.y + 480 and newdest.y < 0:
				olddest = newdest;
				newdest.y += 5 * 32;
				if newdest.y > 0:
					newdest.y = 0;
				get_node("/root/field/block_spawner").blockedLocations.erase(int(($"../player".position.x + 16) / 32))
				updatePosition();
		if not $shakeTime.is_stopped() and get_parent().has_node("player"):
			var shakeratio = $shakeTime.time_left / $shakeTime.wait_time;
			offset.x += rand_range(-(intensity)*shakeratio, intensity*shakeratio);
			offset.y += rand_range(-(intensity)*shakeratio, intensity*shakeratio);
		if not $smallShakeTime.is_stopped() and get_parent().has_node("player"):
			var smallshakeratio = $smallShakeTime.time_left / $smallShakeTime.wait_time;
			offset.x += rand_range(-smallshakeratio, smallshakeratio);
			offset.y += rand_range(-smallshakeratio, smallshakeratio);

func _on_blockCheckArea_body_exited(body):
	body.leftScene();

func _on_blockCheckArea_body_entered(body):
	body.enteredScene();

func _on_blockDestroyArea_body_exited(body):
	body.queue_free();
