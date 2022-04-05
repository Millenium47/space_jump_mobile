extends Area2D

const ACCELETERATION = 2
const FRICTION = 2
const MAX_SPEED = 100

var planet_gravity = Vector2(0, -5)  # gravity force
var direction = Vector2(0, 0)
var velocity = Vector2(0, 0)  # start value for testing
var jump_speed = 50
var target = null
var gravitational_force = 0
var gravitational_direction = Vector2(0, 0)
var gravitation = Vector2(0, 0)

func jump():
	target = null;
	velocity = velocity.move_toward(get_direction() * MAX_SPEED, ACCELETERATION)

func _physics_process(delta):
	
	if target:
		transform = target.orbit_position.global_transform
	else:
		position += (velocity + gravitation) * delta
	
	if Input.get_action_strength("player_drive"):
		jump()
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)

func _on_Player_area_entered(area):
	if area.is_in_group("planets"):
		target = area
		velocity = Vector2()
		gravitation = Vector2()
	elif area.is_in_group("gravity"):
		gravitational_direction = global_position.direction_to(area.global_position)
		gravitational_force = 50 - global_position.distance_to(area.global_position) / 5
		gravitation = gravitational_direction * gravitational_force
	
func _on_Player_area_exited(area):
		 gravitation = Vector2.ZERO

func get_direction():
	direction = -transform.y
	
	if direction.length() > 0:
		direction = direction.normalized()
	
	return direction
	
