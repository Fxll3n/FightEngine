extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_hurt_box_was_hit(hitbox: HitBox2D) -> void:
	animation_player.play("hurt")
	await animation_player.animation_finished
	animation_player.play("idle")
