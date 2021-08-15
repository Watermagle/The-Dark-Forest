extends Node2D
var center
var radius
var color
var width


func init(center, radius, color, width):
	self.center = center
	self.radius = radius
	self.color = color
	self.width = width


func orbitUpdate():
	update()


func _draw():
	draw_arc(self.center, self.radius, 0, 6.28, 512, self.color, self.width)
