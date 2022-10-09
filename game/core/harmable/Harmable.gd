class_name Harmable
extends Area2D


@export var damage : float = 0


func _init() -> void:
	collision_layer = Static.Layers.DAMAGEABLE
	collision_mask = 0
