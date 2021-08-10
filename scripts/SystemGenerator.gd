extends Node
var systems = []
var StarSystem = preload("res://scenes/StarSystem.tscn")
var starSystem
var isSystemGenerated = false
var save_dict = {}


func generate():
	if isSystemGenerated == false:
		starSystem = StarSystem.instance()
		starSystem.generate()
		add_child(starSystem)
		starSystem.draw()
		systems.append(starSystem)
		isSystemGenerated = true
	else:
		starSystem.destroy()
		starSystem = StarSystem.instance()
		starSystem.generate()
		add_child(starSystem)
		starSystem.draw()
		systems.append(starSystem)
		isSystemGenerated = true


func save():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	if isSystemGenerated == true:
		starSystem.save()
		save_dict = inst2dict(starSystem)
		save_game.store_line(to_json(save_dict))
	save_game.close()


func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return
	if isSystemGenerated == true:
		starSystem.destroy()
	save_game.open("user://savegame.save", File.READ)
	while save_game.get_position() < save_game.get_len():
		save_dict = parse_json(save_game.get_line())
		starSystem = dict2inst(save_dict)
		systems = []
		starSystem.load_game()
		systems.append(starSystem)
		starSystem.draw()


func _on_GenerateButton_pressed():
	generate()


func _on_SaveButton_pressed():
	save()


func _on_LoadButton_pressed():
	load_game()
