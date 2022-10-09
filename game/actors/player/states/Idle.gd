extends State


func physics_process(_delta: float) -> void:
	var character := parent as CharacterBody2D
	var direction = character.get_direction()
	
	if direction != Vector2.ZERO:
		state_machine.change_state("Walk")
		return
	
	character.velocity = character.knockback_position * direction
	character.move_and_slide()
	
	character.animation_state_machine.travel("Idle")


func unhandled_input(_event: InputEvent) -> void:
	pass
