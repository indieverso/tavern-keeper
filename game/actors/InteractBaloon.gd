extends Control


@onready var animation_player : AnimationPlayer = $AnimationPlayer


func _init() -> void:
	visible = false


func _ready() -> void:
	animation_player.connect("animation_started", func(name): self.visible = true)


func play(anim: String) -> void:
	animation_player.play(anim)
