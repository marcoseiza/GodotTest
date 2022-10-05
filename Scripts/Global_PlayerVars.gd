extends Node;

@onready var _bottom_layer: int = 3;
@onready var _top_layer: int = 4;

@onready var _bottom_layer_z_index: int = 2;
@onready var _top_layer_z_index: int = 4;

@onready var collision_mask: int = 0;
@onready var _is_bottom_layer: bool = true;
@onready var z_index: int = _bottom_layer_z_index;

func layer_up():
  _is_bottom_layer = false;
  z_index = _top_layer_z_index;
  _change_layers(_is_bottom_layer);

func layer_down():
  _is_bottom_layer = true;
  z_index = _bottom_layer_z_index;
  _change_layers(_is_bottom_layer);

func _change_layers(is_bottom_layer):
  collision_mask = _toggle_bit(collision_mask, _bottom_layer, is_bottom_layer);
  collision_mask = _toggle_bit(collision_mask, _top_layer, !is_bottom_layer);

func _toggle_bit(mask: int, layer: int, value: bool) -> int:
  if (value):
    return mask | (1 << (layer - 1))
  else:
    return mask & ~(1 << (layer - 1))
