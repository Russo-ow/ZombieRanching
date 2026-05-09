class_name Interactable
extends Area3D

# Theres probably a better way to handle this
@export var sprite: Node3D
@export var highlightSprite: Node3D

func highlight():
	sprite.visible = false
	highlightSprite.visible = true

func unhighlight():
	sprite.visible = true
	highlightSprite.visible = false

func interact():
	pass
