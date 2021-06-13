extends KinematicBody2D
class_name DissovableEnemy


var velocity: Vector2
var push_velo: Vector2

var can_move = true

var following = null

export var speed: float = 100

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
	if push_velo != Vector2.ZERO:
		velocity = push_velo
	else:
		if velocity.round() == Vector2.ZERO:
			velocity = Vector2.ZERO

func _on_LaserCollision_area_entered(area):
	if area.name == "AttackPush":
		#var dust_velocity = 50
		#if $DissovableSprite.scale.x < 0:
			#dust_velocity = -abs(dust_velocity)
			
		if area.get_parent().get_parent().scale.x < 0:
			#dust_velocity = -dust_velocity
			
			$DissovableSprite.dissolve_particle.process_material.set_shader_param("initial_linear_velocity", -50)
		can_move = false
		$CollisionShape2D.disabled = true
		Global.points += 1
		$DissovableSprite._dissolve()
	
func _physics_process(_delta):
	if can_move:
		velocity = move_and_slide(velocity)
		
		#if $DissovableSprite/sprite_layer/DissovableSprite/AnimationPlayer.is_playing():
		#	following = null
		if !is_instance_valid(following):
			following = null
			velocity = Vector2.ZERO
		
		if following != null and is_instance_valid(following):
			var fol_pos = following.position - position
			fol_pos = fol_pos.normalized()
			velocity = fol_pos * speed
	else:
		move_and_slide(push_velo)
	_push_process()

func _freeze() -> void:
	if can_move:
		can_move = false
		modulate = Color(77.0/256.0,77.0/256.0,77.0/256.0,1)
		var freeze_time = Timer.new()
		freeze_time.one_shot = true
		
		add_child(freeze_time)
		freeze_time.start(10)
		
		print("ASD")
		yield(freeze_time,"timeout")
		print("DAS")
		
		if !$DissovableSprite/sprite_layer/DissovableSprite/AnimationPlayer.is_playing():
		
			modulate = Color(1,1,1,1)
			can_move = true
			freeze_time.queue_free()


func _on_PlayerTracker_body_entered(body):
	if following == null or !is_instance_valid(following):
		following = body
	else:
		if following.name != "LaserPlayer":
			following = body
