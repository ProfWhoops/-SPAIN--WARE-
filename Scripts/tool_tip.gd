extends PanelContainer

@onready var content = $Content

const OFFSET := Vector2.ONE * 30.0
const FLIP_OFFSET := -16.5
var opacity_tween: Tween = null



func _ready() -> void: hide()


	
func _input(event: InputEvent) -> void:
	if visible and event is InputEventMouseMotion:
		
		var mouse_position = get_global_mouse_position()
		var flipped_offset := OFFSET
		
		if mouse_position.x + size.x + OFFSET.x > get_viewport_rect().size.x:
			print("flip")
			flipped_offset.x = -size.x - OFFSET.x
		else:
			print("norm")
		
		global_position = mouse_position + flipped_offset
		
func toggle(on : bool):
	if on:
		show()
		modulate.a = 0.0
		tween_opacity(1.0)
	else:
		modulate.a = 1.0
		await tween_opacity(0.0).finished
		hide()
		
func tween_opacity(to: float):
	
	if opacity_tween : opacity_tween.kill()
	
	opacity_tween = get_tree().create_tween()
	opacity_tween.tween_property(self, "modulate:a", to, 0.3)
	return opacity_tween

func set_text(text : String):
	content.text = text
