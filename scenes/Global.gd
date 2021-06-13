extends Node2D

var player: NodePath
var points: int = 0


func _process(_delta):
	if Input.is_action_just_pressed("switch"):
		pass
	if Input.is_action_just_pressed("f11"):
		OS.window_fullscreen = !OS.window_fullscreen
	if Input.is_action_just_pressed("esc"):
		if OS.window_fullscreen:
			OS.window_fullscreen = false
		else:
			get_tree().quit()
