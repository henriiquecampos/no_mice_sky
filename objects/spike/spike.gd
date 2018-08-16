extends Node2D

export (PackedScene) var score

func _ready():
	$particles_2d.emitting = true
	yield($animation_player, "animation_finished")
	$spike/shape.disabled = false
	
func _on_spike_body_entered(body):
	if body.name == "player":
		body.die()
	elif body.is_in_group("comet"):
		queue_free()

func _on_score_body_exited(body):
	if body.name == "player":
		score(body.global_position, 100)

func _on_life_time_timeout():
	$particles_2d.emitting = true
	$animation_player.play_backwards("show")
	yield($animation_player, "animation_finished")
	queue_free()
	
func score(pos, amount):
	var s = score.instance()
	s.get_node("label").text = str(amount)
	get_parent().get_parent().add_child(s)
	s.global_position = pos