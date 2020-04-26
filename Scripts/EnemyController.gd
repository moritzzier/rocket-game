extends Node

export var max_enemy_count = 100
export var max_spawn_height = 1000
export var min_distance_from_player = 200
export var max_distance_from_player = 400

onready var Player = $"../Player";

var enemyScene = preload("res://Prefabs/NormalEnemy.tscn")

var distance = 0;
var usedPosX = false;
var game_over = false;

func _ready():
	Player.connect("enemy_killed", self, "_enemy_killed")
	$"../../Main".connect('on_game_over', self, "on_game_over")

func _process(_delta):
	if(!game_over):
		if(distance - 25 > Player.position.x || distance + 25 < Player.position.x):
			print("distance ", distance, " player position ", Player.position.x)
			distance = Player.position.x
			remove_far_enemys()
			if(get_child_count() < max_enemy_count):
				_spawn_enemy()
				_spawn_enemy()
				_spawn_enemy()
				_spawn_enemy()
				_spawn_enemy()				
		

func _spawn_enemy():
	var yPos = pow(rand_range(1, 30), 2)
	var xPos = 0;
	if randf() < 0.5:
		xPos = Player.position.x + rand_range(min_distance_from_player, max_distance_from_player)
	else:
		xPos = Player.position.x - rand_range(min_distance_from_player, max_distance_from_player)
			
	var new_enemy = enemyScene.instance()
	new_enemy.position = Vector2(xPos, -yPos)
	print("new enemys at: (", xPos, ",", -yPos, ")")
	add_child(new_enemy)

func _enemy_killed(body):
	body.queue_free()

func remove_far_enemys():
	for N in get_children():
		if(N.position.x - (max_distance_from_player + 50) > Player.position.x || N.position.x + (max_distance_from_player + 50) < Player.position.x):
			print("Node too far away: Removing")
			N.queue_free()

func on_game_over():
	game_over = true;
