extends CharacterBody2D

@export var start_direction : Vector2 = Vector2.DOWN
@export var max_speed : float = 120.0

# parameters/Idle/blend_position
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")


func _ready() -> void:
	update_animation_direction(start_direction)


func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_top", "move_down")
	
	update_animation_direction(direction)
	
	velocity = direction * max_speed
	move_and_slide()
	
	update_state_machine()


func update_animation_direction(direction: Vector2) -> void:
	if (direction == Vector2.ZERO):
		return
	
	animation_tree.set("parameters/Walk/blend_position", direction)
	animation_tree.set("parameters/Idle/blend_position", direction)	


func update_state_machine() -> void:
	if velocity != Vector2.ZERO:
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
