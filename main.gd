extends Node2D



var count: int = 0
var cap: int = 10

onready var enemy = preload("res://scenes/enemy/enemy0.tscn")

func spawn():

	if count < cap:
		#-300 - -212 , 1900, 1078
		var i = enemy.instance()
		i.position = Vector2(randi()% 1899 + -300, randi()% 1077 + -212)
		add_child(i)
		i.connect("_on_death", self, "_on_enemy_death")
		count += 1
		
	randomize()
	$Timer.start(randf())
	


func _on_Timer_timeout():
	spawn()

func _on_enemy_death():
	count -= 1
	print(count)

func _physics_process(_delta):
	$CanvasLayer/Label.text = "Points: " + str(Global.points)
