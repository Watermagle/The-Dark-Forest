extends Node2D
var stars = []
var StellarObject = preload('res://scenes/StellarObject.tscn')
var star


func generate():
	star = StellarObject.instance()
	star.init('star')
	star.generate()
	stars.append(star)


func draw():
	add_child(star)
	star.draw()


func destroy():
	star.destroy()
	queue_free()
