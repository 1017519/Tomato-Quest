extends KinematicBody2D



const TARGET_FPS = 60
const PLAYER_SPEED = 300
const GRAVITY = 13
const JUMP_FORCE = 1000

var currentlyWalking = false
var isAlive = true
var velocity = Vector2.ZERO
var cointAmount = 0
var score = 0
onready var checkpoint = self.position


onready var walkAnimation = $WalkAnimation
func add_coin():
	cointAmount += 1
	$CoinCount/Label.text = ":" + str(cointAmount)
	print(cointAmount)

func handle_death():
	get_tree().change_scene("res://DeathScreen.tscn")
	

func _physics_process(delta):

	
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if x_input != 0:
		
		velocity.x = x_input * PLAYER_SPEED * delta * TARGET_FPS
		
		walkAnimation.flip_h = x_input < 0
	elif x_input == 0:
		walkAnimation.frame = 1
		walkAnimation.playing = false
		currentlyWalking = false
		
		
	velocity.y += GRAVITY * delta	
	velocity.y += GRAVITY * delta * TARGET_FPS
	
	if self.position.y > 1150:
		handle_death()
	
	if is_on_floor():
	
		if Input.is_action_just_pressed("ui_up"):
			velocity.y -= JUMP_FORCE/2
			
		if x_input != 0:
			if currentlyWalking == false:
				walkAnimation.frame = 0
				currentlyWalking = true
			walkAnimation.play()
		if x_input == 0:
			velocity.x = 0
			currentlyWalking = false
			
	else:
		walkAnimation.stop()
		if velocity.y > 0 :
			walkAnimation.frame = 1
		elif velocity.y < 0 :
			walkAnimation.frame = 2
		
	velocity = move_and_slide(velocity, Vector2.UP)
	


func _on_Area2D_area_entered(area):
	if area.name == "Deathspot" :
			velocity.y = 0
			velocity.y -= JUMP_FORCE / 2
	
	
		

func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemies"):
		handle_death()
		
