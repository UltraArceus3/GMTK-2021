extends TextureRect

export var radius: float = 25.0


func _physics_process(_delta):
	rect_size = Vector2(radius*2.0,radius*2.0)
	rect_position = Vector2(-radius,-radius)
