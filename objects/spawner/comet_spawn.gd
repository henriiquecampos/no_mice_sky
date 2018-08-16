extends Node

export (PackedScene) var comet_scene
export (NodePath) var moon

export (float) var min_spawn_time = 4.0
export (float) var max_spawn_time = 8.0

func _ready():
	moon = get_node(moon)
	$timer.wait_time = rand_range(min_spawn_time, max_spawn_time)
	$timer.start()

func _on_timer_timeout():
	print("spawn")
	var comet = comet_scene.instance()
	
	comet.position.y = rand_range(OS.window_size.y * 0.1, 
		OS.window_size.y * 0.9)
	add_child(comet)
	var normal = (moon.global_position - comet.global_position).normalized()
	print(normal)
	comet.velocity =  (normal * comet.speed)
	$timer.wait_time = rand_range(min_spawn_time, max_spawn_time)
	$timer.start()