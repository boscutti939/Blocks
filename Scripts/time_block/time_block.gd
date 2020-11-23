extends Node2D

onready var global = $"/root/Global";

func _ready():
	get_parent().child = name;
	get_parent().blocktype = 1;

func _process(delta):
	pass;

func _physics_process(delta):
	pass;

func _on_Area2D_body_entered(body):
	if body.name == "player":
		global.slowtime();
		get_node("/root/field/player/powerupsound").play();
		get_node("/root/field/player/timemeter/timer").starttimer();
		get_parent().queue_free();
	
