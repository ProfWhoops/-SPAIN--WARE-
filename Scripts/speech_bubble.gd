@icon("res://Assets/Art/Speech Bubble/Speech Bubble.svg")
extends Control

@export var target_npc : StaticBody2D

@export var pointer_offset_x_right := -190.0
@export var pointer_offset_x_left := 80.0
@export var pointer_offset_y := 135.0

@export var clamp_margin_x := 50.0

@onready var bubble = %BubbleTexture as TextureRect
@onready var pointer = %PointerTexture as TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not target_npc:
		return
	
	
	var camera := get_viewport().get_camera_2d()
	if not camera:
		return
		
	

	var npc_screen_position := (target_npc.global_position - camera.global_position) * camera.zoom + get_viewport().get_visible_rect().size / 2
	var local_position = npc_screen_position - bubble.global_position
	
	var applied_offset := Vector2.ZERO
	
	if local_position.x < bubble.size.x / 2:
		applied_offset.x = pointer_offset_x_left
		pointer.flip_h = true
	else:
		applied_offset.x = pointer_offset_x_right
		pointer.flip_h = false
	
	
	
	local_position += applied_offset

	
	var min_x := clamp_margin_x
	var max_x = bubble.size.x - pointer.size.x - clamp_margin_x

	pointer.position.x = clamp(local_position.x, min_x, max_x)
	pointer.position.y = pointer_offset_y

	
