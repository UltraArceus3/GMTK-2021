extends KinematicBody2D
class_name DissovableEnemy


var velocity: Vector2
var push_velo: Vector2

var can_move = true

func _push_process() -> void:
	
	var resist_force = 2
	
	if push_velo.x > 0:
		push_velo.x -= resist_force
	elif push_velo.x < 0:
		push_velo.x += resist_force
		
	if push_velo.y > 0:
		push_velo.y -= resist_force
	elif push_velo.y < 0:
		push_velo.y += resist_force
	push_velo = push_velo.round()
	#print(push_velo)
	velocity = push_velo

func _on_LaserCollision_area_entered(area):
	if area.name == "AttackPush":
		#var dust_velocity = 50
		#if $DissovableSprite.scale.x < 0:
			#dust_velocity = -abs(dust_velocity)
			
		if area.get_parent().get_parent().scale.x < 0:
			#dust_velocity = -dust_velocity
			
			$DissovableSprite.dissolve_particle.process_material.set_shader_param("initial_linear_velocity", -50)
		$DissovableSprite._dissolve()
	
func _physics_process(_delta):
	if can_move:
		velocity = move_and_slide(velocity)
	else:
		move_and_slide(push_velo)
	_push_process()

func _freeze() -> void:
	if can_move:
		can_move = false
		modulate = Color(77/256,77/256,77/256,1)
		var freeze_time = Timer.new()
		freeze_time.one_shot = true
		
		add_child(freeze_time)
		freeze_time.start(10)
		
		print("ASD")
		yield(freeze_time,"timeout")
		print("DAS")
		modulate = Color(1,1,1,1)
		can_move = true
		freeze_time.queue_free()
