extends Node2D
var stars = []
var StellarObject = preload('res://scenes/StellarObject.tscn')
var star
var stars_save = []
var save_dict = {}


func generate():
	star = StellarObject.instance()
	star.init('star')
	star.generate()
	stars.append(star)


func draw():
	for star in stars:
		add_child(star)
		star.draw()


func destroy():
	star.destroy()
	queue_free()


func save():
	stars_save = []
	for star in stars:
		star.save()
		stars_save.append(star.save_dict)
	save_dict['stars'] = stars_save


func load_game(save_dict):
	stars_save = save_dict['stars']
	stars = []
	for star_save in stars_save:
		star = StellarObject.instance()
		star.load_game(star_save)
		stars.append(star)
