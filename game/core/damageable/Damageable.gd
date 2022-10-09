class_name Damageable
extends Area2D


signal damaged(amount: float)


@export var health : float = 100


func _init() -> void:
	collision_layer = 0
	collision_mask = Static.Layers.DAMAGEABLE


func _ready() -> void:
	self.connect("area_entered", _on_area_entered)


func _on_area_entered(harmable: Harmable) -> void:
	print_debug("Harmable entered")
	if harmable == null:
		return
	
	if owner.has_method("take_damage"):
		owner.take_damage(harmable.damage)
	
	emit_signal("damaged", harmable.damage)
