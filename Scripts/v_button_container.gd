extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_restart_pressed():
	print("Restart")
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_to_main_menu_pressed():
	print("Quit to Main Menu Pressed")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_quit_pressed():
	print("Quit Pressed")
	get_tree().paused = false
	get_tree().quit()
