extends Control

var png_path = "res://jumpers/%s.png"
var a = 0.3
onready var png = $field/png
var table = []
var pic_size = Vector2(7,7)
onready var save = $save
var size_block= 150

var image
var image_table

signal win
signal success
signal on_place

func _ready():
	prepare_png()
	create_table()
	
	print(table)

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
#	print(image)
#	print(image.get_height())
#	image.set_pixel(150, 150, Color(1, 0, 0, 1)) # Works
	
	var col = image.get_pixel(1, 1)
	var col_str = col.to_html(false)
	print(col_str)
	create_image_table(Vector2(image.get_height(), image.get_width()))
	
	

#	var im = Image.new()
#
#	var tex = im.load(img_path).get_data()
#	print(tex)
#	var tex2 = im.create_from_data(7,7,false,Image.FORMAT_RGBA8, tex)
#	print(tex2)
##	im.create(300, 300, false, Image.FORMAT_RGBA8)
#	im.lock()
##	im.set_pixel(150, 150, Color(1, 0, 0, 1)) # Works
##	im.unlock()
##	img.set_pixel(x, y, color) # Does not have an effect
#	print(im.get_pixel(1, 1))

func create_image_table(size_tab):
	image_table = Image.new()
	image_table.create(size_tab.x, size_tab.y, false,  Image.FORMAT_RGBA8)
	image_table.lock()
	print("EMPTY")
	print(image_table.get_pixel(1, 1))

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
	
	var new_node = ColorRect.new()
	new_node.rect_size = Vector2(150,150)
	new_node.rect_position = obj.position
	new_node.color = obj.color
	var speed = obj.speed.y
	save.add_child(new_node)
	var dic = block_is_good(obj)
	if dic  == TYPE_DICTIONARY:
		run_block(obj, dic, new_node)
		return true
	else:
		return false
		

func block_is_good(obj):
	var column = obj.position.x / size_block
	var cell = check_table(column)
	var cell_image = check_image_table(column)
	print("TWO_TABLES")
	if (cell == cell_image):
		print("true")
	else: 
		print("false")
	if cell != Vector2(-1, -1):
		return(__is_color_same(cell, obj))
	return false

func check_table(column):
	var i = int(0)
	while i < pic_size.y:
		if table[column][i] == -1:
			return Vector2(column, i)
		i += 1
	return Vector2(-1,-1)

func check_image_table(column):
	var i = int(0)
	while i < image_table.get_height():
		if image_table.get_pixel(column,i) == Color(0,0,0,0):
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
		image_table.set_pixel(cell.x, cell.y, _color_from_obj)
		table[cell.x][cell.y] = Color(_color_from_obj)
		dic["bool"] = true
		dic["cell"]["x"] = cell.x
		dic["cell"]["y"] = cell.y
	else:
		dic["bool"] = false
	return dic

func run_block(obj, dic, new_node):
	var s = get_distance(obj, dic, new_node)
	
	pass

func get_distance(obj, dic, new_node):
	var start_pos = obj.position
	var end_pos = Vector2(dic["cell"]["x"]*150, dic["cell"]["y"]*150)
#	var s = 
	