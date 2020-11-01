extends AudioStreamPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global = get_node("/root/Global");
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#func _player_in_lava(body):
#	AudioServer.set_bus_effect_enabled(2, 0, true);
#func _player_exited_lava(body):
#	AudioServer.set_bus_effect_enabled(2, 0, false);
