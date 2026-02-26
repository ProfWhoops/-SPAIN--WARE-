extends StaticBody2D

@export var bump_height := 100
@export var bump_time := 0.15
@export var bool_block : bool
@export var is_correct : bool
@onready var sprite_2d = $Sprite2D
@onready var bonk_collisions = $BonkCollisions
@onready var tool_tip = $ToolTip
@onready var audio_block_hit = $"Block Hit"
@onready var correct_block_hit = $"Correct Block Hit"

const Q_BLOCK = preload("uid://c18rgsblk18op")
const USED_BLOCK = preload("uid://cqo1if6h6kse0")

var original_position : Vector2
var bonking := false
var bonked := false

signal block_hit(correct : bool)
# Called when the node enters the scene tree for the first time.
func _ready():
	original_position = sprite_2d.position
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	


func _on_bonk_collisions_body_entered(body):
	if body.is_in_group("Player") && not bonking && not bonked:
		print("bonked!")
		bump()
		if bool_block:
			emit_signal("block_hit", is_correct)

func bump():
	audio_block_hit.play()
	if is_correct:
		correct_block_hit.play()
	bonking = true
	bonked = true
	sprite_2d.texture = USED_BLOCK
	var tween = create_tween()
	
	var up_tween = tween.tween_property(sprite_2d, "position:y", original_position.y - bump_height, bump_time)
	up_tween.set_trans(Tween.TRANS_SINE)
	up_tween.set_ease(Tween.EASE_OUT)
	
	var down_tween = tween.tween_property(sprite_2d, "position:y", original_position.y, bump_time)
	down_tween.set_trans(Tween.TRANS_SINE)
	down_tween.set_ease(Tween.EASE_IN)
	down_tween.set_delay(bump_time)
	
	tween.finished.connect(_on_tween_finished)
func _on_tween_finished():
	bonking = false
	
func reset_block():
	bonked = false
	sprite_2d.texture = Q_BLOCK

func on_mouse_entered():
	tool_tip.toggle(true)
func on_mouse_exited():
	tool_tip.toggle(false)

func setup_block(text : String):
	tool_tip.set_text(text)
