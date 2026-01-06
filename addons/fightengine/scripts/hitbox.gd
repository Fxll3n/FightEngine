@tool
class_name HitBox
extends CollisionBox

@export var damage: int = 0
@export var is_active: bool = false

func _init() -> void:
	super._init()
	monitoring = false

func _ready() -> void:
	super._ready()
