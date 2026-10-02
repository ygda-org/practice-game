extends Control

class_name HUD

@onready var score : Label = $Background/Score
@onready var health_bar : ProgressBar = $Background/HealthBar

func _ready() -> void:
	Gamestate.hud = self
