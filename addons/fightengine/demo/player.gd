extends CharacterBody2D

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite: Sprite2D = $Sprite2D
@onready var hit_box: HitBox = $Sprite2D/HitBox
@onready var hurt_box: HurtBox = $Sprite2D/HurtBox


var movement_input: Vector2 = Vector2.ZERO
var move_speed: float = 3000.0
var is_attacking: bool = false

func _ready() -> void:
	anim_player.animation_finished.connect(_on_animation_finished)

func _process(_delta: float) -> void:
	movement_input = Vector2(Input.get_axis("left", "right"), 0)
	
	if Input.is_action_just_pressed("punch") and not is_attacking:
		is_attacking = true
		anim_player.play("punch")
		return
	
	if is_attacking:
		return
	
	if movement_input.x == 0:
		anim_player.play("idle")
	else:
		anim_player.play("walk")
	
	# Flip ONLY the sprite, not the entire CharacterBody2D
	if movement_input.x < 0:
		sprite.scale.x = -1
	elif movement_input.x > 0:
		sprite.scale.x = 1

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
	
	if not is_attacking and movement_input.x != 0:
		velocity.x = movement_input.x * move_speed * delta
	else:
		velocity.x = 0
	
	move_and_slide()

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "punch":
		is_attacking = false
