extends KinematicBody2D
class_name DissovableEnemy





func _on_LaserCollision_area_entered(area):
	if area.name == "AttackPush":
		if area.get_parent().get_parent().scale.x < 0:
			$DissovableSprite.dissolve_particle.process_material.set_shader_param("initial_linear_velocity", -50)
		$DissovableSprite._dissolve()
	
