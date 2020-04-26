extends Node

var rocketburstParticlesScene = preload("res://Prefabs/RocketBurstParticles.tscn")
var explosionParticlesScene = preload("res://Prefabs/ExplosionParticles.tscn")

onready var Player = $"../Player";
onready var PlayerSprite = $"../Player/Sprite";

func _ready():
	$"../Player".connect("on_dash", self, "render_rocket_particles")
	$"../Player".connect("enemy_killed", self, "render_explosion_particles")

func render_rocket_particles(body):
	var rocketNode = rocketburstParticlesScene.instance()
	rocketNode.position = Player.position
	rocketNode.rotation = PlayerSprite.rotation
	add_child(rocketNode)

func render_explosion_particles(body):
	var explNode = explosionParticlesScene.instance()
	explNode.position = body.position
	add_child(explNode)
