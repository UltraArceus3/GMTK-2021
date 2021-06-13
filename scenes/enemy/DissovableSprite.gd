extends Node2D
class_name DissovableSprite


onready var dissolve_particle = $Particles2D
onready var sprite = $sprite_layer/DissovableSprite
export var texture: Texture
onready var anim_player = $sprite_layer/DissovableSprite/AnimationPlayer

func _ready():
	var text_size = texture.get_size()/2
	sprite.texture = texture
	dissolve_particle.process_material.set_shader_param("emission_box_extents", Vector3(text_size.x,text_size.y,0))
	dissolve_particle.process_material.set_shader_param("sprite",texture)





func _dissolve() -> void:
	anim_player.play("dissolve")
	yield(anim_player,"animation_finished")
	get_parent().queue_free()
