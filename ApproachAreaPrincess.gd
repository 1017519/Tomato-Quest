extends Area2D

onready var Player = get_tree().get_root().get_node_or_null("Level1").get_node_or_null("Player")
onready var Level = get_tree().get_root().get_node_or_null("Level1")
var princess = self.get_parent()
var dialogue_triggered = false

func _process(_delta):
	if self.overlaps_body(Player):
		if Player.is_on_floor():
			Player.get_node('WalkAnimation').frame = 1
			if dialogue_triggered == false:	
				Level.trigger_princess_dialogue()
				dialogue_triggered = true
				self.queue_free()
