extends Node2D

onready var global = get_node("/root/Global");
onready var blockLocationsSize = 20 - (global.flatteningPercentage * 20)
var blockFallSpeed = 100;
var blockGravity = 100;
export (PackedScene) var blockToSpawn;
export (PackedScene) var explodingBlockToSpawn;
export (PackedScene) var yellowBlock;
export (PackedScene) var timeBlock;
export (PackedScene) var superBlock;
export (PackedScene) var metalBlock;
export (PackedScene) var appearAnimation;
onready var maxSpawnRate = global.maxSpawnRate;
onready var initialSpawnRate = global.initialSpawnRate;
onready var secondsToMax = global.secondsToMax;
var time = initialSpawnRate;
const BLOCK_LOCATIONS = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
var emptyLocations = [];
var blockedLocations = [];
var spawntimer = 0.0;
var slowed = false;
var maxtime = 1.0;
var maxwavetime = rand_range(30, 90);
var wavetimer = 0;
enum {STATE_NORMAL, STATE_WAVE};
export var spawnstate = STATE_NORMAL;


# Called when the node enters the scene tree for the first time.
func _ready():
	blockFallSpeed = global.blockFallSpeed;
	blockGravity = global.blockGravity;
	emptyLocations += BLOCK_LOCATIONS;
	maxtime = 1.0/initialSpawnRate;
	$tween.interpolate_property(self, "maxtime", 1.0/initialSpawnRate, 1.0/maxSpawnRate, secondsToMax, Tween.TRANS_CUBIC, Tween.EASE_OUT);
	$tween.start();
	$blockfalltween.interpolate_property(self, "blockFallSpeed", global.blockFallSpeed, global.maxBlockFallSpeed, secondsToMax, Tween.TRANS_LINEAR, Tween.EASE_OUT);
	$blockfalltween.start();
	$gravitytween.interpolate_property(self, "blockGravity", global.blockGravity, global.maxBlockGravity, secondsToMax, Tween.TRANS_LINEAR, Tween.EASE_OUT);
	$gravitytween.start();
	randomize();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.gameStarted and not global.gameOver:
#		if Input.is_key_pressed(KEY_L):
#			timeout();
		if spawnstate == STATE_NORMAL:
			$tween.playback_speed = global.timescale;
			spawntimer += 1.0 * delta * global.timescale;
			if spawntimer >= maxtime:
				timeout();
			wavetimer += 1.0 * delta * global.timescale;
			if wavetimer >= maxwavetime:
				spawnstate = STATE_WAVE;
				$waveintroanimation.play("waveintro");
				$"../sceneCamera/hud/warning/middletext".text = "WAVE INCOMING";
				wavetimer = 0;

func timeout():
	var block = null;
	if not global.gameOver:
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
		var possibleLocations = emptyLocations;
		for i in blockedLocations:
			possibleLocations.erase(i);
		if possibleLocations.size() == 0:
			return;
		var spawnLocation = possibleLocations[randi() % possibleLocations.size()];
		emptyLocations.erase(spawnLocation);
		blockedLocations.append(spawnLocation);
		var blockpos = Vector2(spawnLocation*32 - 16, get_parent().get_node("sceneCamera").position.y + 16);
		
		block.position = blockpos;
		block.fallspeed = blockFallSpeed;
		block.gravity = blockGravity;
		blockappear.position = blockpos;
		blockappear.position.y += 16;
		add_child(blockappear);
		add_child(block);

func spawnIntro(x):
	var blockappear = appearAnimation.instance();
	var block = metalBlock.instance();
	var blockpos = Vector2(x, get_parent().get_node("sceneCamera").position.y + 16);
	block.fallspeed = 700;
	block.gravity = 700;
	block.position = blockpos;
	blockappear.position = blockpos;
	blockappear.position.y += 16;
	add_child(blockappear);
	add_child(block);

func spawnAtLocationBlock(x, b):
	var block = blockToSpawn.instance();
	match b:
		0:
			block = blockToSpawn.instance();
		1:
			block = explodingBlockToSpawn.instance();
	var blockappear = appearAnimation.instance();
	var blockpos = Vector2(x, get_parent().get_node("sceneCamera").position.y + 16);
	block.fallspeed = blockFallSpeed;
	block.gravity = blockGravity;
	block.position = blockpos;
	blockappear.position = blockpos;
	blockappear.position.y += 16;
	add_child(blockappear);
	add_child(block);

func startRandomWave():
	$waveanimation.play("lefttoright");
