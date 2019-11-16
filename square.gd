tool
extends Node2D

const SIZE = Vector2(-150, -150)

export var color = Color(1,1,1)

func _ready():
	pass # Replace with function body.

func _draw():
	draw_rect(Rect2(-SIZE*0.5, SIZE), color, true)
