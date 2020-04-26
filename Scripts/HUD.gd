extends CanvasLayer

var current_font_size;
var default_font_size;

func _ready():
	$"../../Main".connect("update_score", self, "update_score")
	$"../../Main".connect("update_fuel", self, "update_fuel")
	$"../../Main".connect("update_multiplier", self, "update_multiplier")
	
	default_font_size = $Score.get("custom_fonts/font").size
	current_font_size = default_font_size;

func _process(delta):
	var newSize = current_font_size + ((default_font_size - current_font_size) * 0.1)
	current_font_size = newSize
	$Score.get("custom_fonts/font").size = newSize

func update_score(score):
	current_font_size += 10
	$Score.text = str(score)

func update_fuel(amount: int):
	var segment_size = $Fuelbar.rect_size.x / 10;
	$Fuelbar/Fuelindicator.rect_size.x = segment_size * amount

func update_multiplier(amount: int):
	$Score/ScoreMultiplier.text = str(amount) + "x"
