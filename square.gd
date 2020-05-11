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
var start_tick = 0
var start_pos = Vector2.ZERO

onready var explosion = $explosion

#func get_pos():
#	if direction.x > 0:
#		pos =  Vector2((position.x / 75)/ 2.0 - 3, y_pos)
#	else:
#		pos =  Vector2((12 + position.x / 75)/ 2.0 - 3, y_pos)
#	return pos


func _ready():
	print("from part")
	explosion.emitting = false
	var col = explosion.process_material.color_ramp.gradient.colors
	col.set(0, self.color)
#	var col_1 = col.duplicate()
#	col_1[0] = Color(self.color)
#	explosion.process_material.color_ramp.gradient.set_colors(col_1)
#	col[0] = Color(self.color)
#	explosion.emitting = true
#	print(self.color.to_html())
#	print(col[0].to_html())
#	for c in col:
#		print(c.to_html())

func get_pos_after_x_tick(x):
	return start_pos + Vector2(direction.x * (Time.tick - start_tick + x)*0.5, 0)

func get_pos():
	var pos = start_pos + Vector2(direction.x * (Time.tick - start_tick)*0.5, 0)
#	print(pos)
	update_pos_text(pos)
	return pos
	

func update_pos_text(pos):
	$label.text = str(pos)

func _draw():
	draw_rect(Rect2(-SIZE*0.5, SIZE), color, true)
