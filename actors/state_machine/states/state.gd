extends Node

func _ready():
	set_process(false)
	set_physics_process(false)
	set_process_input(false)

func initialize(actor):
	pass
	
func clear():
	pass
	
func state_input(actor, event):
	pass
	
func state_physics(actor, delta):
	pass