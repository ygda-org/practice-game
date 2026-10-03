extends Node

var score : int = 0

var hud : HUD
var player : Player

func _ready() -> void:
	hud.health_bar.value = player.MAX_HEALTH
	hud.health_bar.max_value = player.MAX_HEALTH

func increment_score(amount : int):
	score += amount
	hud.score.text = "SCORE: " + str(score)	

func increment_health(amount : float):
	player.health += amount
	hud.health_bar.value = player.health
