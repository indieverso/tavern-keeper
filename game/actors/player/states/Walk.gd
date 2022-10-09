extends State

@export var max_speed : float = 120.0


func physics_process(_delta: float) -> void:
	var character := parent as CharacterBody2D
	var direction = character.get_direction()
	
	if direction == Vector2.ZERO:
		state_machine.change_state("Idle")
		return
	
	character.update_animation_direction(direction)
	
	character.velocity = direction * max_speed
	character.velocity += parent.knockback_position * -direction
	
	character.move_and_slide()
	
	character.animation_state_machine.travel("Walk")


func unhandled_input(_event: InputEvent) -> void:
	pass
