extends Camera2D
export(float) var camera_speed = 0
export(float) var zoom_divider = 0
var new_speed = Vector2(0, 0)
onready var CameraPositionLabel = get_node("UI/CameraPosition")
var showPlanetOrbits = false
var showMoonOrbits = false
var showNothing = false
signal planet
signal moon
signal nothing


func _ready():
	zoom.x = 5000
	zoom.y = 5000
	scale.x = 5000
	scale.y = 5000


func _process(delta):
	if (zoom.x > 25) and (showPlanetOrbits == false):
		showPlanetOrbits = true
		showMoonOrbits = false
		showNothing = false
		emit_signal('planet')
	if (zoom.x < 25) and (showMoonOrbits == false):
		showPlanetOrbits = false
		showMoonOrbits = true
		showNothing = false
		emit_signal('moon')
	if (zoom.x < 0.1) and (showNothing == false):
		showPlanetOrbits = false
		showMoonOrbits = false
		showNothing = true
		emit_signal("nothing")


func _physics_process(delta):
	# Position controls
	if Input.is_action_pressed('right'):
		new_speed.x += 1
	if Input.is_action_pressed('left'):
		new_speed.x -= 1
	if Input.is_action_pressed('down'):
		new_speed.y += 1
	if Input.is_action_pressed('up'):
		new_speed.y -= 1
	new_speed = new_speed.normalized() * zoom * camera_speed * delta
	position += new_speed
	new_speed = Vector2(0, 0)


func _input(event):
	# Zoom controls
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				zoom.x -= zoom.x / zoom_divider
				zoom.y -= zoom.y / zoom_divider
				scale.x -= scale.x / zoom_divider
				scale.y -= scale.y / zoom_divider
				if zoom.x < 0.01:
					zoom.x = 0.01
					zoom.y = 0.01
					scale.x = 0.01
					scale.y = 0.01
			if event.button_index == BUTTON_WHEEL_DOWN:
				zoom.x += zoom.x / zoom_divider
				zoom.y += zoom.y / zoom_divider
				scale.x += scale.x / zoom_divider
				scale.y += scale.y / zoom_divider
				if zoom.x > 5000:
					zoom.x = 5000
					zoom.y = 5000
					scale.x = 5000
					scale.y = 5000


func _on_SystemGenerator_repass():
	showPlanetOrbits = false
	showMoonOrbits = false
	showNothing = false
