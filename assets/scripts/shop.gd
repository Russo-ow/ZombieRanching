extends Node

var shop_items: Array[Buyable]

# Called when the node enters the scene tree for the first time.
func _ready():
	# Hardcoding for now
	var item = $ShopItems/Gun as Buyable
	item.buySuccess.connect(purchase)
	item.buyFail.connect(purchase_fail)
	shop_items.append(item)
	item = $ShopItems/Ammo as Buyable
	item.buySuccess.connect(purchase)
	item.buyFail.connect(purchase_fail)
	shop_items.append(item)
	item = $ShopItems/Health as Buyable
	item.buySuccess.connect(purchase)
	item.buyFail.connect(purchase_fail)
	shop_items.append(item)


func purchase():
	$PurchaseAudio.play()

func purchase_fail():
	$BuyFailAudio.play()
