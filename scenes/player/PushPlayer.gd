extends BasePlayer2D

onready var playback = $AnimationTree.get("parameters/playback")

var laser_player = preload("res://scenes/player/LaserPlayer.tscn")
var l_p: KinematicBody2D

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if l_p == null:
			l_p = laser_player.instance()
			l_p.position = position
			
			get_parent().add_child(l_p)
			
			if $Sprite.scale.x < 0:
				l_p.get_node("Sprite").scale.x = -1
				l_p.get_node("Attack").scale.x = -1
				l_p.get_node("Attack").position.x = -abs(l_p.get_node("Attack").position.x)
			
			
			
			yield(l_p,"tree_exited")
			l_p = null
	elif Input.is_action_just_pressed("Push") or Input.is_action_just_pressed("za_warudo"):
		playback.travel("Push")
	elif velocity != Vector2.ZERO:
		playback.travel("Walk")
	elif playback.get_current_node() != "Push":
		playback.travel("Idle")
