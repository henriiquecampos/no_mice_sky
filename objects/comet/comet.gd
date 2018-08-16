extends KinematicBody2D

export (PackedScene) var explosion
export (PackedScene) var score
export (float) var speed = 300
var threshold = 200
var velocity = Vector2(300, 0)
var init_mouse_pos = Vector2(0, 0)
var is_mouse_on = false
var is_selected = false
var collision = null
var sliding = false

func _ready():
	threshold = $mouse_area/shape.shape.radius

func _physics_process(delta):
	move_and_slide(velocity)
			
	if Input.is_action_just_pressed("click") and is_mouse_on:
		init_mouse_pos = get_global_mouse_position()
		
	if Input.is_action_just_pressed("click") and is_mouse_on:
		is_selected = true
		
	if Input.is_action_just_released("click") and is_selected:
		var normal = (get_global_mouse_position() - init_mouse_pos).normalized()
		if init_mouse_pos.distance_to(get_global_mouse_position()) < threshold:
			return
		velocity = (normal * (speed * 2))
		is_selected = false
		sliding = true
	$sprite.rotation = velocity.angle()

func _on_mouse_area_mouse_entered():
	is_mouse_on = true

func _on_mouse_area_mouse_exited():
	is_mouse_on = false

func _on_screen_exited():
	queue_free()

func _on_collision_area_body_entered(body):
	if body.name == "player":
		body.die()
	elif body.name == "moon":
		explode()
		
func explode():
	var coll_pos = position
	if get_slide_count() > 0:
		coll_pos = get_slide_collision(0).position
	var effect = explosion.instance()
	effect.position = coll_pos
	get_parent().add_child(effect)
	effect.emitting = true
	queue_free()

func _on_collision_area_area_entered(area):
	if area.is_in_group("spike"):
		area.get_parent().queue_free()
		if sliding:
			score(1000)
		explode()

func score(amount):
	var s = score.instance()
	s.position = position
	s.get_node("label").text = str(amount)
	get_parent().add_child(s)