extends Area2D



onready var player_root = get_parent().get_parent()
onready var player_velo

func velo_to_rotate():
	player_velo = player_root.base_velo
	if player_velo == Vector2.ZERO:
		return
	var rot = player_root.get_angle_to(player_root.position+(player_velo*10)) + PI/2
	
	if player_velo.x < 0:
		rot = -rot
	rotation = rot
	#print(player_root.position)
	#print("###")
	#print(player_root.position+(player_velo*10))
	#print(global_position-player_root.global_position)
	
	
	
func _physics_process(_delta):
	velo_to_rotate()
	if Input.is_action_just_pressed("Push") or Input.is_action_just_pressed("za_warudo"):
		$CollisionShape2D.disabled = false
	else:
		$CollisionShape2D.disabled = true


func _on_PushAttack_body_entered(body):
	if Input.is_action_pressed("Push"):
		var push_angle_velo = ($CollisionShape2D.global_position-player_root.global_position).normalized()
		print(push_angle_velo)
		body.push_velo = push_angle_velo*200
	if Input.is_action_pressed("za_warudo"):
		body._freeze()
