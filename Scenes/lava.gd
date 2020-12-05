extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global = get_node("/root/Global");
var offset = 0.0;
onready var speed = global.lavaSpeed;
onready var acceleration = global.lavaAcceleration;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.lavaEnabled == true:
		speed += acceleration * delta * global.timescale;
		offset += speed * delta * global.timescale;
		position.y = 480 - offset;
	else:
		visible = false;

func _on_Area2D_body_entered(body):
	body.inlava = true;

func _on_Area2D_body_exited(body):
	body.inlava = false;
