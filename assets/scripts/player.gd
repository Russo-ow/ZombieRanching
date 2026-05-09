class_name Player
extends CharacterBody3D

@export var speed = 400
@export var max_tilt = 90
@export var mouse_sense = 0.1

var camera: Camera3D
var camera_movement: Vector2
var raycast: RayCast3D

# Stores the last collider the raycast hit, used to unhighlight
var lastCollider: CollisionObject3D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Move this to some game manager once we have main menu and stuff
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	# Setup camera
	camera = $Camera3D
	raycast = $Camera3D/RayCast3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collider = raycast.get_collider()
	if collider != lastCollider:
		if collider != null and collider.is_in_group("Interactables"):
			(collider as Interactable).highlight()

		if lastCollider != null and lastCollider.is_in_group("Interactables"):
			(lastCollider as Interactable).unhighlight()
		
		lastCollider = collider


func _input(event):
	if event is InputEventMouseMotion:
		var mouse_input = -event.relative * mouse_sense
		camera_movement += mouse_input

func _physics_process(delta):
	var input = Input.get_vector("left", "right", "up", "down")
	velocity = (transform.basis * Vector3(input.x, 0, input.y)).normalized() * delta * speed
	move_and_slide()
	
	rotate_y(deg_to_rad(camera_movement.x))
	camera.rotate_x(deg_to_rad(camera_movement.y))
	var tilt_rad = deg_to_rad(max_tilt)
	camera.rotation.x = clampf(camera.rotation.x, -tilt_rad, tilt_rad)
	camera_movement = Vector2.ZERO
