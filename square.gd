tool
extends Node2D

const SIZE = Vector2(-150, -150)

export var color = Color(1,1,1)

var pos = Vector2(0,0) setget ,get_pos

var direction:Vector2
var y_pos


func get_pos():
	var zero_pos = get_tree().get_nodes_in_group("level")[0].position
	if direction.x > 0:
		return Vector2((position.x / 75)/ 2.0, y_pos)
	else:
		return Vector2((12 + position.x / 75)/ 2.0, y_pos)

func _ready():
	Time.connect("tick", self, "update_pos_text")
	update_pos_text()
	
	
func update_pos_text(tick=0):
	if direction.x > 0:
		$label.text = "%0.1f, %0.1f" % [(position.x / 75)/ 2.0, y_pos]
	else:
		$label.text = "%0.1f, %0.1f" % [(12 + position.x / 75)/ 2.0, y_pos]
		
	print ($label.text)

func _draw():
	draw_rect(Rect2(-SIZE*0.5, SIZE), color, true)
