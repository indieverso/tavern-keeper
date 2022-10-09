class_name StateMachine
extends Node

var current_state : State

var states : Dictionary = {}

func init(parent) -> void:
	for n in get_children():
		n.parent = parent
		print(n.name)
		states[n.name] = n
	
	change_state("Idle")


func change_state(new_state: String) -> void:
	if new_state not in states:
		print_debug("State ", new_state, " doesn't exist")
		return
		
	if current_state:
		current_state.exit()
	
	current_state = states[new_state]
	current_state.enter()


func physics_process(delta: float) -> void:
	current_state.physics_process(delta)


func unhandled_input(event: InputEvent) -> void:
	current_state.unhandled_input(event)
