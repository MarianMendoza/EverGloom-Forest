extends CharacterBody2D

@export var move_speed : float = 100

#Starting Direction for sprite
@export var starting_direction: Vector2 = Vector2(0,1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var actionable_finder: Area2D = $Direction/actionablefinder
#ready
func _ready():
	update_animation_parameters(starting_direction)
	
#Moving with keys.

#Need to consider how to keep the velocity the same if the two buttons are pressed at the same time.

func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

	#Update animation
	update_animation_parameters(input_direction)
	
	#Update Speed
	velocity = input_direction * move_speed
	move_and_slide()
	
	#Call state function
	pick_new_state()
	
func _unhandled_input(event:InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
		return

func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/idle/blend_position",move_input)
		animation_tree.set("parameters/walk/blend_position",move_input)
	
func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")

	
