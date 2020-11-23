extends KinematicBody2D

var motion = Vector2(0, 0);

const speed = 250;
const JUMPHEIGHT = 2.5;
var jumpheight = JUMPHEIGHT;
var maxBlockHeight = 0;
var died = false;
var oldposition = Vector2(0,0);
export var relativeposition = Vector2(0,0);
var onfloor = false;
onready var label = $label;
onready var global = get_node("/root/Global");

func getInput(delta):
	if Input.is_key_pressed(global.keys["LEFTKEY"]) and (not $rayLeft.is_colliding()):
		motion.x = -speed
	elif Input.is_key_pressed(global.keys["RIGHTKEY"]) and (not $rayRight.is_colliding()):
		motion.x = speed
	else:
		motion.x = 0
	if Input.is_key_pressed(global.keys["JUMPKEY"]):
		if is_on_floor():
			if not $jumpsound.is_playing():
				$jumpsound.play()
			$jumpingtimer.start();
	elif not $jumpingtimer.is_stopped():
		$jumpingtimer.stop();
		if motion.y < 0:
			motion.y /= 2;
	if Input.is_key_pressed(global.keys["DOWNKEY"]):
		if not is_on_floor() and motion.y < 400:
			$jumpingtimer.stop();
			motion.y = 400;
	if not $jumpingtimer.is_stopped():
			motion.y = (-100 * jumpheight) * ($jumpingtimer.time_left * 2 / $jumpingtimer.wait_time);
	elif $jumpingtimer.time_left > 0:
		$jumpingtimer.stop();
		$jumpingtimer.time_left = 0;

func checkCollisions(delta):
	onfloor = false;
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.get_collider():
			if collision.collider.position.y < position.y - 1 and collision.collider.position.x < position.x + 30 and collision.collider.position.x > position.x - 30:
				if not collision.collider == null and collision.collider.blocktype != 1:
					print_debug("I was killed by ", collision.collider.name, " at position", position, " where the collider position was ", collision.collider.position);
					explode();
			if collision.collider.position.y < position.y - 16:
				if motion.y > 0:
					motion.y = 0;
			if collision.collider.position.y == round(position.y) + 32 and collision.collider.position.x < position.x + 30 and collision.collider.position.x > position.x - 30:
				if collision.collider.get("velocity") != null and collision.collider.velocity.y == 0:
					onfloor = true;
	if $rayDown.is_colliding() and $rayUp.is_colliding():
		if $rayUp.get_collider().blocktype != 1:
			explode();
	if $rayLeft.is_colliding():
		position.x = $rayLeft.get_collider().position.x + 32;
		if motion.x < 0:
			motion.x = 0;
	if $rayRight.is_colliding():
		position.x = $rayRight.get_collider().position.x - 32;
		if motion.x > 0:
			motion.x = 0;

func _process(delta):
	pass;
#	label.text = str(onfloor);
#	label.text = str(position.y);

func _physics_process(delta):
	if died == false:
		if is_on_floor() and onfloor:
			var blockHeight = ceil((480 - 16 - round(position.y)) / 32);
			maxBlockHeight = max(blockHeight, maxBlockHeight);
			global.updateBlockHeight(maxBlockHeight);
		getInput(delta);
		motion.y += 1600 * delta;
		#position += (Vector2(motion.x, clamp(motion.y, -600, 600))) * delta;
		checkCollisions(delta);
		if move_and_slide(motion, Vector2(0, -1)).y == 0:
			motion.y = 0
		position.x = clamp(position.x, 16, 640-16);
	else:
		position.y = oldposition.y + relativeposition.y;
		position.x = oldposition.x + relativeposition.x;

func explode():
	motion = Vector2(0,0);
	oldposition = position;
	died = true;
	if global.timescale != 1 and global.get_node("timescaletween").get_runtime() <= 0:
		global.resumetime();
	$AnimationPlayer.play("deathanimation");
	print_debug("I died.");

func _on_jumptimer_timeout():
	jumpheight = JUMPHEIGHT;

func _on_timetimer_timeout():
	global.resumetime();
