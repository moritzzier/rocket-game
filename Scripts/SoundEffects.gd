extends AudioStreamPlayer2D

var sfx_explosion1 = preload("res://Sounds/Explosion.wav");
var sfx_explosion2 = preload("res://Sounds/Explosion2.wav");
var sfx_shoot1 = preload("res://Sounds/Shoot.wav");
var sfx_shoot2 = preload("res://Sounds/Shoot2.wav");

func _ready():
	$"../Player".connect("enemy_killed", self, "explosion")
	$"../Player".connect("on_dash", self, "dash")

func explosion(body):
	var randombool = round(randf());
	stream = sfx_explosion1;
	if(randombool):
		stream = sfx_explosion2
	position = body.position;
	play()
	
func dash(body):
	var randombool = round(randf());
	stream = sfx_shoot1;
	if(randombool):
		stream = sfx_shoot2
	position = body.position;
	play()
