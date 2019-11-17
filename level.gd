extends Node2D

onready var grandma = $grandma
onready var field = $field

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
#	if !tick % 14:
#		print(get_active_squares(), "\n\n\n")
	
	var player_pos = grandma.get_player_position()
	if !is_need_to_jump and !grandma._pushing and !grandma.jumping:
		var _want_push
		var to_many_to_push = false
		for square in get_active_squares():
			var s_pos = square.get_pos()
			if abs(s_pos.y - player_pos.y) > 0.01:
				 continue
			if abs(s_pos.x - player_pos.x) < 0.5:
				if _want_push:
					to_many_to_push = true
					break
				_want_push = square
		if _want_push && !to_many_to_push:
			_want_push.color = Color()
			print(_want_push.get_pos())
			if _want_push.get_pos().x - player_pos.x > 0:
				grandma.push(-1)
			else:
				grandma.push(1)
				
		
	if !tick % 14:
		print(get_active_squares(), "\n\n\n")
	if is_need_to_jump:
		is_need_to_jump = false
		grandma.jump()
		
		push_block()
		#grandma.jump_and_slide(GrandMa.RIGHT)

func push_block():
	walk_around_spawners()

func walk_around_spawners():
	var active = get_active_squares()
	for sq in active:
		var baba = grandma.get_player_position()
		var block = sq.get_pos()
		if int(baba.x) == int(block.x):
			yield(prepare_jump(sq), "completed")
#		sq.position.y == grandma.position - 150:
			print("Touch")
			field.push(sq)

func prepare_jump(sq):
	var bab = grandma.position.x
	var bl = sq.position.x + sq.get_parent().position.x
	var s = abs(bab - bl)
	var t = s / sq.speed.x
	tw.ip(grandma, "scale", Vector2(1,1), Vector2(0.1, 0.1), t/2)
	yield(Time.wait(t/2),"completed")
	tw.ip(grandma, "scale", Vector2(0.1,0.1), Vector2(1, 1), t/2)
	yield(Time.wait(t/2),"completed")
	
	

func get_active_squares():
	var arr = get_tree().get_nodes_in_group("square")
	return arr




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
