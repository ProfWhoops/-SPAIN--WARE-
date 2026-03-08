extends Button

@onready var window = $Window

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	window.show()

func delete_data_fr_this_time():
	SaveData.delete_data()
	get_tree().quit()

func _on_no_pressed():
	window.hide()
