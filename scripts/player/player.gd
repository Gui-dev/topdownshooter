extends KinematicBody2D
class_name Player


const Bullet = preload('res://scenes/prefabs/bullet.tscn')
var speed: float = 200.0
var motion_velocity: Vector2 = Vector2.ZERO
var weapon_timer: float = 0.0
onready var animation_legs: AnimationTree = $sprites/legs/AnimationTree
onready var animation_body: AnimationTree = $sprites/body/AnimationTree
onready var animation_mode: AnimationNodeStateMachinePlayback = animation_body.get('parameters/playback')
onready var barrel: Position2D = $barrel
onready var audio: AudioStreamPlayer = $audio
onready var hud: CanvasLayer = $'../HUD'
export(Resource) var weapon setget _set_weapon


func _draw() -> void:
  animation_mode.travel('%s_reload' % weapon.name)
  hud.ui_update_weapon(weapon.name, weapon.ammo, weapon.max_ammo)  
  _play_sfx(weapon.reload)
  

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
    weapon_timer = weapon.cooldown 
    _shoot()
  if Input.is_action_just_pressed('ui_reload') and weapon.ammo < weapon.capacity and weapon.max_ammo > 0:
    _reload()
    

func _physics_process(_delta: float) -> void:
  motion_velocity = move_and_slide(motion_velocity)


func _animations() -> void:
  animation_legs.set('parameters/blend_position', motion_velocity)
  animation_body.set('parameters/%s/blend_position' % weapon.name, motion_velocity)


func _shoot() -> void:
  if weapon.ammo:
    weapon.ammo -= 1
    animation_mode.travel('%s_shoot' % weapon.name)
    hud.ui_update_weapon(weapon.name, weapon.ammo, weapon.max_ammo)
    _play_sfx(weapon.shoot)
    var bullet = Bullet.instance()
    bullet.global_position = barrel.global_position
    bullet.rotation_degrees = rotation_degrees
    bullet.apply_impulse(Vector2.ZERO, Vector2(1000, 0).rotated(rotation))
    get_tree().root.call_deferred('add_child', bullet)
  else:
    _play_sfx(weapon.empty)


func _reload() -> void:
  weapon_timer = 1
  var diff = weapon.capacity - weapon.ammo
  if weapon.max_ammo >= diff:
    weapon.max_ammo -= diff
    weapon.ammo += diff
  else:
    weapon.ammo += weapon.max_ammo
    weapon.max_ammo = 0
    
  animation_mode.travel('%s_reload' % weapon.name)
  hud.ui_update_weapon(weapon.name, weapon.ammo, weapon.max_ammo)
  _play_sfx(weapon.reload)


func _play_sfx(sfx: AudioStream) -> void:
  audio.stream = sfx
  audio.play()


func _set_weapon(value: Resource) -> void:
  weapon = value
  update()
