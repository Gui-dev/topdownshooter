extends RigidBody2D
class_name Bullet


func _ready() -> void:
  pass


func _on_bullet_body_entered(_body: Node) -> void:
  queue_free()


func _on_notifier_screen_exited() -> void:
  queue_free()
