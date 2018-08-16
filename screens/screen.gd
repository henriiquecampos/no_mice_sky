extends Control

func show_retry():
	$animator.play("fade")
	yield($animator, "animation_finished")
	$retry.grab_focus()

func _on_retry_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
