extends RigidBody2D

var velocity = Vector2(0, 0);
onready var global = get_node("/root/Global");
var col = false;
var drop = false;
var justentered = false;
var child = null;
var blocktype = 0;

onready var blockunder = get_node("blockunder");

func enteredScene():
	for i in ["down", "up", "left", "right", "blockunder"]:
		get_node(i).enabled = true;

func leftScene():
	for i in ["down", "up", "left", "right", "blockunder"]:
		get_node(i).enabled = false;

func explode():
	if get_node(child).has_method("explode"):
		if get_node(child).explode() != false:
			queue_free();
	else:
		justexplode();

func justexplode():
	var explodesound = false;
	if blocktype == 2:
		explodesound = true;
	get_node("/root/field/explosion_manager").explode(position, explodesound);
	queue_free();

func _physics_process(delta):
	if get_node_or_null("Label") != null:
		pass;
#		$Label.text = str(position.y);
	if blockunder.enabled == true:
		if blockunder.is_colliding() and blockunder.get_collider().name != "player":
			if velocity.y >= global.maxBlockFallSpeed * global.timescale:
				drop = true;
			col = true;
			position.y = blockunder.get_collision_point().y - 16;
			velocity.y = 0;
		elif (position.y + (velocity.y * delta)) >= ($"/root/field/sceneCamera".position.y + 480-16):
			if velocity.y >= global.maxBlockFallSpeed * global.timescale:
				drop = true;
			position.y = $"/root/field/sceneCamera".position.y + 480-16;
			velocity.y = 0;
			col = true;
		if col == false:
			velocity.y += global.blockGravity * delta * global.timescale;
			velocity.y = clamp(velocity.y, 0.0, global.maxBlockFallSpeed * global.timescale);
			position.y += velocity.y * delta;
	col = false;