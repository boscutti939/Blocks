extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global = get_node("/root/Global");
onready var blockLocationsSize = 20 - (global.flatteningPercentage * 20)
export (PackedScene) var blockToSpawn;
export (PackedScene) var explodingBlockToSpawn;
export (PackedScene) var yellowBlock;
export (PackedScene) var timeBlock;
export (PackedScene) var superBlock;
export (PackedScene) var appearAnimation;
onready var maxSpawnRate = global.maxSpawnRate;
onready var initialSpawnRate = global.initialSpawnRate;
onready var secondsToMax = global.secondsToMax;
var time = initialSpawnRate;
const BLOCK_LOCATIONS = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
var emptyLocations = [];
var spawntimer = 0.0;
var slowed = false;
var maxtime = 1.0;
# Called when the node enters the scene tree for the first time.
func _ready():
	emptyLocations += BLOCK_LOCATIONS;
	maxtime = 1.0/initialSpawnRate;
	$tween.interpolate_property(self, "maxtime", 1.0/initialSpawnRate, 1.0/maxSpawnRate, secondsToMax,Tween.TRANS_CUBIC, Tween.EASE_OUT);
	$tween.start();
	randomize();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$tween.playback_speed = global.timescale;
	spawntimer += 1.0 * delta * global.timescale;
	if spawntimer >= maxtime:
		timeout();

func timeout():
	var block = null;
	if get_parent().has_node("player"):
		spawntimer = rand_range(0.0, maxtime);
		var choice = randi() % 101;
		if choice in range(0, 90):
			block = blockToSpawn.instance();
		elif choice in range(91, 99):
			block = explodingBlockToSpawn.instance();
		else:
			choice = randi() % 3;
			match choice:
				0:
					block = yellowBlock.instance();
				1:
					block = timeBlock.instance();
				2:
					block = superBlock.instance();

		var blockappear = appearAnimation.instance();
		if emptyLocations.size() <= blockLocationsSize:
			emptyLocations.clear()
			emptyLocations += BLOCK_LOCATIONS;
		var spawnLocation = emptyLocations[randi() % emptyLocations.size()];
		emptyLocations.erase(spawnLocation);
		var blockpos = Vector2(spawnLocation*32 - 16, get_parent().get_node("sceneCamera").position.y + 16);
		
		block.position = blockpos;
		blockappear.position = blockpos;
		blockappear.position.y += 16
		add_child(blockappear)
		add_child(block);
