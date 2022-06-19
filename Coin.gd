extends Area2D




func _on_Coin_area_entered(area):
	if area.get_owner().name == "Player":
		area.get_owner().add_coin()
		queue_free()
