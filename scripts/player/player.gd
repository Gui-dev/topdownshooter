extends KinematicBody2D
class_name Player


const Bullet = preload('res://scenes/prefabs/bullet.tscn')
var speed: float = 200.0
var motion_velocity: Vector2 = Vector2.ZERO
var weapon_timer: float = 0.0
var cooldown: float = 0.3
onready var animation_legs: AnimationTree = $sprites/legs/AnimationTree
onready var animation_body: AnimationTree = $sprites/body/AnimationTree
onready var animation_mode: AnimationNodeStateMachinePlayback = animation_body.get('parameters/playback')
onready var barrel: Position2D = $barrel
export(Resource) var weapon = null


func _ready() -> void:
  animation_mode.travel(weapon.name)


func _process(delta: float) -> void:
  var direction := Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
  if direction:
    motion_velocity = direction.normalized() * speed
  else:
    motion_velocity = motion_velocity.move_toward(Vector2.ZERO, speed)
  look_at(get_global_mouse_position())
  _animations()
  
  weapon_timer -= delta
  if Input.is_action_pressed('ui_shoot') and weapon_timer <= 0:
    weapon_timer = cooldown 
    _shoot()
    

func _physics_process(delta: float) -> void:
  motion_velocity = move_and_slide(motion_velocity)


func _animations() -> void:
  animation_legs.set('parameters/blend_position', motion_velocity)
  animation_body.set('parameters/%s/blend_position' % weapon.name, motion_velocity)


func _shoot() -> void:
  var bullet = Bullet.instance()
  bullet.global_position = barrel.global_position
  bullet.rotation_degrees = rotation_degrees
  bullet.apply_impulse(Vector2.ZERO, Vector2(1000, 0).rotated(rotation))
  get_tree().root.call_deferred('add_child', bullet)
