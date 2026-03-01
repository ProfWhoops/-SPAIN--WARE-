@icon("res://Assets/Art/coin.svg")
extends RichTextLabel

@onready var hearts = $"../Hearts"

var value := 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "[img=75]res://Assets/Art/coin.svg[/img] : %d" % value
	
	if value >= 10:
		hearts.change_health(1)
		value -= 10

func add_value(number : int):
	value += number
