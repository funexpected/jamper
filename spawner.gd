extends Node2D

var SQUARE_TSCN = preload("res://square.tscn")

export var queue_color:PoolColorArray = PoolColorArray() setget set_queue_color
export var tick_color:PoolIntArray = PoolIntArray()
export var next_bullet = 0
export var MESH_SIZE = 7
export var SEGMENT_SIZE = 150
export var default_speed = 3

export var tick_offset = 0

var COMPLETED = "completed"
var emit_poligon






# Called when the node enters the scene tree for the first time.
func _ready():

	Time.connect("tick", self, "on_tick")
	emit_poligon = $emit_polygon
	pass

func on_tick(tick):
	if !queue_color.size():
		return
	if tick - tick_offset == tick_color[next_bullet]:
		start_next_bullet()
		next_bullet = next_bullet + 1 if next_bullet < tick_color.size() - 1 else 0
		tick_offset = tick
		



func set_queue_color(color_arr:PoolColorArray):
	queue_color = color_arr





func start_next_bullet(speed = default_speed):
	var a:Node2D = SQUARE_TSCN.instance()
	self.add_child(a)
	if queue_color:
		a.color = queue_color[next_bullet]
	var tween_speed = (MESH_SIZE + 5) / speed
	if position.x > 0:
		emit_color_bulet(speed, a.color)
		a.position.x += SEGMENT_SIZE * 0.5 + SEGMENT_SIZE * 3
		yield(tw.ip(a, "position:x", a.position.x, a.position.x - (MESH_SIZE + 5) * SEGMENT_SIZE, tween_speed),
			"tween_completed")
	elif position.x < 0:
		emit_color_bulet(speed, a.color)
		a.position.x -= SEGMENT_SIZE * 0.5 + SEGMENT_SIZE * 3
		yield(tw.ip(a, "position:x", a.position.x, a.position.x + (MESH_SIZE + 5) * SEGMENT_SIZE, tween_speed),
			"tween_completed")
	a.queue_free()


func emit_color_bulet(speed, color):
	emit_poligon.color = color
	emit_poligon.color.a = 0.3
	yield(Time.wait(0.7 / speed), COMPLETED)
	emit_poligon.color.a = 0
	yield(Time.wait(0.5 / speed), COMPLETED)
	emit_poligon.color.a = 0.6
	yield(Time.wait(0.7 / speed), COMPLETED)
	emit_poligon.color = ("00000000")
	












