extends RigidBody2D

var velocity = Vector2(0, 0);
onready var global = get_node("/root/Global");
var col = false;
var drop = false;
var exploding = false;

#make variables here.

func enteredScene():
	for i in ["down", "up", "left", "right", "blockunder"]:
		get_node(i).enabled = true;

func leftScene():
	for i in ["down", "up", "left", "right", "blockunder"]:
		get_node(i).enabled = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;

func _physics_process(delta):
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


#Everything around the block will explode.
#If the blocks are explosive, they will also explode.
func explode():
	if exploding == false:
		exploding = true;
		$delay_time.start();

func _on_fuse_time_timeout(): #If the fuse expires, blow up the block.
	explode();

func _on_Area2D_body_entered(body):
	if body.name == "player" and $fuse_time.is_stopped():
		$fuse_time.start();
		$fuse_audio/beep_timer.start();
		$fuse_audio.play();

func _on_delay_time_timeout():
	if $rayUp.is_colliding():
		$rayUp.get_collider().explode();
	if $rayDown.is_colliding() and $rayDown.get_collider().name != "floor":
		$rayDown.get_collider().explode();
	if $rayLeft.is_colliding():
		$rayLeft.get_collider().explode();
	if $rayRight.is_colliding():
		$rayRight.get_collider().explode();
	if $rayUpLeft.is_colliding():
		$rayUpLeft.get_collider().explode();
	if $rayDownLeft.is_colliding() and $rayDownLeft.get_collider().name != "floor":
		$rayDownLeft.get_collider().explode();
	if $rayUpRight.is_colliding():
		$rayUpRight.get_collider().explode();
	if $rayDownRight.is_colliding() and $rayDownRight.get_collider().name != "floor":
		$rayDownRight.get_collider().explode();
	get_node("/root/field/explosion_manager").explode(position);
	queue_free();
