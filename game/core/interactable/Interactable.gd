class_name Interactable
extends Area2D


signal interacted()


func _init() -> void:
	collision_layer = Static.Layers.INTERACTABLE
	collision_mask = 0
