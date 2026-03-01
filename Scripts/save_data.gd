extends Resource

const SAVE_GAME_PATH := "user://variable.save"

var translate_high_score := 0
var played_before := false


func save():
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	file.store_var(translate_high_score)
	file.store_var(played_before)
	
func load_data():
	if FileAccess.file_exists(SAVE_GAME_PATH):
		var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
		translate_high_score = file.get_var()
		played_before = file.get_var()
	else:
		print("No data has been saved at:", SAVE_GAME_PATH)
