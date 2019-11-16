extends Node2D

var SQUARE_TSCN = preload("res://square.tscn")

export var queue_color:PoolColorArray setget set_queue_color

var COMPLETED = "completed"

signal spawn_tick

var queue = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


var time = 0

func _process(delta):
	time += delta
	if (time >= 1):
		time = 0
		start_next_bullet(1)
	del_exit_bullets()



func set_queue_color(color_arr:PoolColorArray):
	queue_color = color_arr





func start_next_bullet(speed:float):
	var a:Node2D = SQUARE_TSCN.instance()
	self.add_child(a)
	if queue_color:
		a.color = queue_color[queue]
		queue = queue + 1 if queue < queue_color.size() - 1 else 0
	if position.x >= 1080:
		a.position.x += 150
		tw.ip(a, "position:x", a.position.x, -(1080 + 151), speed)
	elif position.x <= 0:
		a.position.x -= 150
		tw.ip(a, "position:x", a.position.x, 1080 + 151, speed)




func del_exit_bullets():
	var bullets = get_children()
	for i in bullets:
		if i.position.x >= 1080 + 151 || i.position.x <= -(1080 + 151):
			i.queue_free()





