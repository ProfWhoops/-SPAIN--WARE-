class_name SaveData
extends Resource

const SAVE_GAME_PATH := "user://variable.save"

static var translate_high_score := 0
static var played_before := false


static func save() -> void:
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	file.store_var(translate_high_score)
	file.store_var(played_before)
	
static func load_data() -> void:
	if FileAccess.file_exists(SAVE_GAME_PATH):
		var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
		translate_high_score = file.get_var()
		played_before = file.get_var()
	else:
		print("No data has been saved at:", SAVE_GAME_PATH)

static func delete_data() -> void:
	translate_high_score = 0
	played_before = false
	save()
