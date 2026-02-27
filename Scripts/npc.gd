extends StaticBody2D

@onready var coins = $"../CanvasLayer/Control/Coins" as RichTextLabel
@onready var label = %DialogueLabel as Label
@onready var pointer = %PointerTexture as TextureRect
@onready var sprite_2d = $Sprite2D as Sprite2D
@onready var shuffle_delay_timer = $ShuffleDelayTimer

@export var npc_lines := [
	{
	"question" : "¿Dónde está la estación?",
	"correct" : "The station is in the town centre"
	},
	{
	"question" : "¿Cómo te llamas?",
	"correct" : "My name is Hugo"
	},
	{
	"question" : "¿Cuántos años tiene?",
	"correct" : "I am 13 years old"
	}
]

@export var choice_blocks : Node2D
var last_line_index := -1

# Called when the node enters the scene tree for the first time.
func _ready():
	await choice_blocks.ready
	ask_new_question()
	reset_and_shuffle_blocks()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite_2d.flip_h = pointer.flip_h
	if Input.is_action_just_pressed("debug"):
		ask_new_question()
	
func ask_new_question():
	var line_index = randi() % npc_lines.size()
	while line_index == last_line_index:
		line_index = randi() % npc_lines.size()
	last_line_index = line_index
	
	var npc_line = npc_lines[line_index]
	label.text = npc_line["question"]
	
	var blocks = choice_blocks.get_children()
	
	for block in blocks:
		if block.is_correct:
			block.setup_block(npc_line["correct"])
		else:
			var wrong_answers := []
			for i in npc_lines.size():
				if i != line_index:
					wrong_answers.append(npc_lines[i]["correct"])
			wrong_answers.shuffle()
			block.setup_block(wrong_answers.pop_front())

func reset_and_shuffle_blocks():
	var blocks := choice_blocks.get_children()
	for block in blocks:
		if block.has_method("reset_block"):
			block.reset_block()
		var positions : Array
		for b in blocks:
			positions.append(b.position)
			
		positions.shuffle()
		
		for i in blocks.size():
			
			blocks[i].position = positions[i]
func wrong_button_pressed():
	print("Wrong button pressed!")

func correct_button_pressed():
	print("Correct button pressed!")
	coins.add_value(1)
	var blocks := choice_blocks.get_children()
	for i in blocks.size():
		if blocks[i].has_method("bump"):
			blocks[i].bump()
	shuffle_delay_timer.start()
	
	

func _on_block_hit(correct):
	if correct:
		correct_button_pressed()
	else:
		wrong_button_pressed()


func _on_shuffle_delay_timer_timeout():
	ask_new_question()
	reset_and_shuffle_blocks()
