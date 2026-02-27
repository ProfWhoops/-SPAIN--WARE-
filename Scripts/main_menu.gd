extends Control

@onready var main_buttons = get_tree().get_nodes_in_group("Main Button")
@onready var settings_panel = $SettingsPanel

# Called when the node enters the scene tree for the first time.
func _ready():
	for node in main_buttons:
		node.visible = true
	settings_panel.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_game_pressed():
	print("Start Pressed")
	get_tree().change_scene_to_file("res://Scenes/translate.tscn")


func _on_settings_pressed():
	print("Settings Pressed")
	for node in main_buttons:
		node.visible = false
	settings_panel.visible = true
	


func _on_quit_pressed():
	print("Quit Pressed")
	get_tree().quit()


func _on_back_pressed():
	_ready()


func _on_minigames_pressed():
	print("Minigames Pressed")
	get_tree().change_scene_to_file("res://Scenes/translate.tscn")


func _on_credits_pressed():
	print("Credits Pressed")
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")
