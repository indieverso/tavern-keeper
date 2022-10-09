extends CharacterBody2D

@export var start_direction : Vector2 = Vector2.DOWN

# State Machine
@onready var state_machine : StateMachine = $StateMachine

# Interaction
@onready var interact_ballon : = $InteractBallon

# Animation
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var animation_state_machine : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")
@onready var actionable_finder : Area2D = $Direction/ActionableFinder

# Knockback
@onready var sprite : Sprite2D = $Sprite2d

var knockback_position : Vector2 = Vector2.ZERO
var knockback_tween : Tween

# Actionable
var nearest_actionable : Actionable = null


func _ready() -> void:
	state_machine.init(self)
	update_animation_direction(start_direction)


func get_direction() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_top", "move_down")


func _process(_delta: float) -> void:
	check_nearest_actionable()


func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)


func _unhandled_input(event: InputEvent) -> void:
	state_machine.unhandled_input(event)
	
	if (Input.is_action_just_pressed("ui_accept")):
		take_damage(1)


func update_animation_direction(direction: Vector2) -> void:
	if (direction == Vector2.ZERO):
		return
	
	animation_tree.set("parameters/Walk/blend_position", direction)
	animation_tree.set("parameters/Idle/blend_position", direction)


func check_nearest_actionable() -> void:
	var areas : Array[Area2D] = actionable_finder.get_overlapping_areas()
	var shortest_distance : float = INF
	var next_nearest_actionable : Actionable = null
	
	for area in areas:
		var distance : float = area.global_position.distance_to(global_position)
		if distance < shortest_distance:
			shortest_distance = distance
			next_nearest_actionable = area
	
	if not next_nearest_actionable:
		nearest_actionable = null
		interact_ballon.visible = false
		return
	
	if next_nearest_actionable != nearest_actionable or not is_instance_valid(next_nearest_actionable):
		nearest_actionable = next_nearest_actionable
		print_debug("Found actionable")
		interact_ballon.play("question")
		# Events.emit_signal("nearest_actionable_changed", nearest_actionable)


func take_damage(damage: float) -> void:
	print_debug("Took damage: ", damage)
	knockback(Vector2(400,400), 0.25)


func knockback(knockback_strength: Vector2 = Vector2.ZERO, knockback_timer: float = .25) -> void:
	if (knockback_strength != Vector2.ZERO):
		knockback_position = knockback_strength
		
		if (knockback_tween):
			knockback_tween.kill()
		
		knockback_tween = get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback_position", Vector2.ZERO, knockback_timer)
		
		sprite.modulate = Color.RED
		knockback_tween.parallel().tween_property(sprite, "modulate", Color.WHITE, knockback_timer)
