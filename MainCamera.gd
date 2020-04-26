extends Camera2D

export var zoomFactor = 0.01;
export var smoothAmount = 0.01;

onready var Player = $"../Player";

var game_over = false;

func _ready():
	$"../../Main".connect('on_game_over', self, 'on_game_over')

func _physics_process(delta):
	if(!game_over):
		var speed = clamp(Player.linear_velocity.length(), 1 ,200) / 200
				
		var targetZoom: float = 1 + 1 * speed
		var currentZoom = zoom.x
		
		var calculatedZoom = currentZoom + ((targetZoom - currentZoom) * smoothAmount)
		
		zoom = Vector2(calculatedZoom, calculatedZoom)
		position = Player.position

func on_game_over():
	game_over = true;
