extends Node2D

func _ready():
	get_parent().child = name;
	get_parent().blocktype = 1;

func _on_Area2D_body_entered(body):
	if body.name == "player" and body.died == false:
		get_node("/root/field/player").jumpheight = 3;
		get_node("/root/field/player/powerupsound").play();
		get_node("/root/field/player/jumpbox/AnimationPlayer").play("timer");
		get_node("/root/field/player/jumpbox/AnimationPlayer").seek(0.0, true);
		get_node("/root/field/explosion_manager").powerup(get_parent().position, Color(0.0, 1.0, 0.0, 1.0), "Higher Jump!");
		get_parent().queue_free();
