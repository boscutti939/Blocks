extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global = get_node("/root/Global");
onready var blockLocationsSize = 20 - (global.flatteningPercentage * 20)
export (PackedScene) var blockToSpawn;
export (PackedScene) var explodingBlockToSpawn;
export (PackedScene) var yellowBlock;
export (PackedScene) var appearAnimation;
onready var maxSpawnRate = global.maxSpawnRate;
onready var initialSpawnRate = global.initialSpawnRate;
onready var secondsToMax = global.secondsToMax;
var time = initialSpawnRate;
const BLOCK_LOCATIONS = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
var emptyLocations = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	emptyLocations += BLOCK_LOCATIONS;
	$timer.wait_time = 1.0/initialSpawnRate;
	$tween.interpolate_property(self, "time", 1.0/initialSpawnRate, 1.0/maxSpawnRate, secondsToMax,Tween.TRANS_CUBIC, Tween.EASE_OUT);
	$tween.start();
	randomize();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Timer_timeout():
	var block = null;
	if get_parent().has_node("player"):
		$timer.wait_time = rand_range(1.0/maxSpawnRate, time);
		var choice = round(rand_range(0, 100));
		if choice in range(0, 80):
			block = blockToSpawn.instance();
		elif choice in range(80, 98):
			block = explodingBlockToSpawn.instance();
		else:
			block = yellowBlock.instance();

		var blockappear = appearAnimation.instance();
		if emptyLocations.size() <= blockLocationsSize:
			emptyLocations.clear()
			emptyLocations += BLOCK_LOCATIONS;
		var spawnLocation = emptyLocations[randi() % emptyLocations.size()];
		emptyLocations.erase(spawnLocation);
		var blockpos = Vector2(spawnLocation*32 - 16, get_parent().get_node("sceneCamera").position.y + 16);
		
		block.position = blockpos
		blockappear.position = blockpos
		blockappear.position.y += 16
		add_child(blockappear)
		add_child(block);
