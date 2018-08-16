extends StaticBody2D

export (NodePath) var player
export (float) var custom_gravity


func _ready():
	player = get_node(player)

func _physics_process(delta):
	var normal = (position - player.position).normalized()
	
	player.floor_normal = (player.position - position).normalized()
	player.velocity += normal * custom_gravity

func _on_moon_body_entered(body):
	if body == player:
		player.velocity = Vector2(0, 0)
		player.walk()
		set_physics_process(false)

func _on_moon_body_exited(body):
	if body == player:
		set_physics_process(true)
