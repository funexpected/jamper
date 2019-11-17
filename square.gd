tool
extends Node2D

const SIZE = Vector2(-150, -150)

export var color = Color(1,1,1)

export var active = true

export var speed = Vector2(450, 450)

var pos = Vector2(0,0) setget ,get_pos

var tween

var direction:Vector2
var y_pos


func get_pos():
	if direction.x > 0:
		pos =  Vector2((position.x / 75)/ 2.0 - 3, y_pos)
	else:
		pos =  Vector2((12 + position.x / 75)/ 2.0 - 3, y_pos)
	return pos

func update_pos_text():
	$label.text = "%0.1f, %0.1f" % [get_pos().x, get_pos().y]

func _draw():
	draw_rect(Rect2(-SIZE*0.5, SIZE), color, true)
