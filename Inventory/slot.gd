extends PanelContainer

signal slot_clicked(index: int, button: int)

@onready var texture_rect = $MarginContainer/TextureRect
@onready var quantity_label = $QuantityLabel

# Function to set the contents of an inventory slot. Changes texture and quantity
func set_slot_data(slot_data: SlotData) -> void:
	texture_rect.texture = slot_data.item_data.texture
	tooltip_text = "%s\n%s" % [slot_data.item_data.name, slot_data.item_data.description]
	
	if slot_data.quantity > 1:
		quantity_label.text = "x%s" % str(slot_data.quantity)
		quantity_label.show()
	else:
		quantity_label.hide()


# Handles user input on this slot and emits an event that is detected in: inventory.gd
func _on_gui_input(event):
	# Make sure input event is a left or mouse button press
	if event is InputEventMouseButton \
		and (event.button_index == MOUSE_BUTTON_LEFT \
		or event.button_index == MOUSE_BUTTON_RIGHT) \
		and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)
