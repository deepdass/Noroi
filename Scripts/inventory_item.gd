extends Sprite2D

var data : ItemData = null
var size : Vector2:
	get():
		return Vector2(data.dimentions.x, data.dimentions.y) * 16
		
var anchor_pt: Vector2:
	get():
		return global_position - size / 2
		
func _ready() -> void:
	if data:
		texture = data.texture
		
func set_init_position(pos: Vector2):
	global_position = pos + size / 2
	anchor_pt =  global_position - size / 2
