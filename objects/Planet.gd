extends Area2D

const ROTATION_SPEED = PI

onready var orbit_position = $Pivot/OrbitPosition
onready var gravitational_field = $Gravity
onready var gravity_refresh = $Gravity/Timer

var radius = 1000

func init(_radius=radius):
		radius = _radius
		$Planet.shape = $Planet.shape.duplicate()
		$Planet.shape.radius = radius
		var image_size = $Sprite.texture.get_size().x / 2
		$Sprite.scale = Vector2(1,1) * radius / image_size
		orbit_position.position.x = radius + 25

func _process(delta):
	$Pivot.rotation += ROTATION_SPEED * delta

func _on_Timer_timeout():
	gravitational_field.monitoring = !gravitational_field.monitoring

