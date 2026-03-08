extends TextureButton

@onready var tool_tip = $ToolTip

@export var minigame : String

var changing_scene := false
# Called when the node enters the scene tree for the first time.

func _ready():
	var minigame_text : String
	match minigame:
		"placeholder":
			minigame_text = "[b]Placeholder[/b] [br] If you see this there is something wrong with the game"
		"translate":
			minigame_text = "[b]Translate[/b] [br] [img=400]res://Assets/Art/Translate Screenshot.PNG[/img][br]Try to pick the correct ? block in this tough game!"
	tool_tip.set_text(minigame_text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	tool_tip.toggle(true)


func _on_mouse_exited():
	if not changing_scene:
		tool_tip.toggle(false)


func _on_pressed():
	print("Map Pointer: ", minigame, " Pressed")
	match minigame:
		"translate":
			AcrossSceneAudio.stop()
			changing_scene = true
			get_tree().change_scene_to_file("res://Scenes/translate.tscn")
			
