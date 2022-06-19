extends CanvasLayer

func handle_dialogue(character_image,character_name, dialogue):
	
	get_node("DialoguePanel/Portrait").texture = character_image
	get_node("DialoguePanel/Name").text = character_name
	get_node("DialoguePanel/DialogueBox").text = dialogue
