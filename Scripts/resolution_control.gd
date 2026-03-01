extends OptionButton


func _on_item_selected(index):
	var options = [4, 2, 1, 0.5, 0.25, 0.1]
	var value = options[index]
	print(value)
	
