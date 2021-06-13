extends Node2D



func _on_VideoPlayer_finished():
	#yield(get_tree().create_timer(2),"timeout")
	get_tree().change_scene("res://scenes/title_screen.tscn")
