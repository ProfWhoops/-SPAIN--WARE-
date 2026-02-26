extends Control

@onready var label_1 = $ChoiceLabels/Label1 as Label
@onready var label_2 = $ChoiceLabels/Label2 as Label
@onready var correct_label = $ChoiceLabels/CorrectLabel as Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debug"):
		label_1.add_theme_color_override("font_color", Color.RED)
		label_2.add_theme_color_override("font_color", Color.YELLOW)
		correct_label.add_theme_color_override("font_color", Color.GREEN)
