extends Node

var score : int = 0

var hud : HUD
var player : Player

func increment_score(amount : int):
	score += amount
	hud.score.text = "SCORE: " + str(score)	

func increment_health(amount : float):
	player.health += amount
	if player.health <= 0:
		get_tree().change_scene_to_file("res://main/main.tscn")
	hud.health_bar.value = player.health/player.MAX_HEALTH
