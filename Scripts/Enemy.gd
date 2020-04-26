extends RigidBody2D


func _ready():
	randomize()
	
	if randf() < 0.5:
		$AnimatedSprite.flip_h = true
	
	var randomFrame = round(rand_range(0, $AnimatedSprite.frames.get_frame_count("default")))
	$AnimatedSprite.frame = randomFrame
