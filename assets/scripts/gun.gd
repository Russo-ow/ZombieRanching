extends Node

@export_category("Sprites")
@export var sprite_default : Texture2D
@export var sprite_firing : Texture2D
@export var sprite_reload : Texture2D

@export_category("Data")
@export var firing_cooldown := .3
@export var firing_frame_duraction := .2
@export var reload_duration := 2.

var sprite_node : Sprite3D
var raycast : RayCast3D
var audio_fire : AudioStreamPlayer3D
var audio_reload : AudioStreamPlayer3D

var is_reloading : bool
var stopwatch : float

func _ready():
	sprite_node = $RevolverSprite
	raycast = $WeaponRaycast
	audio_fire = $FireAudio
	audio_reload = $ReloadAudio

func _process(delta: float):
	if is_reloading || stopwatch < firing_cooldown:
		stopwatch += delta
	if is_reloading && stopwatch >= reload_duration:
		end_reload()
	elif !is_reloading && stopwatch >= firing_cooldown:
		sprite_node.texture = sprite_default
	if !is_reloading && Input.is_action_just_pressed("reload"):
		start_reload()
	elif !is_reloading && stopwatch >= firing_cooldown && Input.is_action_just_pressed("interact"):
		fire()

func start_reload():
	is_reloading = true
	stopwatch = 0
	sprite_node.texture = sprite_reload
	audio_reload.play()

func end_reload():
	is_reloading = false
	stopwatch = firing_cooldown
	sprite_node.texture = sprite_default

func fire():
	stopwatch = 0
	sprite_node.texture = sprite_firing
	audio_fire.play()
