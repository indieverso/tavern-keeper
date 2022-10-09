class_name State
extends Node

@onready var state_machine : StateMachine = get_parent()

# who holds the state machine
var parent


func enter() -> void:
	print_debug("Entered state: ", name)


func exit() -> void:
	print_debug("Exited state: ", name)


func physics_process(_delta: float) -> void:
	pass


func unhandled_input(_event: InputEvent) -> void:
	pass
