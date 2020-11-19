extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var config = ConfigFile.new();

export var maxBlockFallSpeed = 720;
export var blockGravity = 720;
export var blockOpacityRange = 256.0;
export var flatteningPercentage = 0.5;
export var lavaEnabled = false;
export var lavaSpeed = 2.0;
export var lavaAcceleration = 0.2;
export var maxSpawnRate = 10.0;
export var initialSpawnRate = 1.0;
export var secondsToMax = 120.0;
var gameOver = false;
var paused = false;
var playerMaxBlockHeight = 0;

var keys = {"LEFTKEY" : KEY_A, "RIGHTKEY" : KEY_D, "UPKEY" : KEY_W,
			"DOWNKEY" : KEY_S, "BACKKEY" : KEY_ESCAPE, "SELECTKEY" : KEY_ENTER,
			"RESTARTKEY" : KEY_F5}

func saveConfig():
	for k in keys.keys():
		config.set_value("keys", k, keys[k]);
	config.set_value("audio", "master", AudioServer.get_bus_volume_db(0));
	config.set_value("audio", "sfx", AudioServer.get_bus_volume_db(1));
	config.set_value("audio", "music", AudioServer.get_bus_volume_db(2));
	config.save("user://settings.cfg");

# Called when the node enters the scene tree for the first time.
func _ready():
	var err = config.load("user://settings.cfg");
	if err == OK:
		keys = {"LEFTKEY" : config.get_value("keys", "LEFTKEY", KEY_A),
					"RIGHTKEY" : config.get_value("keys", "RIGHTKEY", KEY_D),
					"UPKEY" : config.get_value("keys", "UPKEY", KEY_W),
					"DOWNKEY" : config.get_value("keys", "DOWNKEY", KEY_S),
					"BACKKEY" : config.get_value("keys", "BACKKEY", KEY_ESCAPE),
					"SELECTKEY" : config.get_value("keys", "SELECTKEY", KEY_ENTER),
					"RESTARTKEY" : config.get_value("keys", "RESTARTKEY", KEY_F5)}
		AudioServer.set_bus_volume_db(0, config.get_value("audio", "master", 0));
		AudioServer.set_bus_volume_db(1, config.get_value("audio", "sfx", 0));
		AudioServer.set_bus_volume_db(2, config.get_value("audio", "music", 0));

func updateBlockHeight(x):
	playerMaxBlockHeight = x;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass;
