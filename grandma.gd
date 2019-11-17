extends Node2D
class_name GrandMa

const LEFT = -1
const NONE = 0
const RIGHT = 1

export var texture = Color("4a57c3") setget set_texture
onready var obj = $back
onready var sprite = $sprite

var moving = NONE

func _ready():
	pass
	#while is_inside_tree():
	#	yield(anim_jump(), "completed")
	#	yield(Time.wait(1), "completed")


func set_texture(value):
	texture = value
	check()

func get_player_position():
	return Vector2(position.x / 150.0, position.y / 150.0)

func check():
	pass

var is_busy = false

func _process(delta):
	if moving:
		position += Vector2(moving, 0) * delta * 75 / Time.TICK

func _jump(time, prepare = true):
	if !is_busy:
		is_busy = true
#		sprite.play("jump")
		yield(tw.ip(obj, "rect_position:y", obj.rect_position.y, obj.rect_position.y - 150, time), "tween_completed")
		yield(tw.ip(obj, "rect_position:y", obj.rect_position.y, obj.rect_position.y + 150, time), "tween_completed")
		is_busy = false
		
var jumping = false
func jump():
	if jumping:
		yield(Time.defer(), "completed")
		return
	jumping = true
	var t = Time.TICK * 4
	#pause_in(2)
	yield(tw\
		.ip(sprite, "scale", Vector2(1,1), Vector2(1.1, 0.9), t*0.1)\
		.ip(sprite, "scale", Vector2(1.1, 0.9), Vector2(0.8, 1.2), t*0.1, tw.SINE, tw.INOUT, t*0.1)\
		.ip(sprite, "scale", Vector2(0.9, 1.1), Vector2(1, 1), t*0.1, tw.SINE, tw.INOUT, t*0.2)\
		.ip(sprite, "scale", Vector2(1,1), Vector2(1.1, 0.9), t*0.1, tw.SINE, tw.INOUT, t*0.3)\
		.ip(sprite, "scale", Vector2(1.1, 0.9), Vector2(0.9, 1.1), t*0.1, tw.SINE, tw.INOUT, t*0.5)\
		.ip(sprite, "scale", Vector2(0.9, 1.1), Vector2(1.1, 0.9), t*0.1, tw.SINE, tw.INOUT, t*0.7)\
		.ip(sprite, "scale", Vector2(1.1, 0.9), Vector2(1,1), t*0.1, tw.SINE, tw.INOUT, t*0.9)\
		.ip(sprite, "position:y", sprite.position.y, sprite.position.y - 150, t*0.3, tw.CUBIC, tw.OUT, t*0.2)\
		.ip(sprite, "position:y", sprite.position.y - 150, sprite.position.y, t*0.3, tw.CUBIC, tw.IN, t*0.5),
	"completed")
	jumping = false


var _pushing = false
var _dir
func push(dir):
	if _pushing:
		return
	_dir = dir
	_pushing = true
	var t = Time.TICK
#	yield(tw\
	if true:
		tw.ip(sprite, "scale", Vector2(1,1), Vector2(0.9, 1.1), t*0.3)
		tw.ip(sprite, "scale", sprite.scale, Vector2(1, 1), t*0.5, tw.SINE, tw.INOUT, t*0.3)
		yield(tw.ip(sprite, "position:x", sprite.position.x, sprite.position.x + 150 * dir, t*0.3, tw.CUBIC, tw.OUT, t*0.2),
	"completed")
	self.position.x += 150 * dir
	print (position.x)
	sprite.position.x = 0
	if position.x > 740:
		self.position.x = -450
		yield(Time.wait(0.2), "completed")
	_pushing = false
	

func push_and_drop(dir):
	jumping = true
	var t = Time.TICK * 2
	if (t > 0):
		yield(tw\
		.ip(sprite, "scale", Vector2(1,1), Vector2(0.9, 1.1), t*0.3)\
		.ip(sprite, "scale", sprite.scale, Vector2(1, 1), t*0.5, tw.SINE, tw.INOUT, t*0.3)\
		.ip(sprite, "position:x", sprite.position.x, sprite.position.x + 150 * dir, t*0.3, tw.CUBIC, tw.OUT, t*0.2),
	"completed")
	jumping = false
	pass


func jump_and_slide(dir):
	if jumping:
		yield(Time.defer(), "completed")
		return
	jumping = true
	var t = Time.TICK * 4
	yield(tw\
		.ip(sprite, "scale", Vector2(1,1), Vector2(1.1, 0.9), t*0.1)\
		.ip(sprite, "scale", Vector2(1.1, 0.9), Vector2(0.8, 1.2), t*0.1, tw.SINE, tw.INOUT, t*0.1)\
		.ip(sprite, "scale", Vector2(0.9, 1.1), Vector2(1, 1), t*0.1, tw.SINE, tw.INOUT, t*0.2)\
		.ip(sprite, "position:y", sprite.position.y, sprite.position.y - 150, t*0.3, tw.CUBIC, tw.OUT, t*0.2),
	"completed")
	jumping = false
	moving = dir

	
func pause_in(ticks):
	for i in range(ticks):
		yield(Time, "tick")
	get_tree().paused = true
	yield(Time.wait(1), "completed")
	get_tree().paused = false
