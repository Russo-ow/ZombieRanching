extends Node

@export var shop_items: Array[Buyable]

func _ready():
	for item: Buyable in shop_items:
		item.buySuccess.connect(purchase)
		item.buyFail.connect(purchase_fail)

func purchase():
	$PurchaseAudio.play()

func purchase_fail():
	$BuyFailAudio.play()
