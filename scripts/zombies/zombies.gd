extends KinematicBody2D
class_name Zombie


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
export(float) var attack_cooldown = 1.0
export(float) var strong = 5.0
onready var texture: AnimatedSprite = $texture
onready var player: KinematicBody2D = GameManager.player
onready var seek_player: Area2D = $SeekPlayer


func _ready() -> void:
  player.connect('noise', self, '_on_noise')


func _physics_process(delta: float) -> void:
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
