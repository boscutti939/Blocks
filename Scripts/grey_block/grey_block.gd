extends RigidBody2D

var velocity = Vector2(0, 0);
onready var global = get_node("/root/Global");
var col = false;
var drop = false;

#make variables here.
# Called when the node enters the scene tree for the first time.
func _ready():
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if get_node("RayCast2D").is_colliding():
		if velocity.y >= global.maxBlockFallSpeed:
			drop = true;
		col = true;
		position.y = get_node("RayCast2D").get_collision_point().y - 16;
		velocity.y = 0;
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
