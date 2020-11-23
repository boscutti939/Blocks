extends Node2D

func _ready():
	get_parent().child = name;
	get_parent().blocktype = 1;

func _on_Area2D_body_entered(body):
	if body.name == "player":
		get_node("/root/field/player").jumpheight = 3;
		get_node("/root/field/player/powerupsound").play();
		get_node("/root/field/player/jumpmeter/timer").starttimer();
		get_parent().queue_free();
