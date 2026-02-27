extends Control

@onready var credits_music = $"Credits Music" as AudioStreamPlayer
@onready var credits_text = $"Credits Text" as RichTextLabel
@onready var title = $Title as Control
@onready var intersection_point = $"Intersection Point" as Control
@onready var exit = $Exit

@export var speed := -0.5


var reached_end := false
var opacity_tween : Tween = null
var credits_text_bottom : int
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#credits_text_bottom = credits_text.shape


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if reached_end:
		return
		
	credits_text.position.y += speed
	title.position.y += speed
	
	if not is_colliding(credits_text, intersection_point):
		reached_end = true
		exit.show()
		
func is_colliding(node1 : Control, node2 : Control) -> bool:
	return node1.get_global_rect().intersects(node2.get_global_rect())


func _on_exit_pressed():
	print("Exit Pressed")
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
