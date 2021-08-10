extends MeshInstance2D
var StellarObject = load('res://scenes/StellarObject.tscn')
var stellarType
var planets = []
var moons = []
var planet
var moon
var solidOffset = 100
var gasOffset = 1000
var moonOffset = 100
var gasMoonOffset = 10
var standartSolidMoonRadius = 0.2
var standartGasMoonRadius = 0.02
var standartSolidPlanetRadius = 0.01
var standartGasPlanetRadius = 0.1
var standartStarRadius = 5000
var currentOffset = 0
var randomRadius
var moon_save_list = []
var planet_save_list = []
var save_dict = {}


func init(inputStellarType):
	self.stellarType = inputStellarType


func generate():
	if self.stellarType == 'star':
		scale = Vector2(standartStarRadius, standartStarRadius)
		self_modulate = Color8(255, 249, 23)
		randomize()
		for i in range(round(rand_range(1, 5))):
			planet = StellarObject.instance()
			planet.init('solidPlanet')
			planet.generate()
			planets.append(planet)
		for i in range(round(rand_range(1, 5))):
			planet = StellarObject.instance()
			planet.init('gasPlanet')
			planet.generate()
			planets.append(planet)
		for planet in planets:
			if planet.stellarType == 'solidPlanet':
				currentOffset += rand_range(solidOffset - solidOffset * 0.25, solidOffset + solidOffset * 0.25)
				planet.position = Vector2(0, currentOffset)
				randomRadius = rand_range(standartSolidPlanetRadius - standartSolidPlanetRadius * 0.25, standartSolidPlanetRadius + standartSolidPlanetRadius * 0.25)
				planet.scale = Vector2(randomRadius, randomRadius)
				planet.self_modulate = Color(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1))
			if planet.stellarType == 'gasPlanet':
				currentOffset += rand_range(gasOffset - gasOffset * 0.25, gasOffset + gasOffset * 0.25)
				planet.position = Vector2(0, currentOffset)
				randomRadius = rand_range(standartGasPlanetRadius - standartGasPlanetRadius * 0.25, standartGasPlanetRadius + standartGasPlanetRadius * 0.25)
				planet.scale = Vector2(randomRadius, randomRadius)
				planet.self_modulate = Color(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1))
	
	if self.stellarType == 'solidPlanet':
		randomize()
		for i in range(round(rand_range(0, 3))):
			moon = StellarObject.instance()
			moon.init('moon')
			moons.append(moon)
		for moon in moons:
			currentOffset += rand_range(moonOffset - moonOffset * 0.25, moonOffset + moonOffset * 0.25)
			moon.position = Vector2(0, currentOffset)
			randomRadius = rand_range(standartSolidMoonRadius - standartSolidMoonRadius * 0.25, standartSolidMoonRadius + standartSolidMoonRadius * 0.25)
			moon.scale = Vector2(randomRadius, randomRadius)
			moon.self_modulate = Color(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1))
	
	if self.stellarType == 'gasPlanet':
		randomize()
		for i in range(round(rand_range(0, 10))):
			moon = StellarObject.instance()
			moon.init('moon')
			moons.append(moon)
		for moon in moons:
			currentOffset += rand_range(gasMoonOffset - gasMoonOffset * 0.25, gasMoonOffset + gasMoonOffset * 0.25)
			moon.position = Vector2(0, currentOffset)
			randomRadius = rand_range(standartGasMoonRadius - standartGasMoonRadius * 0.25, standartGasMoonRadius + standartGasMoonRadius * 0.25)
			moon.scale = Vector2(randomRadius, randomRadius)
			moon.self_modulate = Color(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1))


func draw():
	if self.stellarType == 'star':
		for planet in planets:
			add_child(planet)
			planet.draw()
	if (self.stellarType == 'solidPlanet') or (self.stellarType == 'gasPlanet'):
		for moon in moons:
			add_child(moon)


func destroy():
	if self.stellarType == 'star':
		for planet in planets:
			planet.destroy()
			queue_free()
	elif self.stellarType == 'moon':
		queue_free()
	else:
		for moon in moons:
			moon.destroy()
			queue_free()


func save():
	if (stellarType == 'gasPlanet') or (stellarType == 'solidPlanet'):
		for moon in moons:
			save_dict = inst2dict(moon)
			save_dict["MOON_POSITION_X"] = moon.position.x
			save_dict["MOON_POSITION_Y"] = moon.position.y
			save_dict["MOON_SCALE_X"] = moon.scale.x
			save_dict["MOON_SCALE_Y"] = moon.scale.y
			moon_save_list.append(save_dict)
	elif stellarType == 'star':
		for planet in planets:
			planet.save()
			save_dict = inst2dict(planet)
			save_dict["PLANET_POSITION_X"] = planet.position.x
			save_dict["PLANET_POSITION_Y"] = planet.position.y
			save_dict["PLANET_SCALE_X"] = planet.scale.x
			save_dict["PLANET_SCALE_Y"] = planet.scale.y
			planet_save_list.append(save_dict)


func load_game():
	if (stellarType == 'gasPlanet') or (stellarType == 'solidPlanet'):
		moons = []
		for moon in moon_save_list:
			var new_moon = dict2inst(moon)
			new_moon.position.x = float(moon["MOON_POSITION_X"])
			new_moon.position.y = float(moon["MOON_POSITION_Y"])
			new_moon.scale.x = float(moon["MOON_SCALE_X"])
			new_moon.scale.y = float(moon["MOON_SCALE_Y"])
			moons.append(new_moon)
	elif stellarType == 'star':
		planets = []
		for planet in planet_save_list:
			var new_planet = dict2inst(planet)
			new_planet.position.x = float(planet["PLANET_POSITION_X"])
			new_planet.position.y = float(planet["PLANET_POSITION_Y"])
			new_planet.scale.x = float(planet["PLANET_SCALE_X"])
			new_planet.scale.y = float(planet["PLANET_SCALE_Y"])
			new_planet.load_game()
			planets.append(new_planet)
