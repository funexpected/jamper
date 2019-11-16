extends Node2D

onready var grandma = $grandma

var is_need_to_jump = false
const DEBUG = false
const CELL = Vector2(150, 150)

func _input(e):
	if e is InputEventScreenTouch:
		if e.pressed:
			is_need_to_jump = true

const DT = 1/6.0 # Delta tick
var time = 0.0
var tick = 0

func _process(delta):
	time += delta
	if tick*DT < time: # need to update
		tick += 1
		if tick % 2 == 0:
			print(tick/2)
#		print(is_need_to_jump)
		if is_need_to_jump:
			is_need_to_jump = false
			grandma.jump()
	if DEBUG:
		print("time:%.2f > TICK[%003d]" % [time, tick])

func _ready():
	while true:
		yield(tw.ip($bullet, "rect_position:x", -690, 690, 0.3*9), "tween_completed")

func _draw():
	draw_line(Vector2(0, 0), Vector2(0, -1920), Color("80ffffff"), 1, true)
	for k in 1920/75:
		for i in 1080/150:
			for j in 2:
				var x = 75+i*75
				x *= 1 if j else -1
				draw_line(Vector2(x,0), Vector2(x, -1920), Color("30ffffff") if i % 2 else Color("90ffffff"), (1 if i % 2 else 3), true)
		var y = -120 -75*k
		draw_line(Vector2(-620,y), Vector2(620, y), Color("30ffffff") if k % 2 else Color("90ffffff"), (1 if k % 2 else 3), true)# if i % 2 else Color("ffffff"), (1 if i % 2 else 3), true)
