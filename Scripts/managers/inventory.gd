extends PanelContainer

@export var items : Array[ItemData] = []
const inv_item_scene : PackedScene = preload("res://Maps/scenes/inventory_item.tscn")
@onready var item_grid: GridContainer = $item_grid

func _ready() -> void:
	for i in items:
		add_item(i)

func add_item(item_data : ItemData):
	var inventory_item = inv_item_scene.instantiate()
	inventory_item.data = item_data
	add_child(inventory_item)
	var success = item_grid.attempt_to_add_item_data(inventory_item)
	
