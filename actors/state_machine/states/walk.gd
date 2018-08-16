extends "res://actors/state_machine/states/state.gd"

func initialize(actor):
	actor.jumps = actor.max_jumps

func state_physics(actor, delta):
	var collision = actor.move_and_collide(actor.velocity * delta)
	if not collision == null:
		actor.collider = collision.collider
	
	
func state_input(actor, event):
	if event.is_action_pressed("jump"):
		actor.jump()