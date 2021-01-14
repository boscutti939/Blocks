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
	if body.name == "player" and body.died == false:
		global.slowtime();
		get_node("/root/field/player/powerupsound").play();
		get_node("/root/field/player/timebox/AnimationPlayer").play("timer");
		get_node("/root/field/player/timebox/AnimationPlayer").seek(0.0, true);
		get_node("/root/field/player/timeexplosionsprite/AnimationPlayer").play("explosionanimation");
		get_node("/root/field/explosion_manager").powerup(get_parent().position, Color(0.0, 0.0, 1.0, 1.0), "Slow Time!");
		get_parent().queue_free();
