extends Control

var png_path = "res://jumpers/%s.png"
var a = 0.3
onready var png = $field/png
onready var jumper = $field/png/jumper
var table = []
var pic_size = Vector2(7,7)
onready var save = $save
var size_block= 150

var image

signal win
signal success
signal on_place



onready var btn = $Button

func _ready():
	prepare_png()
	create_table()
#	btn.connect("pressed", self, "exper")
	print(table)

func exper():
	pass

func prepare_png():
	get_picture()
	png.modulate.a = a

func get_picture():
	randomize()
	var nb = randi() % 2
	var img_path = png_path % nb
	var img  = load(img_path)
	png.texture = img
	print("COLOR")
	image = png.texture.get_data()
	image.lock()
	var col = image.get_pixel(1, 1)
	print(col)
	var col_str = col.to_html(false)
	print(col_str)


func create_table():
	var plug = -1
	var i = int(0)
	while i < pic_size.y:
		var j = int(0)
		var raw = []
		while j < pic_size.x:
			raw.append(plug)
			j += 1
		table.append(raw)
		i += 1

func push(obj):
	var speed = obj.speed.y
#	save.add_child(new_node)
	var dic = block_is_good(obj)
	if dic  == TYPE_DICTIONARY:
		run_block(obj, dic)
		return true
	else:
		return false
		

func block_is_good(obj):
	var tmp_obj_pos_x = obj.position.x + 1080/2
#	var column = obj.position.x / size_block
	var column = tmp_obj_pos_x / size_block 
	var cell = check_table(column)
	if cell != Vector2(-1, -1):
		return(__is_color_same(cell, obj))
	return false
	
func is_full_jumper(table):
	var i = int(0)
	while i < table.y.size():
		var j = int(0)
		while j < table.x.size():
			if table[i][j] < 0:
				return false
			j += 1
		i += 1
	emit_signal("win")
	return true
	
func check_table(column):
	var i = int(0)
	var count = int(0)
	while i < pic_size.y:
		if table[column][i] == -1:
			return Vector2(column, i)
		i += 1
	return Vector2(-1,-1)
	

func __is_color_same(cell, obj):
	var dic = {
		"bool" : null, 
		"cell": 
		{"x": null,
		"y": null
		}
		}
	var _color_original = image.get_pixel(cell.x, cell.y).to_html()
	var _color_from_obj = obj.color.to_html()
	if _color_from_obj == _color_original:
		table[cell.x][cell.y] = Color(_color_from_obj)
		dic["bool"] = true
		dic["cell"]["x"] = cell.x
		dic["cell"]["y"] = cell.y
	else:
		dic["bool"] = false
	return dic

func run_block(obj, dic):
	var s = get_distance(obj, dic)
	
	pass

func get_distance(obj, dic):
	yield(Time.defer(), "completed")
	var start_pos = obj.position
	var end_pos = Vector2(start_pos.x, -1 * dic["cell"]["y"]*150 + 120)
	var s = start_pos.y - end_pos.y
	var t = s / obj.speed.y
#	yield(tw.ip(new_node, "rect_position:y", start_pos.y, end_pos.y, t), "tween_completed")
	yield(tw.ip(obj, "position:y", start_pos.y, end_pos.y, t), "tween_completed")
	emit_signal("on_place")
