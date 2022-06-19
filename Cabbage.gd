extends KinematicBody2D


var velocity = Vector2.ZERO
const FRAME_RATE = 60
export var MAX_DISTANCE = 100
var originalPos = Vector2.ZERO
const H_SPEED = 200
export var AGGRO_SPEED = 400
const GRAVITY = 8
onready var level = self.get_parent()
var isDead = false




func _ready():
	originalPos = self.position
	velocity.x = H_SPEED
	
func drop_coin():
	var coin = preload("res://Coin.tscn").instance()
	coin.global_position = global_position
	coin.position.y -= 65
	get_tree().get_root().get_node("Level1").get_node("Coins").add_child(coin)

	
func _physics_process(delta):
	
		if isDead == true:
			set_modulate(lerp(get_modulate(), Color(1,1,1,0), 0.2))
			$Walking.playing = false
			
		else:
			if self.position.x - originalPos.x > MAX_DISTANCE:
				velocity.x = -velocity.x
				$Walking.flip_h = true
				$AggroArea/CollisionShape2D.position *= -1
			elif self.position.x - originalPos.x < -MAX_DISTANCE: 
				velocity.x = -velocity.x
				$Walking.flip_h = false
				$AggroArea/CollisionShape2D.position *= -1
			
			velocity.y += GRAVITY * delta * FRAME_RATE	
		
			velocity = move_and_slide(velocity * delta * FRAME_RATE,Vector2.UP)
			


func _on_AggroArea_body_entered(body):
	if body.name == "Player":	
		
		if velocity.x > 0:
			velocity.x = AGGRO_SPEED
		elif velocity.x < 0:
			velocity.x = -AGGRO_SPEED
		
		$Walking.speed_scale = 1.5
	
func _on_AggroArea_body_exited(body):
	if body.name == "Player":	
		if velocity.x > 0:
			velocity.x = H_SPEED
		elif velocity.x < 0:
			velocity.x = -H_SPEED
			
		$Walking.speed_scale = 1.2

func _on_Deathspot_area_entered(area):
	if area.get_parent().name == "Player":
		isDead = true
		$Deathtimer.start()
		
	
	


func _on_Deathtimer_timeout():
	drop_coin()
	self.queue_free()
