extends Node2D

var SQUARE_TSCN = preload("res://square.tscn")

export var queue_color:PoolColorArray = [Color("FF0000"), Color("00FF00"), Color("0000ff")] setget set_queue_color
export var tick_color:PoolIntArray = [10, 10, 10]
export var next_bullet = 0
export var MESH_SIZE = 7
export var SEGMENT_SIZE = 150
export var default_speed = 3.33

var LAST_TICK = 0

var COMPLETED = "completed"
var emit_poligon






# Called when the node enters the scene tree for the first time.
func _ready():

	Time.connect("tick", self, "on_tick")
	emit_poligon = $emit_polygon
	pass

func on_tick(tick):
	if tick - LAST_TICK == tick_color[next_bullet]:
		start_next_bullet()
		next_bullet = next_bullet + 1 if next_bullet < tick_color.size() - 1 else 0
		LAST_TICK = tick
		



func set_queue_color(color_arr:PoolColorArray):
	queue_color = color_arr





func start_next_bullet(speed = default_speed):
	var a:Node2D = SQUARE_TSCN.instance()
	self.add_child(a)
	if queue_color:
		a.color = queue_color[next_bullet]
	var tween_speed = (MESH_SIZE + 4) / speed
	if position.x > 0:
		emit_color_bulet(speed, a.color)
		a.position.x += SEGMENT_SIZE * 0.5 + SEGMENT_SIZE * 3
		yield(tw.ip(a, "position:x", a.position.x, a.position.x - (MESH_SIZE + 4) * SEGMENT_SIZE, tween_speed),
			"tween_completed")
	elif position.x < 0:
		emit_color_bulet(speed, a.color)
		a.position.x -= SEGMENT_SIZE * 0.5 + SEGMENT_SIZE * 3
		yield(tw.ip(a, "position:x", a.position.x, a.position.x + (MESH_SIZE + 4) * SEGMENT_SIZE, tween_speed),
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
	












