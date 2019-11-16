extends Node2D

export var texture = Color("4a57c3") setget set_texture

func set_texture(value):
	texture = value
	check()

func check():
	pass

var is_busy = false

onready var obj = $back
onready var sprite = $sprite
func jump(time, prepare = true):
	if !is_busy:
		is_busy = true
#		sprite.play("jump")
		yield(tw.ip(obj, "rect_position:y", obj.rect_position.y, obj.rect_position.y - 150, time), "tween_completed")
		yield(tw.ip(obj, "rect_position:y", obj.rect_position.y, obj.rect_position.y + 150, time), "tween_completed")
		is_busy = false