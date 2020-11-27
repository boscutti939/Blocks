extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().child = name;
	get_parent().blocktype = 1;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_body_entered(body):
	if body.name == "player" and body.died == false:
		get_node("/root/field/player").invincible = true;
		get_node("/root/field/player/powerupsound").play();
		get_node("/root/field/player/supermeter/timer").starttimer();
		get_parent().queue_free();
