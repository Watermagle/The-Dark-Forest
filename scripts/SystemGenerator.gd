extends Node
var systems = [0]
var StarSystem = preload("res://scenes/StarSystem.tscn")
var system
var save_dict = {}
var systems_save = []
var current_system = 0
var showPlanetOrbits = false
var showMoonOrbits = false
signal repass


func _ready():
	generate()


func generate():
	system = StarSystem.instance()
	system.generate()
	if showPlanetOrbits == true:
		system.passPlanet()
	elif showMoonOrbits == true:
		system.passMoon()
	systems[current_system] = system
	draw()


func draw():
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
	emit_signal("repass")


func _on_GenerateButton_pressed():
	systems[current_system].destroy()
	generate()


func passPlanet():
	for system in systems:
		system.passPlanet()
	showPlanetOrbits = true
	showMoonOrbits = false


func passMoon():
	for system in systems:
		system.passMoon()
	showPlanetOrbits = false
	showMoonOrbits = true


func passNothing():
	for system in systems:
		system.passNothing()
		showPlanetOrbits = false
		showMoonOrbits = false


func _on_Camera_planet():
	passPlanet()


func _on_Camera_moon():
	passMoon()


func _on_Camera_nothing():
	passNothing()
