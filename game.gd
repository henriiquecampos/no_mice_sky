extends Node

func _on_player_died():
	get_tree().paused = true
	$interface/screen.show_retry()
