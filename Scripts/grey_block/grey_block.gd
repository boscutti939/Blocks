extends RigidBody2D

var velocity = Vector2(0, 0);
onready var global = get_node("/root/Global");
var col = false;
var drop = false;
var justentered = false;
#make variables here.

func enteredScene():
	for i in ["down", "up", "left", "right", "blockunder"]:
		get_node(i).enabled = true;
	$collision_shape.disabled = false;

func leftScene():
	for i in ["down", "up", "left", "right", "blockunder"]:
		get_node(i).enabled = false;
	$collision_shape.disabled = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;

func _physics_process(delta):
	if get_node_or_null("Label") != null:
		pass;
#		$Label.text = str(position.y);
	if $blockunder.enabled == true:
		if get_node("blockunder").is_colliding() and $blockunder.get_collider().name != "player":
			if velocity.y >= global.maxBlockFallSpeed:
				drop = true;
			col = true;
			position.y = get_node("blockunder").get_collision_point().y - 16;
			velocity.y = 0;
		elif (position.y + (velocity.y * delta)) >= ($"/root/field/sceneCamera".position.y + 480-16):
			if velocity.y >= global.maxBlockFallSpeed:
				drop = true;
			position.y = $"/root/field/sceneCamera".position.y + 480-16;
			velocity.y = 0;
			col = true;
		if col == false:
			velocity.y += global.blockGravity * delta;
			velocity.y = clamp(velocity.y, 0.0, global.maxBlockFallSpeed);
			position.y += velocity.y * delta;
	col = false;

func explode():
	get_node("/root/field/explosion_manager").explode(position);
	queue_free();

func _on_Area2D_body_entered(body):
	if body.name == "player":
		get_node("/root/field/player").jumpheight = 3;
		get_node("/root/field/player/powerupsound").play();
		get_node("/root/field/player/jumpmeter/jumptimer").starttimer();
		queue_free();
