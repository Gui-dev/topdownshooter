extends KinematicBody2D
class_name Zombie


const ACCELERATION: int = 100
enum State {IDLE, FOLLOW, LISTEN}
var state = State.FOLLOW
var velocity: Vector2 = Vector2.ZERO
var animation: String = ''
var target: Node2D
var timer_attack: float = 0.0
export(int) var health = 3
export(int) var speed = 100
export(float) var distance_follow = 750.0
export(float) var attack_cooldown = 1.0
export(float) var strong = 5.0
onready var texture: AnimatedSprite = $texture
onready var player: KinematicBody2D = GameManager.player


func _physics_process(delta: float) -> void:
  match state:
    State.IDLE:
      _set_animation('idle')
      velocity = Vector2.ZERO
    State.FOLLOW:
      _set_animation('walk')
      var direction = (player.global_position - global_position).normalized()
      var angle = direction.angle()
      velocity = velocity.move_toward(direction * speed, ACCELERATION * delta)
      global_rotation = lerp_angle(global_rotation, angle, 0.05)
    State.LISTEN:
      pass
  velocity = move_and_slide(velocity)    
  


func _set_animation(anim: String) -> void:
  if animation != anim:
    animation = anim
    texture.play(anim)
