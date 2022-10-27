extends KinematicBody2D
class_name Player


var speed: float = 200.0
var motion_velocity: Vector2 = Vector2.ZERO


func _process(delta: float) -> void:
  var direction := Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
  if direction:
    motion_velocity = direction.normalized() * speed
  else:
    motion_velocity = motion_velocity.move_toward(Vector2.ZERO, speed)
  look_at(get_global_mouse_position())
    

func _physics_process(delta: float) -> void:
  motion_velocity = move_and_slide(motion_velocity)
