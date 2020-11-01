extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var curr = 0
var prevnode = null;
onready var currnode = $MainItems;
onready var options = currnode.get_node("Control/VBoxContainer").get_child_count()
var up = false;
var down = false;
var enter = false;
var esc = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	currnode.position.y = 240

func flyInTweenStart():
	$FlyInTween.interpolate_property(currnode.get_node("Control"), "rect_position", Vector2(640, 0), Vector2(0, 0), 0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 0.2)
	$FlyInTween.start()

func flyOutTweenStart():
	$FlyOutTween.interpolate_property(prevnode.get_node("Control"), "rect_position", prevnode.get_node("Control").rect_position, Vector2(-640, prevnode.get_node("Control").rect_position.y), 0.4, Tween.TRANS_BACK, Tween.EASE_IN, 0.0)
	$FlyOutTween.start()

func navTweenStart():
	$NavTween.interpolate_property(currnode, "position", currnode.position, Vector2(0, 240 - curr * 32), 0.1, Tween.TRANS_SINE, Tween.EASE_OUT, 0)
	$NavTween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_W):
		if curr > 0 and up == false:
			curr -= 1;
			navTweenStart();
			$uibeep.play()
		up = true;
	else:
		up = false;
	if Input.is_key_pressed(KEY_S):
		if curr < options - 1 and down == false:
			curr += 1;
			navTweenStart();
			$uibeep.play()
		down = true;
	else:
		down = false;
	
	if Input.is_key_pressed(KEY_ENTER) and enter == false:
		$uibeep.play()
		enter = true;
		if currnode.name == "MainItems":
			match curr:
				0:
					if $FlyInTween.get_runtime() == 0 and $FlyOutTween.get_runtime() == 0:
						prevnode = $MainItems;
						currnode = $PlayItems;
						currnode.position.y = 240
						options = currnode.get_node("Control/VBoxContainer").get_child_count();
						curr = 0;
						flyOutTweenStart();
						flyInTweenStart();
				1:
					pass #Change the current menu to the options.
				2:
					get_tree().quit();
		elif currnode.name == "PlayItems":
			match curr:
				0:
					get_tree().change_scene("res://Scenes/field.tscn")
				1:
					pass #Survival
				2:
					pass #Extreme
	elif not Input.is_key_pressed(KEY_ENTER):
		enter = false;
	
	if Input.is_key_pressed(KEY_ESCAPE) and esc == false:
		esc = true;
		if $FlyInTween.get_runtime() == 0 and $FlyOutTween.get_runtime() == 0:
			if currnode.name == "PlayItems":
				prevnode = $PlayItems;
				currnode = $MainItems;
				currnode.position.y = 240;
				options = currnode.get_node("Control/VBoxContainer").get_child_count();
				curr = 0;
				flyOutTweenStart();
				flyInTweenStart();
			elif currnode.name == "MainItems":
				get_tree().quit();
	elif not Input.is_key_pressed(KEY_ESCAPE):
		esc = false;
