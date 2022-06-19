extends KinematicBody2D



var velocity = Vector2.ZERO
const FRAME_RATE = 60
export var MAX_DISTANCE = 100
var originalPos = Vector2.ZERO
const H_SPEED = 400
const GRAVITY = 8
export var aggrod = false
onready var level = self.get_parent()
var isDead = false
var lifeCount = 3


func drop_princess():
	var Princess = preload("res://Princess.tscn").instance()
	Princess.global_position = global_position
	Princess.position.y -= 65
	get_tree().get_root().get_node("Level1").add_child(Princess)
	
	return Princess

func _ready():
	originalPos = self.position
	aggrod = false



	
func _physics_process(delta):
	if aggrod == true:

		if isDead == true:
			set_modulate(lerp(get_modulate(), Color(1,1,1,0), 0.2))
			$Walking.playing = false
			
		else:
			
			if self.position.x - originalPos.x > MAX_DISTANCE:
				velocity.x = -velocity.x
				$Walking.flip_h = true
			elif self.position.x - originalPos.x < -MAX_DISTANCE: 
				velocity.x = -velocity.x
				$Walking.flip_h = false
			
	velocity.y += GRAVITY * delta * FRAME_RATE	
		
	velocity = move_and_slide(velocity * delta * FRAME_RATE,Vector2.UP)
			



func _on_Deathspot_area_entered(area):
	if aggrod == true:
		if area.get_parent().name == "Player":
			if lifeCount > 0:
				var player = area.get_parent()
				lifeCount -= 1
				$Healthbar/ProgressBar.value -= 1
			elif lifeCount == 0:
				isDead = true
				$DeathTimer.start()
		
	


func _on_DeathTimer_timeout():
	level.princess =drop_princess()
	self.queue_free()




	


