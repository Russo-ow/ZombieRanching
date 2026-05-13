extends Node

@export_category("Sprites")
@export var sprite_default : Texture2D
@export var sprite_firing : Texture2D
@export var sprite_reload : Texture2D

@export_category("Data")
@export var max_ammo := 99
@export var clip_size := 6
@export_group("Timing")
@export var firing_cooldown := .3
@export var firing_frame_duraction := .2
@export var reload_duration := 2.

var sprite_node : Sprite3D
var raycast : RayCast3D
var audio_fire : AudioStreamPlayer3D
var audio_reload : AudioStreamPlayer3D
var audio_empty : AudioStreamPlayer3D

var is_reloading : bool
var stopwatch : float
var clip : int
var ammo : int

func _ready():
	sprite_node = $RevolverSprite
	raycast = $WeaponRaycast
	audio_fire = $FireAudio
	audio_reload = $ReloadAudio
	audio_empty = $EmptyAudio
	ammo = max_ammo
	clip = clip_size

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
	if clip == clip_size:
		return
	is_reloading = true
	stopwatch = 0
	sprite_node.texture = sprite_reload
	audio_reload.play()

func end_reload():
	is_reloading = false
	stopwatch = firing_cooldown
	sprite_node.texture = sprite_default
	var to_add = min(clip_size - clip, ammo)
	ammo -= to_add
	clip += to_add

func fire():
	stopwatch = 0
	if clip == 0:
		audio_empty.play()
		return
	sprite_node.texture = sprite_firing
	clip -= 1
	audio_fire.play()
