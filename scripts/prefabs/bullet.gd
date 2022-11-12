extends RigidBody2D
class_name Bullet


func _on_bullet_body_entered(body: Node) -> void:
  if body.has_method('active_siren'):
    body.active_siren()
  queue_free()


func _on_notifier_screen_exited() -> void:
  queue_free()
