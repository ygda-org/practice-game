extends Node

var score : int = 0

var hud : HUD

func increment_score(amount : int):
	score += amount
	hud.score.text = "SCORE: " + str(score)	
