extends GridContainer


const inventory_cell_scene = preload("res://Maps/scenes/inventory_cell.tscn")
const CELL_SIZE : int = 30
@onready var inv_dimentions : Vector2i = Vector2i(6,11)
var cell_data : Array[Node] = []


func _ready() -> void:
	create_cells()
	fill_cell_data()
	
	
func create_cells():
	self.columns = inv_dimentions.y
	for y in inv_dimentions.y:
		for x in inv_dimentions.x:
			var inv_cell = inventory_cell_scene.instantiate()
			add_child(inv_cell)

func _gui_input(event : InputEvent):
	if event is  InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.is_pressed():
			var index = get_cell_index_form_coords(get_global_mouse_position())
			print(index, get_coords_from_index(index))
	

func fill_cell_data():
	cell_data.resize(inv_dimentions.x * inv_dimentions.y)
	cell_data.fill(null)
	
func attempt_to_add_item_data(item : Node) -> bool:
	var cell_index : int = 0
	while cell_index < cell_data.size():
		if item_fits(cell_index, item.data.dimentions):
			break
		cell_index += 1
	if cell_index >= cell_data.size():
		return false
	for y in item.data.dimentions.y:
		for x in item.data.dimentions.x:
			cell_data[cell_index + x + y * columns] = item
	item.set_init_position(get_coords_from_index(cell_index))
	return true
	
func item_fits(index: int, dimentions: Vector2i):
	for y in dimentions.y:
		for x in dimentions.x:
			var current_index = index + x + y * columns
			if current_index >= cell_data.size():
				return false
			if cell_data[current_index] != null:
				return false
	return true

func get_cell_index_form_coords(coords : Vector2i):
	coords -= Vector2i(self.global_position)
	coords = coords / CELL_SIZE
	var index = coords.x + coords.y * columns
	if index > inv_dimentions.x * inv_dimentions.y or index < 0:
		return - 1
	return index
	
func get_coords_from_index(index: int) -> Vector2i:
	var row = index / columns
	var column = index % columns
	return Vector2i(global_position) + Vector2i(column * CELL_SIZE, row * CELL_SIZE)
	
