extends "res://actors/state_machine/states/state.gd"
	
func state_physics(actor, delta):
	if actor.velocity.y > 0:
		actor.get_node("character/animator").play("run_fall")
		
	var collision = actor.move_and_collide(actor.velocity * delta)
	if not collision == null:
		actor.collider = collision.collider
	else:
		return
	if actor.collider == actor.moon:
		actor.walk()
	
	
func state_input(actor, event):
	if event.is_action_pressed("jump"):
		actor.jump()
	
	elif event.is_action_released("jump") and actor.velocity.y < 0:
		actor.stop_jump()