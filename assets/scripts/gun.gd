extends Node

@export_category("Sprites")
@export var sprite_default : Texture2D
@export var sprite_firing : Texture2D
@export var sprite_reload : Texture2D

var sprite_node : Sprite3D
var raycast : RayCast3D

var is_reloading : bool
var stopwatch : float

@export_category("Data")
@export var firing_cooldown := .3
@export var firing_frame_duraction := .2
@export var reload_duration := 2.

func _ready():
	sprite_node = $RevolverSprite
	raycast = $WeaponRaycast

func _process(delta: float):
	if is_reloading || stopwatch < firing_cooldown:
		stopwatch += delta
	if is_reloading && stopwatch >= reload_duration:
		is_reloading = false
		stopwatch = firing_cooldown
		sprite_node.texture = sprite_default
	elif !is_reloading && stopwatch >= firing_cooldown:
		sprite_node.texture = sprite_default
	if !is_reloading && Input.is_action_just_pressed("reload"):
		is_reloading = true
		stopwatch = 0
		sprite_node.texture = sprite_reload
	elif !is_reloading && stopwatch >= firing_cooldown && Input.is_action_just_pressed("interact"):
		stopwatch = 0
		sprite_node.texture = sprite_firing
