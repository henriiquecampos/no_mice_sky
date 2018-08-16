extends KinematicBody2D

export (float) var jump_height
export (int) var max_jumps
export (NodePath) var moon

onready var jumps = max_jumps
var velocity = Vector2(0, 0)
var floor_normal = Vector2(0, -1)
var collider = null

signal died

func die():
	emit_signal("died")

func jump():
	if jumps < 1:
		return
	$state_machine.set_state("jump")
	$character/animator.play("run_jump")
	jumps -= 1
	velocity = (position - moon.position).normalized() * jump_height
	
func stop_jump():
	velocity.y = 0
	
func fall():
	jumps -= 1
	$state_machine.set_state("jump")
	$character/animator.play("run_fall")

func walk():
	$character/animator.play("running")
	$state_machine.set_state("walk")

func _ready():
	moon = get_node(moon)
	walk()
	
func _physics_process(delta):
	$state_machine.state.state_physics(self, delta)
	
func _input(event):
	$state_machine.state.state_input(self, event)