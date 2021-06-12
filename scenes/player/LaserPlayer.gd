extends BasePlayer2D

onready var playback = $AnimationTree.get("parameters/playback")

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("ui_accept"):
			playback.travel("attack_ready")

func _ready():
	$AnimationTree.active = true
