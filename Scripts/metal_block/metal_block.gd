extends Node2D

onready var global = $"/root/Global";

func _ready():
	get_parent().child = name;
	get_parent().blocktype = 3;

func _process(delta):
	if global.gameStarted:
		position.y = clamp(position.y, -16, get_node("/root/field/sceneCamera").position.y + 480 + 480)

func _physics_process(delta):
	pass;
