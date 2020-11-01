extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var maxBlockFallSpeed = 720;
export var blockGravity = 720;
export var blockOpacityRange = 256.0;
export var flatteningPercentage = 0.5;
export var lavaEnabled = false;
export var lavaSpeed = 2.0;
export var lavaAcceleration = 0.2;
export var maxSpawnRate = 6.0;
export var initialSpawnRate = 1.0;
export var secondsToMax = 120.0;
var gameOver = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
