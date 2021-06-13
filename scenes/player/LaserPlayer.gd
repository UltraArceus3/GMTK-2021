extends BasePlayer2D

onready var playback = $AnimationTree.get("parameters/playback")

onready var sprite_y = $Sprite.position.y

var TIME: float = 0.0

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("ui_accept"):
			match playback.get_current_node():
				"attack_ready":
					playback.travel("attack_laser")
				#"attack_idle":
				#	playback.travel("attack_ready")

func _ready():
	$AnimationTree.active = true
	playback.travel("attack_ready")
	is_player_controlled = false
	
	
	
func _process(delta):
	if playback.get_current_node() == "attack_idle":
		queue_free()
	sprite_oscillate(TIME)
	
	TIME += delta
	
func sprite_oscillate(delta):
	$Sprite.position.y = sprite_y + 3*sin(delta)
