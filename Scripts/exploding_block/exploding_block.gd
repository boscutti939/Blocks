extends Node2D

var exploding = false;
var prevtime = 3;
var slowed = false;

onready var delaytime = $"../delay_time";
onready var fusetime = $"../fuse_time";
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
	if not fusetime.is_stopped():
		if slowed == true and ceil(fusetime.time_left * global.slowTimescale) < prevtime:
			prevtime = ceil(fusetime.time_left * global.slowTimescale);
			fuseaudio.play();
		elif slowed == false and ceil(fusetime.time_left * global.normalTimescale) < prevtime:
			prevtime = ceil(fusetime.time_left * global.normalTimescale);
			fuseaudio.play();
	if global.timescale != global.normalTimescale and not fusetime.is_stopped() and slowed == false:
		slowed = true;
		fusetime.wait_time = fusetime.time_left / global.slowTimescale;
		fusetime.stop();
		fusetime.start();
	elif global.timescale == global.normalTimescale and not fusetime.is_stopped() and slowed == true:
		slowed = false;
		fusetime.wait_time = fusetime.time_left * global.slowTimescale;
		fusetime.stop();
		fusetime.start();

func _physics_process(delta):
	pass;

#Everything around the block will explode.
#If the blocks are explosive, they will also explode.
func explode():
	if exploding == false:
		exploding = true;
		delaytime.start();
	return false;

func _on_fuse_time_timeout(): #If the fuse expires, blow up the block.
	get_parent().explode();

func _on_Area2D_body_entered(body):
	if body.name == "player" and fusetime.is_stopped():
		fusetime.start();
		fuseaudio.play();

func _on_delay_time_timeout():
	if rayUp.is_colliding():
		rayUp.get_collider().explode();
	if rayDown.is_colliding() and rayDown.get_collider().name != "floor":
		rayDown.get_collider().explode();
	if rayLeft.is_colliding():
		rayLeft.get_collider().explode();
	if rayRight.is_colliding():
		rayRight.get_collider().explode();
	if rayUpLeft.is_colliding():
		rayUpLeft.get_collider().explode();
	if rayDownLeft.is_colliding() and rayDownLeft.get_collider().name != "floor":
		rayDownLeft.get_collider().explode();
	if rayUpRight.is_colliding():
		rayUpRight.get_collider().explode();
	if rayDownRight.is_colliding() and rayDownRight.get_collider().name != "floor":
		rayDownRight.get_collider().explode();
	get_parent().justexplode();
