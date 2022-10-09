class_name Actionable
extends Area2D


signal actioned()


func _init() -> void:
	collision_layer = Static.Layers.ACTIONABLE
	collision_mask = 0
