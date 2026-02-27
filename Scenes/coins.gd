extends RichTextLabel

var value := 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "[img=75]res://Assets/Art/coin.svg[/img] : %d" % value

func add_value(number : int):
	value += number
