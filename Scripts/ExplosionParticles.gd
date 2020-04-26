extends CPUParticles2D

func _ready():
	$Timer.wait_time = lifetime
	$Timer.connect("timeout", self, "timeout")
	emitting = true;

func timeout():
	queue_free()
