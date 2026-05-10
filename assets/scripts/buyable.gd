class_name Buyable
extends Interactable

var inStock = true
@export var price: int
@export var limited: bool

# Sprite colors
var spriteColor = Color.WHITE
var spriteInvalidColor = Color.RED

# Label colors
@export var labelDefaultColor: Color
@export var labelHighlightColor: Color
var label: Label3D

signal buySuccess()
signal buyFail()

func _ready():
	label = $Label3D
	label.text = str('$', price)

func highlight():
	if not inStock: return # Only highlights items in stock
	
	super.highlight()
	label.outline_modulate = labelHighlightColor
	
func unhighlight():
	super.unhighlight()
	label.outline_modulate = labelDefaultColor

func interact():
	super.interact()
	# TODO: Check if player has enough money to buy
	var canBuy = inStock

	if canBuy:
		# Deduct price from player wallet
		buySuccess.emit()
		if(limited):
			inStock = false
			unhighlight()
			# Temp X to show out of stock
			$x.visible = true
			# Darken the sprite, maybe find better solution later
			spriteColor = $Sprite.modulate.darkened(.8)
			$Sprite.modulate = spriteColor
	else:
		buyFail.emit()
		
		# Flashes sprite and label red
		var tween: Tween = create_tween()
		tween.tween_property($Sprite, "modulate", spriteInvalidColor, 0.25)
		tween.tween_property($Sprite, "modulate", spriteColor, 0.25)
		
		var highlight_tween: Tween = create_tween()
		highlight_tween.tween_property($HighlightSprite, "modulate", spriteInvalidColor, 0.25)
		highlight_tween.tween_property($HighlightSprite, "modulate", spriteColor, 0.25)
		
		var label_tween: Tween = create_tween()
		label_tween.tween_property($Label3D, "modulate", spriteInvalidColor, 0.25)
		label_tween.tween_property($Label3D, "modulate", Color.WHITE, 0.25)
