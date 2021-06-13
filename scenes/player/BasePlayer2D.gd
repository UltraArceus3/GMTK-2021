extends KinematicBody2D
class_name BasePlayer2D

export var speed: float = 490
var velocity: Vector2

var flip_scale: int = 3

export var is_player_controlled = true

func _input_to_velocity() -> void:
	velocity.y = (float(Input.is_action_pressed("ui_down")) - float(Input.is_action_pressed("ui_up"))) * speed
	velocity.x = (float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left"))) * speed
	
	_facing()

#func _input(event):
#	if event is InputEventKey:
#		velocity.y = (float(event.is_action_pressed("ui_down")) - float(event.is_action_pressed("ui_up"))) * speed
#		velocity.x = (float(event.is_action_pressed("ui_right")) - float(event.is_action_pressed("ui_left"))) * speed

func _physics_process(_delta):
	if is_player_controlled:
		_input_to_velocity()
	else:
		velocity = Vector2.ZERO
	velocity = move_and_slide(velocity)
	#print($Attack.scale)


func _facing():
	if Input.is_action_pressed("ui_left"):
		$Sprite.scale.x = -1
		$Attack.scale.x = -1
		$Attack.position.x = -45
	elif Input.is_action_pressed("ui_right"):
		$Sprite.scale.x = 1
		$Attack.scale.x = 1
		$Attack.position.x = 45

