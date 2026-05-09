class_name Buyable
extends Interactable

@export var price: int

@export var defaultColor: Color
@export var highlightColor: Color
var label: Label3D

func _ready():
	label = $Label3D

func highlight():
	super.highlight()
	label.outline_modulate = highlightColor
	
func unhighlight():
	super.unhighlight()
	label.outline_modulate = defaultColor

func interact():
	super.interact()
	# Check if player has enough money to buy
	var canBuy = true

	if canBuy:
		# Play sound effect for buying
		# Deduct price from player wallet
		pass
	else:
		# Play sound effect for not being able to afford
		# Flash red?
		pass