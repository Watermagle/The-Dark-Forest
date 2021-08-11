extends Node
var systems = [0]
var StarSystem = preload("res://scenes/StarSystem.tscn")
var system
var save_dict = {}
var systems_save = []
var current_system = 0


func _ready():
	generate()


func generate():
	system = StarSystem.instance()
	system.generate()
	systems[current_system] = system
	draw()


func draw():
	print(systems)
	add_child(systems[current_system])
	systems[current_system].draw()


func save():
	systems_save = []
	for system in systems:
		system.save()
		systems_save.append(system.save_dict)
	save_dict['systems'] = systems_save


func load_game(save_dict):
	for system in systems:
		system.destroy()
	systems_save = save_dict['systems']
	systems = []
	for system_save in systems_save:
		system = StarSystem.instance()
		system.load_game(system_save)
		systems.append(system)


func _on_GenerateButton_pressed():
	systems[current_system].destroy()
	generate()
