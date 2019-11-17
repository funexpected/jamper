extends Node2D

onready var grandma = $grandma

var is_need_to_jump = false
const DEBUG = false
const GRID = true
const CELL = Vector2(150, 150)

func _input(e):
	if e is InputEventScreenTouch:
		if e.pressed:
			is_need_to_jump = true
			
func _ready():
	Time.connect("tick", self, "on_tick")
			
			
func on_tick(tick):
	#if (tick%14 == 1):
	#	$spawner0.start_next_bullet(1/Time.TICK/2)
	
	if is_need_to_jump:
		is_need_to_jump = false
		grandma.jump(Time.TICK*4)
		
func get_active_squares():
	pass


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
