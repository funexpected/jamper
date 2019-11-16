extends Node2D

onready var grandma = $grandma

var is_need_to_jump = false
const DEBUG = false
const GRID = false
const CELL = Vector2(150, 150)

func _input(e):
	if e is InputEventScreenTouch:
		if e.pressed:
			is_need_to_jump = true

const DT = 1/6.0 # Delta tick  !!! set 1.0 to slow test !!!
var time = 0.0
var tick = 0

var tmp = 0
func _process(delta):
	time += delta
	if tick*DT < time: # new tick! u can update something
		tick += 1
		if (tick%14 == 1):
			$spawner0.start_next_bullet(1/DT/2)
			tmp = tick
		var bullet_pos_tick = (tick-tmp)*0.5 - 4
		grandma.get_node("back/text").text = str(bullet_pos_tick)
		if bullet_pos_tick < -1.0-1.0:
			grandma.get_node("back").color = Color("4a57c3")
		elif bullet_pos_tick < -0.5-1.0:
			grandma.get_node("back").color = Color("1dd091")
		elif bullet_pos_tick < 2.0-1.0:
			grandma.get_node("back").color = Color("b323bb")
		else:
			grandma.get_node("back").color = Color("4a57c3")
		print(tick*0.5)
		if is_need_to_jump:
			is_need_to_jump = false
			grandma.jump(DT*2)
	if DEBUG:
		print("time:%.2f > TICK[%003d]" % [time, tick])

func _draw():
	if GRID:
		draw_line(Vector2(0, 120), Vector2(0, -1800), Color("80ffffff"), 1, true)
		for k in 1920/75:
			for i in 1080/150:
				for j in 2:
					var x = 75+i*75
					x *= 1 if j else -1
					draw_line(Vector2(x,120), Vector2(x, -1800), Color("30ffffff") if i % 2 else Color("90ffffff"), (1 if i % 2 else 3), true)
			var y = -75*k
			draw_line(Vector2(-620,y), Vector2(620, y), Color("30ffffff") if k % 2 else Color("90ffffff"), (1 if k % 2 else 3), true)
