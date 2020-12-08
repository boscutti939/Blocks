extends Node2D

var exploding = false;
var prevtime = 3;
var slowed = false;
var maxfusetime = 3.0;
var fusetimer = 0;
var fuseaudiotimer = 0;
enum {STATE_IDLE, STATE_FUSE};
var state = STATE_IDLE;

onready var delaytime = $"../delay_time";
onready var fuseaudio = $"../fuse_audio"
onready var rayUp = $"../rayUp";
onready var rayDown = $"../rayDown";
onready var rayLeft = $"../rayLeft";
onready var rayRight = $"../rayRight";
onready var rayUpLeft = $"../rayUpLeft";
onready var rayUpRight = $"../rayUpRight";
onready var rayDownLeft = $"../rayDownLeft";
onready var rayDownRight = $"../rayDownRight";
onready var global = $"/root/Global";

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().child = name;
	get_parent().blocktype = 2;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not global.gameOver:
		if state == STATE_FUSE:
			fusetimer += 1.0 * delta * global.timescale;
			fuseaudiotimer += 1.0 * delta * global.timescale;
			if fuseaudiotimer >= 1.0:
				fuseaudiotimer = 0;
				fuseaudio.play();
			if fusetimer >= maxfusetime:
				_on_delay_time_timeout();

func _physics_process(delta):
	pass;

#Everything around the block will explode.
#If the blocks are explosive, they will also explode.
func explode():
	if exploding == false:
		exploding = true;
		delaytime.start();
	return false;

func _on_Area2D_body_entered(body):
	if body.name == "player" and body.died == false and state == STATE_IDLE:
		state = STATE_FUSE;
		fuseaudio.play();

func _on_delay_time_timeout():
	for r in [rayUp, rayDown, rayLeft, rayRight, rayUpLeft, rayUpRight, rayDownLeft, rayDownRight]:
		if r.is_colliding() and r.get_collider().name != "floor":
			var collision = r.get_collider();
			if collision != null:
				collision.explode();
	get_parent().justexplode(null);
