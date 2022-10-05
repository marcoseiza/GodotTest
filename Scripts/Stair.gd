extends Node2D

@onready var player_vars := get_node("/root/GlobalPlayerVars");

@onready var top_sensor := get_node("TopSensor");
@onready var bottom_sensor := get_node("BottomSensor");

var bottom_hit : bool = false;
var top_hit : bool = false;

enum Action { UPWARDS, DOWNWARDS, NONE }
var action : Action = Action.NONE;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (action == Action.UPWARDS):
		player_vars.layer_up();
	if (action == Action.DOWNWARDS):
		player_vars.layer_down();
	action = Action.NONE
	pass

func _on_bottom_sensor_body_entered(body: Node2D):
	if (body.name != "Player"):
		return
	bottom_hit = true;

func _on_top_sensor_body_entered(body: Node2D):
	if (body.name != "Player"):
		return
	top_hit = true;

func _on_bottom_sensor_body_exited(body: Node2D):
	if (body.name != "Player"):
		return
	bottom_hit = false;
	if (top_hit):
		action = Action.UPWARDS;

func _on_top_sensor_body_exited(body: Node2D):
	if (body.name != "Player"):
		return
	top_hit = false;
	if (bottom_hit):
		action = Action.DOWNWARDS;
