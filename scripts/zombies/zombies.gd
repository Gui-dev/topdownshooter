extends KinematicBody2D
class_name Zombie


const Blood = preload('res://scenes/prefabs/blood.tscn')
const ACCELERATION: int = 100
enum State {IDLE, FOLLOW, LISTEN}
var state = State.IDLE
var velocity: Vector2 = Vector2.ZERO
var animation: String = ''
var target: Vector2 = Vector2.ZERO
var timer_attack: float = 0.0
export(int) var health = 3
export(int) var speed = 100
export var distance_follow := 750
export(int) var distance_attack = 50
export(float) var attack_cooldown = 1.0
export(float) var strong = 5.0
onready var texture: AnimatedSprite = $texture
onready var player: KinematicBody2D = GameManager.player
onready var seek_player: Area2D = $SeekPlayer


func _ready() -> void:
  var _player_connect = player.connect('noise', self, '_on_noise')


func _physics_process(delta: float) -> void:
  if GameManager.player_death:
    _enter_state(State.IDLE)
  match state:
    State.IDLE:
      _set_animation('idle')
      velocity = Vector2.ZERO
      if seek_player.can_see_player():
        _enter_state(State.FOLLOW)
    State.FOLLOW:
      _set_animation('walk')
      var direction = (player.global_position - global_position).normalized()
      var angle = direction.angle()
      velocity = velocity.move_toward(direction * speed, ACCELERATION * delta)
      global_rotation = lerp_angle(global_rotation, angle, 0.05)
      var distance = global_position.distance_to(player.global_position)
      timer_attack += delta
      if distance <= distance_attack and timer_attack >= attack_cooldown and not GameManager.player_death:
        timer_attack = 0
        player.apply_damage(strong)
      
    State.LISTEN:
      _set_animation('walk')
      var direction = (target - global_position).normalized()
      var angle = direction.angle()
      velocity = velocity.move_toward(direction * speed, ACCELERATION * delta)
      global_rotation = lerp_angle(global_rotation, angle, 0.05)
      var distance = global_position.distance_to(target)
      if distance <= 100:
        _enter_state(State.IDLE)
      if seek_player.can_see_player():
        _enter_state(State.FOLLOW)
      
      
  velocity = move_and_slide(velocity)    


func apply_damage(damage: int) -> void:
  health -= damage
  if health <= 0:
    _death()
  else:
    _blink()


func _blink() -> void:
  modulate = Color.red
  yield(get_tree().create_timer(.2), 'timeout')
  modulate = Color.white


func _death() -> void:
  var blood = Blood.instance()
  get_node('../../').zombies_death += 1
  get_node('../../HUD').ui_update_zombie_death()
  get_node('../../content').add_child(blood)
  blood.global_position = global_position
  blood.global_rotation = global_rotation
  queue_free()
  

func _set_animation(anim: String) -> void:
  if animation != anim:
    animation = anim
    texture.play(anim)
    

func _enter_state(new_state) -> void:
  if state != new_state:
    state = new_state


func _on_noise(shoot: Vector2) -> void:
  var distance = global_position.distance_to(shoot)
  if distance <= distance_follow:
    target = shoot
    _enter_state(State.LISTEN)
