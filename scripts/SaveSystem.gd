extends Node
onready var SystemGenerator = get_node("../SystemGenerator")
var save_dict = {}


func save():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	SystemGenerator.save()
	save_dict = SystemGenerator.save_dict
	save_game.store_line(to_json(save_dict))
	save_game.close()


func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return
	save_game.open("user://savegame.save", File.READ)
	save_dict = parse_json(save_game.get_line())
	SystemGenerator.load_game(save_dict)
	SystemGenerator.draw()


func _on_SaveButton_pressed():
	save()


func _on_LoadButton_pressed():
	load_game()
