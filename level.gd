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
		var bmb = ((tick)%28)*0.5-7
		if bmb == 14:
			$bullet.rect_position.x = -150*DT*(bmb-1)*4
		print("%s, %s"%[tick*0.5, bmb])
		grandma.get_node("back/text").text = str(bmb+4)
		$bullet/text.text = str(bmb+4)
		tw.ip($bullet, "rect_position:x", 150*DT*(bmb-1)*4, 150*DT*bmb*4, DT*2)
		
		if is_need_to_jump:
			is_need_to_jump = false
			grandma.jump()
	if DEBUG:
		print("time:%.2f > TICK[%003d]" % [time, tick])

#func _ready():
#	while true:
#		$bullet.rect_position.x = -825
#		for i in 22:
#			$bullet/text.text = str((i*0.5)-2)
#			yield(tw.ip($bullet, "rect_position:x", $bullet.rect_position.x, $bullet.rect_position.x + 75, DT*2), "tween_completed")

func _draw():
	draw_line(Vector2(0, 120), Vector2(0, -1800), Color("80ffffff"), 1, true)
	for k in 1920/75:
		for i in 1080/150:
			for j in 2:
				var x = 75+i*75
				x *= 1 if j else -1
				draw_line(Vector2(x,120), Vector2(x, -1800), Color("30ffffff") if i % 2 else Color("90ffffff"), (1 if i % 2 else 3), true)
		var y = -75*k
		draw_line(Vector2(-620,y), Vector2(620, y), Color("30ffffff") if k % 2 else Color("90ffffff"), (1 if k % 2 else 3), true)
