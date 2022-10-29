extends KinematicBody2D
class_name Player


var speed: float = 200.0
var motion_velocity: Vector2 = Vector2.ZERO
var weapon: String = 'pistol'
onready var animation_legs: AnimationTree = $sprites/legs/AnimationTree
onready var animation_body: AnimationTree = $sprites/body/AnimationTree
onready var animation_node: AnimationNodeStateMachinePlayback = animation_body.get('parameters/playback')


func _process(delta: float) -> void:
  var direction := Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
  if direction:
    motion_velocity = direction.normalized() * speed
  else:
    motion_velocity = motion_velocity.move_toward(Vector2.ZERO, speed)
  look_at(get_global_mouse_position())
  _animations()
    

func _physics_process(delta: float) -> void:
  motion_velocity = move_and_slide(motion_velocity)


func _animations() -> void:
  animation_legs.set('parameters/blend_position', motion_velocity)
  animation_body.set('parameters/%s/blend_position' % weapon, motion_velocity.angle())
