@tool
class_name HitBox
extends CollisionBox

signal hit(hurtbox: HurtBox)

@export var damage: int = 0
@export var stun: int = 0

func _init() -> void:
	super._init()
	collision.connect(_on_collision)

func _ready() -> void:
	super._ready()
	collision_shape.debug_color = Color(1, 0, 0, 0.8)

func _on_collision(collision_box: CollisionBox) -> void:
	if collision_box is not HurtBox:
		return
	
	var box = collision_box as HurtBox
	hit.emit(box)
