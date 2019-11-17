tool
extends Node2D

const SIZE = Vector2(-150, -150)

export var color = Color(1,1,1)
export var active = true

var pos = Vector2(0,0) setget ,get_pos

var direction:Vector2

func get_pos():
	pass

func _ready():
	Time.connect("tick", self, "update_pos_text")
	update_pos_text()
	
func update_pos_text(tick=0):
	$label.text = "%0.1f, %0.1f" % [pos.x, pos.y]

func _draw():
	draw_rect(Rect2(-SIZE*0.5, SIZE), color, true)
