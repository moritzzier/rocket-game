extends Node2D

signal update_score(score)
signal update_fuel(amount)
signal update_multiplier(amount)
signal on_game_over()

var score = 0;
var fuel = 5;
var max_fuel = 10;
var score_multiplier = 1;

func _ready():
	$Player.connect('enemy_killed', self, 'enemy_killed')
	$Player.connect('on_dash', self, 'on_dash')
	$MultiplierTimer.connect('timeout', self, 'on_timeout')
	emit_signal('update_fuel', fuel)
	
func enemy_killed(body):
	var new_score = score + (100 * score_multiplier)
	emit_signal('update_score', new_score);
	score = new_score
	
	fuel = clamp(fuel + 2, 0, max_fuel)
	emit_signal('update_fuel', fuel)
	score_multiplier += 1
	emit_signal('update_multiplier', score_multiplier);	

func on_dash(player):
	fuel -= 1
	emit_signal('update_fuel', fuel)
	if(fuel < 0):
		$Player.queue_free()
		emit_signal('on_game_over')

func on_timeout():
	if(score_multiplier > 1):
		score_multiplier -= round(score_multiplier / 2)
		emit_signal('update_multiplier', score_multiplier);
