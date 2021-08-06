extends Node
var systems = []
var StarSystem = preload("res://scenes/StarSystem.tscn")
var starSystem


func generate():
	starSystem = StarSystem.instance()
	starSystem.generate()
	starSystem.draw()
	systems.append(starSystem)


func _on_GenerateButton_pressed():
	generate()
