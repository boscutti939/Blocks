extends KinematicBody2D

var motion = Vector2(0, 0);

const speed = 250;
const JUMPHEIGHT = 2.5;
var jumpheight = JUMPHEIGHT;

func getInput(delta):
	if Input.is_key_pressed(KEY_A) and (not $rayLeft.is_colliding()):
		motion.x = -speed
	elif Input.is_key_pressed(KEY_D) and (not $rayRight.is_colliding()):
		motion.x = speed
	else:
		motion.x = 0
	if Input.is_key_pressed(KEY_SPACE):
		motion.y = -100
	if Input.is_key_pressed(KEY_W):
		if is_on_floor():
			if not $jumpsound.is_playing():
				$jumpsound.play()
			$jumpingtimer.start();
	if not $jumpingtimer.is_stopped():
			motion.y = (-100 * jumpheight) * ($jumpingtimer.time_left * 2 / $jumpingtimer.wait_time);
	elif $jumpingtimer.time_left > 0:
		$jumpingtimer.stop()
		$jumpingtimer.time_left = 0;

func checkCollisions(delta):
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.get_collider():
			if collision.collider.position.y < position.y - 17 and collision.collider.position.x < position.x + 30 and collision.collider.position.x > position.x - 30:
				if not collision.collider == null and not collision.collider.name.match("?yellow_block*"):
					print_debug("I was killed by ", collision.collider.name, " at position", position, " where the collider position was ", collision.collider.position);
					explode();
			if collision.collider.position.y < position.y - 16:
				if motion.y > 0:
					motion.y = 0;
#	if $rayDown.is_colliding():
#		position.y = $rayDown.get_collider().position.y - 32;
#		if motion.y > 0:
#			motion.y = 0;
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

func _physics_process(delta):
	getInput(delta);
	motion.y += 1600 * delta;
	#position += (Vector2(motion.x, clamp(motion.y, -600, 600))) * delta;
	checkCollisions(delta);
	if move_and_slide(motion, Vector2(0, -1)).y == 0:
		motion.y = 0
	position.x = clamp(position.x, 16, 640-16);

func explode():
	print_debug("I died.");
	queue_free();

func _on_jumptimer_timeout():
	jumpheight = JUMPHEIGHT;

