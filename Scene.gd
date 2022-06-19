extends Node2D

onready var DialogueMenu = get_node("Player").get_node("DialogueMenu")
onready var PlayerPortrait = preload("res://Sprites/Player/Tomato_Portrait.PNG")
onready var BurgerPortrait = preload("res://Sprites/Enemies/Burger/Burger_Portrait.PNG")
onready var PrincessPortrait = preload("res://Sprites/Princess/Princess_Portrait.PNG")
var current_burger_dialogue = 0 
var burgerDeathDialogue = false
var current_princess_dialogue = 0
onready var burger = get_tree().get_root().get_node("Level1").get_node_or_null("Burger")
var princess
var princess_can_talk = true

func trigger_burger_dialogue():
	current_burger_dialogue += 1
	DialogueMenu.get_node("DialoguePanel").visible = true
	
func trigger_princess_dialogue():
	current_princess_dialogue += 1
	
func change_to_winscreen():
	yield(get_tree().create_timer(1.3), "timeout")
	get_tree().change_scene("res://WinScreen.tscn")
	
func _process(_delta):
	if current_burger_dialogue == 1:
		DialogueMenu.handle_dialogue(BurgerPortrait,"Burger", "HEY! STOP RIGHT THERE!" )
	if current_burger_dialogue == 2:
		DialogueMenu.handle_dialogue(PlayerPortrait,"Player", "You! You kidnapped my princess!" )
	if current_burger_dialogue == 3:
		DialogueMenu.handle_dialogue(BurgerPortrait,"Burger", "Yes I did. I brainwashed the cabbages to follow my will." )
	if current_burger_dialogue == 4:
		DialogueMenu.handle_dialogue(BurgerPortrait,"Burger", "MWAHAHAHA" )
	if current_burger_dialogue == 5:
		DialogueMenu.handle_dialogue(PlayerPortrait,"Player", "You wont get away with this!" )
		yield(get_tree().create_timer(1), "timeout")
		DialogueMenu.get_node("DialoguePanel").visible = false
		burger.aggrod = true
		burger.velocity.x = burger.H_SPEED
		burger.get_node("Walking").playing = true
		burger.get_node("Walking").flip_h = false
		burger.get_node("Healthbar/ProgressBar").visible = true
		burger.add_to_group("Enemies")
		current_burger_dialogue +=1
		
			
	if get_tree().get_root().get_node("Level1").get_node_or_null("Burger") == null:
		if burgerDeathDialogue == false:
			DialogueMenu.get_node("DialoguePanel").visible = true
			DialogueMenu.handle_dialogue(BurgerPortrait, "Burger", "OWWW")
			yield(get_tree().create_timer(1.3), "timeout")
			DialogueMenu.handle_dialogue(BurgerPortrait, "Burger", "HOW DARE YOU DO THIS TO ME!")
			yield(get_tree().create_timer(1), "timeout")
			DialogueMenu.get_node("DialoguePanel").visible = false
			burgerDeathDialogue = true
			princess_can_talk = true
		if princess != null and princess_can_talk == true:
			if current_princess_dialogue == 1:
				DialogueMenu.handle_dialogue(PrincessPortrait, "Princess", "Thanks for saving me!")
				change_to_winscreen()
				
				
	if get_tree().get_root().get_node("Level1").get_node_or_null("Princess") != null:
		if current_princess_dialogue == 1:
			DialogueMenu.get_node("DialoguePanel").visible = true
			
	
	if Input.is_action_just_pressed("ui_accept"):
		if current_burger_dialogue < 5 and current_burger_dialogue > 0:
			current_burger_dialogue += 1
		
