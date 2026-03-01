@icon("res://Assets/Art/heart.svg")
extends HBoxContainer

@onready var game_over = %"Game Over"
@onready var game_music = %"Game Music"


const FULL_HEART = preload("uid://coou7g4f720sw")
const LOST_HEART = preload("uid://dwlar1fpgn6x4")
const EVIL_HEART = preload("uid://bjhsib8rixecp")

var hearts := 3

# Called when the node enters the scene tree for the first time.
func _ready():
	game_over.hide()
	update_health(hearts)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hearts <= 0:
		pass
		on_game_over()

func change_health(number : int):
	hearts += number
	hearts = clamp(hearts, 0, 3)
	update_health(hearts)
	
func update_health(value):
	for i in get_child_count():
		if value > i:
			get_child(i).texture = FULL_HEART
		else:
			get_child(i).texture = LOST_HEART

func on_game_over():
	get_tree().paused = true
	game_music.stop()
	game_over.show()
