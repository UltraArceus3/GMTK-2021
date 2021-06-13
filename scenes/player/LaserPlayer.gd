extends BasePlayer2D

onready var playback = $AnimationTree.get("parameters/playback")

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("ui_accept"):
			match playback.get_current_node():
				"attack_ready":
					playback.travel("attack_laser")
				"attack_idle":
					playback.travel("attack_ready")

func _ready():
	$AnimationTree.active = true
