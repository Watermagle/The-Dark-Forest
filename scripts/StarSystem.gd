extends Node2D
var stars = []
var StellarObject = preload('res://scenes/StellarObject.tscn')
var star
var star_save_list = []
var save_dict = {}


func generate():
	star = StellarObject.instance()
	star.init('star')
	star.generate()
	stars.append(star)


func draw():
	for starDraw in stars:
		add_child(starDraw)
		starDraw.draw()


func destroy():
	star.destroy()
	queue_free()


func save():
	for star in stars:
		star.save()
		save_dict = inst2dict(star)
		save_dict["STAR_POSITION_X"] = star.position.x
		save_dict["STAR_POSITION_Y"] = star.position.y
		save_dict["STAR_SCALE_X"] = star.scale.x
		save_dict["STAR_SCALE_Y"] = star.position.y
		star_save_list.append(save_dict)


func load_game():
	stars = []
	for star in star_save_list:
		var new_star = dict2inst(star)
		new_star.position.x = float(star["STAR_POSITION_X"])
		new_star.position.y = float(star["STAR_POSITION_Y"])
		new_star.scale.x = float(star["STAR_SCALE_X"])
		new_star.scale.y = float(star["STAR_SCALE_Y"])
		new_star.load_game()
		stars.append(new_star)
