extends Node2D

const MOVE_LEFT = -1
const MOVE_NONE = 0
const MOVE_RIGHT = 1

export var texture = Color("4a57c3") setget set_texture
onready var obj = $back
onready var sprite = $sprite

func _ready():
	pass
	#while is_inside_tree():
	#	yield(anim_jump(), "completed")
	#	yield(Time.wait(1), "completed")

func set_texture(value):
	texture = value
	check()

func check():
	pass

var is_busy = false

func _process(delta):
	pass

func _jump(time, prepare = true):
	if !is_busy:
		is_busy = true
#		sprite.play("jump")
		yield(tw.ip(obj, "rect_position:y", obj.rect_position.y, obj.rect_position.y - 150, time), "tween_completed")
		yield(tw.ip(obj, "rect_position:y", obj.rect_position.y, obj.rect_position.y + 150, time), "tween_completed")
		is_busy = false
		
var jumping = false
func jump(t):
	if jumping:
		yield(Time.defer(), "completed")
		return
	jumping = true
	pause_on_jump()
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
	
func pause_on_jump():
	yield(Time, "tick")
	yield(Time, "tick")
	get_tree().paused = true
	yield(Time.wait(1), "completed")
	get_tree().paused = false