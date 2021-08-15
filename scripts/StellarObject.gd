extends MeshInstance2D
var StellarObject = load('res://scenes/StellarObject.tscn')
var Orbit = load('res://scenes/Orbit.tscn')
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
var standartStarRadius = 500
var currentOffset = 0
var randomRadius
var moon_save_list = []
var planet_save_list = []
var save_dict = {}
var moons_save = []
var planets_save = []
var solidPlanetCount
var stellarName = '0'
var planetOrbits = []
var moonOrbits = []
var orbit
var showPlanetOrbits = false
var showMoonOrbits = false
var planetMarker
var planetMarkers = []


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
			planet.stellarName = stellarName + '-' + str(i)
			planet.generate()
			planets.append(planet)
			solidPlanetCount = i
		for i in range(round(rand_range(1, 5))):
			planet = StellarObject.instance()
			planet.init('gasPlanet')
			planet.stellarName = stellarName + '-' + str(solidPlanetCount + i)
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
		for i in range(round(rand_range(1, 3))):
			moon = StellarObject.instance()
			moon.init('moon')
			moon.stellarName = self.stellarName + '-' + str(i)
			moons.append(moon)
		for moon in moons:
			currentOffset += rand_range(moonOffset - moonOffset * 0.25, moonOffset + moonOffset * 2)
			moon.position = Vector2(0, currentOffset)
			randomRadius = rand_range(standartSolidMoonRadius - standartSolidMoonRadius * 0.25, standartSolidMoonRadius + standartSolidMoonRadius * 0.25)
			moon.scale = Vector2(randomRadius, randomRadius)
			moon.self_modulate = Color(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1))
	
	if self.stellarType == 'gasPlanet':
		randomize()
		for i in range(round(rand_range(1, 10))):
			moon = StellarObject.instance()
			moon.init('moon')
			moon.stellarName = stellarName + '-' + str(i)
			moons.append(moon)
		for moon in moons:
			currentOffset += rand_range(gasMoonOffset - gasMoonOffset * 0.25, gasMoonOffset + gasMoonOffset * 2)
			moon.position = Vector2(0, currentOffset)
			randomRadius = rand_range(standartGasMoonRadius - standartGasMoonRadius * 0.25, standartGasMoonRadius + standartGasMoonRadius * 0.25)
			moon.scale = Vector2(randomRadius, randomRadius)
			moon.self_modulate = Color(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1))


func generateOrbits():
	if self.stellarType == 'star':
		planetOrbits = []
		planetMarkers = []
		for planet in planets:
			orbit = Orbit.instance()
			orbit.init(Vector2(0, 0), planet.position.y, Color(1, 1, 1), 1.0)
			planetOrbits.append(orbit)
			
			planetMarker = Orbit.instance()
			if planet.stellarType == 'solidPlanet':
				planetMarker.init(planet.position, 5, Color(1, 1, 1), 1.1)
			elif planet.stellarType == 'gasPlanet':
				planetMarker.init(planet.position, 50, Color(1, 1, 1), 10.0)
			planetMarkers.append(planetMarker)
	if (self.stellarType == 'solidPlanet') or (self.stellarType == 'gasPlanet'):
		moonOrbits = []
		planetMarkers = []
		for moon in moons:
			orbit = Orbit.instance()
			orbit.init(Vector2(0, 0), moon.position.y, Color(1, 1, 1), 1.0)
			moonOrbits.append(orbit)
			
			planetMarker = Orbit.instance()
			if self.stellarType == 'solidPlanet':
				planetMarker.init(moon.position, 10, Color(1, 1, 1), 2.0)
			elif self.stellarType == 'gasPlanet':
				planetMarker.init(moon.position, 2, Color(1, 1, 1), 1.0)
			planetMarkers.append(planetMarker)


func draw():
	if self.stellarType == 'star':
		for planet in planets:
			add_child(planet)
			planet.draw()
	if (self.stellarType == 'solidPlanet') or (self.stellarType == 'gasPlanet'):
		for moon in moons:
			add_child(moon)
	generateOrbits()
	drawOrbits()


func drawOrbits():
	if (self.stellarType == 'star'):
		if showPlanetOrbits == true:
			for orbit in planetOrbits:
				add_child(orbit)
				orbit.orbitUpdate()
			for planetMarker in planetMarkers:
				add_child(planetMarker)
				planetMarker.orbitUpdate()
			for planet in planets:
				for orbit in planet.moonOrbits:
					orbit.queue_free()
				for planetMarker in planet.planetMarkers:
					planetMarker.queue_free()
				planet.generateOrbits()
		elif showMoonOrbits == true:
			for orbit in planetOrbits:
				orbit.queue_free()
			for planetMarker in planetMarkers:
				planetMarker.queue_free()
			generateOrbits()
			for planet in planets:
				for orbit in planet.moonOrbits:
					planet.add_child(orbit)
					orbit.orbitUpdate()
				for planetMarker in planet.planetMarkers:
					planet.add_child(planetMarker)
					planetMarker.orbitUpdate()
		else:
			for orbit in planetOrbits:
				orbit.queue_free()
			for planetMarker in planetMarkers:
				planetMarker.queue_free()
			generateOrbits()
			for planet in planets:
				for orbit in planet.moonOrbits:
					orbit.queue_free()
				for planetMarker in planet.planetMarkers:
					planetMarker.queue_free()
				planet.generateOrbits()


func passPlanet():
	showPlanetOrbits = true
	showMoonOrbits = false
	drawOrbits()


func passMoon():
	showPlanetOrbits = false
	showMoonOrbits = true
	drawOrbits()


func passNothing():
	showPlanetOrbits = false
	showMoonOrbits = false
	drawOrbits()


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
	save_dict['position_x'] = position.x
	save_dict['position_y'] = position.y
	save_dict['scale_x'] = scale.x
	save_dict['scale_y'] = scale.y
	save_dict['self_modulate_r'] = self_modulate.r8
	save_dict['self_modulate_g'] = self_modulate.g8
	save_dict['self_modulate_b'] = self_modulate.b8
	save_dict['stellarType'] = stellarType
	save_dict['stellarName'] = stellarName
	if (stellarType == 'solidPlanet') or (stellarType == 'gasPlanet'):
		moons_save = []
		for moon in moons:
			moon.save()
			moons_save.append(moon.save_dict)
		save_dict['moons'] = moons_save
	if stellarType == 'star':
		planets_save = []
		for planet in planets:
			planet.save()
			planets_save.append(planet.save_dict)
		save_dict['planets'] = planets_save


func load_game(save_dict):
	stellarType = save_dict['stellarType']
	position.x = save_dict['position_x']
	position.y = save_dict['position_y']
	scale.x = save_dict['scale_x']
	scale.y = save_dict['scale_y']
	self_modulate.r8 = save_dict['self_modulate_r']
	self_modulate.g8 = save_dict['self_modulate_g']
	self_modulate.b8 = save_dict['self_modulate_b']
	stellarName = save_dict['stellarName']
	if (stellarType == 'solidPlanet') or (stellarType == 'gasPlanet'):
		moons_save = save_dict['moons']
		moons = []
		for moon_save in moons_save:
			moon = StellarObject.instance()
			moon.load_game(moon_save)
			moons.append(moon)
	if stellarType == 'star':
		planets_save = save_dict['planets']
		planets = []
		for planet_save in planets_save:
			planet = StellarObject.instance()
			planet.load_game(planet_save)
			planets.append(planet)
	drawOrbits()
