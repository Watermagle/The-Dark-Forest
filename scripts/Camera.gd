extends Camera2D
export(float) var camera_speed = 0
export(float) var zoom_divider = 0
var new_speed = Vector2(0, 0)


func _physics_process(delta):
	# Position controls
	if Input.is_action_pressed('ui_right'):
		new_speed.x += 1
	if Input.is_action_pressed('ui_left'):
		new_speed.x -= 1
	if Input.is_action_pressed('ui_down'):
		new_speed.y += 1
	if Input.is_action_pressed('ui_up'):
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
			if event.button_index == BUTTON_WHEEL_DOWN:
				zoom.x += zoom.x / zoom_divider
				zoom.y += zoom.y / zoom_divider
				scale.x += scale.x / zoom_divider
				scale.y += scale.y / zoom_divider
