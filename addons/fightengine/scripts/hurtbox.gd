@tool
class_name HurtBox
extends CollisionBox

signal was_hit(hitbox: HitBox)

func _init() -> void:
	super._init()
	collision.connect(_on_collision)

func _ready() -> void:
	super._ready()
	collision_shape.debug_color = Color(0, 1, 0, 0.8)

func _on_collision(collision_box: CollisionBox) -> void:
	if collision_box is not HitBox:
		return
	
	var box = collision_box as HitBox
	was_hit.emit(box)
