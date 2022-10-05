extends CharacterBody2D

@export var e_speed: float = 100;
@export var e_starting_dir: Vector2 = Vector2(0, 1);

@onready var n_animation_tree = $AnimationTree;
@onready var n_animation_fsm : AnimationNodeStateMachinePlayback = n_animation_tree.get("parameters/playback");

@onready var _player_vars = get_node("/root/GlobalPlayerVars");

func _ready():
	_player_vars.collision_mask = collision_mask;
	_player_vars.z_index = z_index;
	_player_vars.layer_down();
	update_animation_blend_pos(e_starting_dir);

func _process(_delta):
	collision_mask = _player_vars.collision_mask;
	z_index = _player_vars.z_index;

func _physics_process(_delta):
	var input_dir : Vector2 = get_input(); 

	velocity = e_speed * input_dir;
	set_velocity(velocity)
	move_and_slide()

	update_animation_blend_pos(input_dir);
	update_animation_state(velocity);

func get_input() -> Vector2:
	var input_dir = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up")
	);
	return input_dir;

func update_animation_blend_pos(input_dir: Vector2):
	if (input_dir != Vector2.ZERO):
		n_animation_tree.set("parameters/Idle/blend_position", input_dir);
		n_animation_tree.set("parameters/Walk/blend_position", input_dir);

func update_animation_state(vel: Vector2):
	if (vel != Vector2.ZERO):
		n_animation_fsm.travel("Walk");
	else:
		n_animation_fsm.travel("Idle");
