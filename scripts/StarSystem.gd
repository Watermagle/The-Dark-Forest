extends Node2D
var stars = []
var StellarObject = preload('res://scenes/StellarObject.tscn')
var star


func generate():
	star = StellarObject.instance()
	star.init()
	star.generate()
	stars.append(star)


func draw():
	star.draw()
