extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global = $"/root/Global";

var curr = 0
var prevnode = null;
onready var currnode = $MainItems;
onready var options = currnode.get_node("Control/VBoxContainer").get_child_count()
var up = false;
var down = false;
var left = false;
var right = false;
var enter = false;
var esc = false;
var settingkey = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	currnode.position.y = 240
	resetKeys();

func resetKeys():
	$KeysItems/Control/VBoxContainer/menuleft/keylabel.text = OS.get_scancode_string(global.keys["LEFTKEY"]);
	$KeysItems/Control/VBoxContainer/menuright/keylabel.text = OS.get_scancode_string(global.keys["RIGHTKEY"]);
	$KeysItems/Control/VBoxContainer/menuup/keylabel.text = OS.get_scancode_string(global.keys["UPKEY"]);
	$KeysItems/Control/VBoxContainer/menudown/keylabel.text = OS.get_scancode_string(global.keys["DOWNKEY"]);
	$KeysItems/Control/VBoxContainer/backpause/keylabel.text = OS.get_scancode_string(global.keys["BACKKEY"]);
	$KeysItems/Control/VBoxContainer/select/keylabel.text = OS.get_scancode_string(global.keys["SELECTKEY"]);
	$KeysItems/Control/VBoxContainer/restart/keylabel.text = OS.get_scancode_string(global.keys["RESTARTKEY"]);

func flyInTweenStart():
	$FlyInTween.interpolate_property(currnode.get_node("Control"), "rect_position", Vector2(640, 0), Vector2(0, 0), 0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 1)
	$FlyInTween.start()

func flyOutTweenStart():
	$FlyOutTween.interpolate_property(prevnode.get_node("Control"), "rect_position", prevnode.get_node("Control").rect_position, Vector2(-640, prevnode.get_node("Control").rect_position.y), 0.4, Tween.TRANS_BACK, Tween.EASE_IN, 0.5)
	$FlyOutTween.start()

func navTweenStart():
	$NavTween.interpolate_property(currnode, "position", currnode.position, Vector2(0, 240 - curr * 32), 0.1, Tween.TRANS_SINE, Tween.EASE_OUT, 0)
	$NavTween.start()

func switchItems(previous, current):
	if $FlyInTween.get_runtime() == 0 and $FlyOutTween.get_runtime() == 0:
		prevnode = previous;
		currnode = current;
		currnode.position.y = 240
		options = currnode.get_node("Control/VBoxContainer").get_child_count();
		curr = 0;
		flyOutTweenStart();
		flyInTweenStart();

func optionsSubtract():
	if curr in [0, 1, 2]:
		if AudioServer.get_bus_volume_db(curr) > -32:
			AudioServer.set_bus_volume_db(curr, AudioServer.get_bus_volume_db(curr) - 4);
		else:
			AudioServer.set_bus_mute(curr, true);

func optionsAdd():
	if curr in [0, 1, 2] and AudioServer.get_bus_volume_db(curr) < 0:
		AudioServer.set_bus_mute(curr, false);
		AudioServer.set_bus_volume_db(curr, AudioServer.get_bus_volume_db(curr) + 4);

func setKey(key):
	if key == KEY_ESCAPE:
		settingkey = false;
		esc = true;
		resetKeys();
	elif not key in global.keys.values():
		settingkey = false;
		if key != KEY_ESCAPE:
			$KeysItems/Control/VBoxContainer.get_child(curr).get_node("keylabel").text = OS.get_scancode_string(key);
			match curr:
				0:
					global.keys["LEFTKEY"] = key;
					left = true;
				1:
					global.keys["RIGHTKEY"] = key;
					right = true;
				2:
					global.keys["UPKEY"] = key;
					up = true;
				3:
					global.keys["DOWNKEY"] = key;
					down = true;
				4:
					global.keys["BACKKEY"] = key;
					esc = true;
				5:
					global.keys["SELECTKEY"] = key;
					enter = true;
				6:
					global.keys["RESTARTKEY"] = key;

func _input(event):
	if event is InputEventKey and event.pressed and settingkey == true:
		setKey(event.scancode);

func _process(delta):
	if settingkey == false:
		if Input.is_key_pressed(global.keys["LEFTKEY"]):
			if currnode.name == "OptionsItems" and left == false:
				optionsSubtract();
			left = true;
		else:
			left = false;
		if Input.is_key_pressed(global.keys["RIGHTKEY"]):
			if currnode.name == "OptionsItems" and right == false:
				optionsAdd();
			right = true;
		else:
			right = false;
		if Input.is_key_pressed(global.keys["UPKEY"]):
			if curr > 0 and up == false:
				curr -= 1;
				navTweenStart();
				$uibeep.play()
			up = true;
		else:
			up = false;
		if Input.is_key_pressed(global.keys["DOWNKEY"]):
			if curr < options - 1 and down == false:
				curr += 1;
				navTweenStart();
				$uibeep.play()
			down = true;
		else:
			down = false;
		if Input.is_key_pressed(global.keys["SELECTKEY"]) and enter == false:
			$uibeep.play()
			enter = true;
			$Sprite/AnimationPlayer.play("Flash Animation");
			if currnode.name == "MainItems":
				match curr:
					0:
						switchItems($MainItems, $PlayItems);
					1:
						switchItems($MainItems, $OptionsItems);
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
			elif currnode.name == "OptionsItems":
				if curr == 3:
					switchItems($OptionsItems, $KeysItems);
			elif currnode.name == "KeysItems":
				settingkey = true;
		elif not Input.is_key_pressed(global.keys["SELECTKEY"]):
			enter = false;
		
		if Input.is_key_pressed(global.keys["BACKKEY"]) and esc == false:
			esc = true;
			if currnode.name == "PlayItems":
				switchItems($PlayItems, $MainItems);
			elif currnode.name == "OptionsItems":
				switchItems($OptionsItems, $MainItems);
			elif currnode.name == "KeysItems":
					switchItems($KeysItems, $OptionsItems);
			elif currnode.name == "MainItems":
				get_tree().quit();
		elif not Input.is_key_pressed(global.keys["BACKKEY"]):
			esc = false;
		if currnode.name == "KeysItems" and settingkey == true:
			$KeysItems/Control/VBoxContainer.get_child(curr).get_node("keylabel").text = "Press a key!";
	
	$OptionsItems/Control/VBoxContainer/mastervolume/MarginContainer/ProgressBar.value = AudioServer.get_bus_volume_db(0);
	$OptionsItems/Control/VBoxContainer/sfxvolume/MarginContainer/ProgressBar.value = AudioServer.get_bus_volume_db(1);
	$OptionsItems/Control/VBoxContainer/musicvolume/MarginContainer/ProgressBar.value = AudioServer.get_bus_volume_db(2);
