extends Node
var systems = []
var StarSystem = preload("res://scenes/StarSystem.tscn")
var starSystem
var isSystemGenerated = false


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


func _on_GenerateButton_pressed():
	generate()
