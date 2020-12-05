extends Node2D

func _ready():
	get_parent().child = name;
	get_parent().blocktype = 3;

func _process(delta):
	pass;

func _physics_process(delta):
	pass;
