extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var down = get_parent().get_node("down")
onready var up = get_parent().get_node("up")
onready var left = get_parent().get_node("left")
onready var right = get_parent().get_node("right")



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func checkOutline():
	visible = true;
	if down.is_colliding():
		if up.is_colliding():
			if left.is_colliding():
				if right.is_colliding():#dulr
					visible = false;
				else:#dul
					frame = 3;
			elif right.is_colliding():#dur
				frame = 1;
			else:#du
				frame = 10;
		else:
			if left.is_colliding():
				if right.is_colliding():#dlr
					frame = 2;
				else:#dl
					frame = 7;
			elif right.is_colliding():#dr
				frame = 6;
			else:#d
				frame = 11;
	else:
		if up.is_colliding():
			if left.is_colliding():
				if right.is_colliding():#ulr
					frame = 4;
				else:#ul
					frame = 8;
			elif right.is_colliding():#ur
				frame = 5;
			else:#u
				frame = 14;
		else:
			if left.is_colliding():
				if right.is_colliding():#lr
					frame = 9;
				else:#l
					frame = 12;
			elif right.is_colliding():#r
				frame = 13;
			else:#none
				frame = 0;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	checkOutline();
