extends KinematicBody2D

var motion = Vector2(0, 0);

const speed = 250;
const JUMPHEIGHT = 2.25;
var active = false;
var jumpheight = JUMPHEIGHT;
var maxBlockHeight = 0;
var died = false;
var invincible = false;
var oldposition = Vector2(0,0);
var inlava = false;
export var relativeposition = Vector2(0,0);
var onfloor = false;
onready var label = $label;
onready var global = get_node("/root/Global");

func _ready():
	visible = false;

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
					if invincible == false:
						print_debug("I was killed by ", collision.collider.name, " at position", position, " where the collider position was ", collision.collider.position);
						explode();
					else:
						if collision.collider.blocktype != 1:
							collision.collider.justexplode(true);
			if collision.collider.position.y < position.y - 32:
				if motion.y > 0:
					motion.y = 0;
			if collision.collider.position.y == round(position.y) + 32 and collision.collider.position.x < position.x + 30 and collision.collider.position.x > position.x - 30:
				if collision.collider.get("velocity") != null and collision.collider.velocity.y == 0:
					onfloor = true;
	if $rayUp.is_colliding():
		var collision = $rayUp.get_collider();
		if invincible and collision.blocktype != 1:
			collision.justexplode(true);
		if $rayDown.is_colliding():
			if collision.blocktype != 1:
				print_debug("I was killed by ", collision.name, " at position", position, " where the collider position was ", collision.position);
				explode();
	if $rayLeft.is_colliding():
		var collision = $rayLeft.get_collider();
		if collision.position.y == round(position.y):
			position.x = collision.position.x + 32;
			if motion.x < 0:
				motion.x = 0;
	if $rayRight.is_colliding():
		var collision = $rayRight.get_collider();
		if collision.position.y == round(position.y):
			position.x = collision.position.x - 32;
			if motion.x > 0:
				motion.x = 0;

func _process(delta):
	if active:
		visible = true;
		if inlava:
			explode();
#	label.text = str(onfloor);
#	label.text = str(position.y);

func _physics_process(delta):
	if active:
		if not died:
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
	if active and not invincible:
		motion = Vector2(0,0);
		oldposition = position;
		died = true;
		if global.timescale != 1:
			global.resumetime();
		$AnimationPlayer.play("deathanimation");
		print_debug("I died.");

func _on_timetimer_timeout():
	global.resumetime();

func _on_timer_timeout():
	jumpheight = JUMPHEIGHT;

func _on_supertimer_timeout():
	invincible = false;

func activate():
	active = true;
