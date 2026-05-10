class_name Interactable
extends Area3D

# Theres probably a better way to handle this, maybe just use modulate instead of outline?
@export var sprite: Node3D
@export var highlightSprite: Node3D

func highlight():
	sprite.visible = false
	highlightSprite.visible = true

func unhighlight():
	sprite.visible = true
	highlightSprite.visible = false

func interact():
	pass # To be implemented by children
