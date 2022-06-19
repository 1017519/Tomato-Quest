extends ParallaxLayer


var screen_size := Vector2(1280, 720)

func _ready():
	motion_offset = -(screen_size / 2) + ((screen_size / 2) * motion_scale)
