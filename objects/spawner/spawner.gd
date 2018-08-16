extends Position2D

export (PackedScene) var spike_scene

func _on_timer_timeout():
	var spike = spike_scene.instance()
	
	$spawn_position.add_child(spike)
	var spike_global_pos = spike.global_position
	var spike_global_rotation = spike.global_rotation
	$spawn_position.remove_child(spike)
	get_parent().get_node("spikes").add_child(spike)
	spike.global_position = spike_global_pos
	spike.global_rotation = spike_global_rotation
	
	$timer.wait_time = rand_range(1, 4)
	$timer.start()