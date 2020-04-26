extends RigidBody2D

signal enemy_killed(body);
signal on_dash(body);

export var force = 400; 

var look_at_mouse = false;

func _process(_delta):
	if(look_at_mouse):
		$Sprite.look_at(get_global_mouse_position())
	else:
		if(linear_velocity.length() > 10):
			$Sprite.look_at(linear_velocity + position)

func _integrate_forces(state):
	if(Input.is_action_just_pressed("click")):
			slowmo_begin()
	
	if(Input.is_action_just_released("click")):
			state.linear_velocity = Vector2(0, 0)
			var mousePosition: Vector2 = get_local_mouse_position()
			apply_impulse(Vector2(0,0), mousePosition.normalized() * force)
			slowmo_end()

func slowmo_begin():
	Engine.time_scale = 0.5
	look_at_mouse = true;
	
func slowmo_end():
	Engine.time_scale = 1
	emit_signal("on_dash", self)
	look_at_mouse = false;				

func _on_Player_body_entered(body):	
	if(body.is_in_group("enemy")):
		emit_signal("enemy_killed", body)
		apply_impulse(Vector2(0,0), Vector2(0, -1) * force)
