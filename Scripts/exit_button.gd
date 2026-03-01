extends Button


func _on_pressed():
	SaveData.played_before = true
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
