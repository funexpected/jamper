extends Node2D

var SQUARE_TSCN = preload("res://square.tscn")

export var queue_color:PoolColorArray setget set_queue_color
export var MESH_SIZE = 7
export var SEGMENT_SIZE = 150
export var bps = 1


var COMPLETED = "completed"

signal spawn_tick


var queue = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


var time = 0
func _process(delta):
	time += delta
	if time >= bps:
		time = 0
		start_next_bullet(3.2)


func set_queue_color(color_arr:PoolColorArray):
	queue_color = color_arr





func start_next_bullet(speed:float):
	var a:Node2D = SQUARE_TSCN.instance()
	self.add_child(a)
	if queue_color:
		a.color = queue_color[queue]
		queue = queue + 1 if queue < queue_color.size() - 1 else 0
	
	var tween_speed = (MESH_SIZE + 1) / speed
	
	if position.x > 0:
		a.position.x += SEGMENT_SIZE * 0.5 
		yield(tw.ip(a, "position:x", a.position.x, a.position.x - (MESH_SIZE + 1) * SEGMENT_SIZE, tween_speed),
			"tween_completed")
		a.queue_free()
	elif position.x < 0:
		a.position.x -= SEGMENT_SIZE * 0.5
		yield(tw.ip(a, "position:x", a.position.x, a.position.x + (MESH_SIZE + 1) * SEGMENT_SIZE, tween_speed),
			"tween_completed")
		a.queue_free()








