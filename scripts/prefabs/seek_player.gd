extends Area2D
class_name SeekPlayer


var player: KinematicBody2D = null


func can_see_player() -> bool:
  return player != null


func _on_seek_player_body_entered(body: KinematicBody2D) -> void:
  if body.name.match('Player'):
    player = body


func _on_seek_player_body_exited(body: KinematicBody2D) -> void:
  if body.name.match('Player'):
    player = null
