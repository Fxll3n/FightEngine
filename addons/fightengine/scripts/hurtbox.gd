@tool
class_name HurtBox
extends CollisionBox

signal was_hit(hitbox: HitBox)

@export var is_active: bool = false

func _init() -> void:
	super._init()

func _ready() -> void:
	super._ready()

func _on_collision(collision_box: CollisionBox) -> void:
	if not is_active:
		return
	if collision_box is not HitBox:
		return
	
	var box = collision_box as HitBox
	was_hit.emit(box)
