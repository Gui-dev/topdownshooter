extends Camera2D
class_name CameraPlayer


var shake_amount: float = 0.0
var default_offset: Vector2 = offset
var shaking: bool = false
onready var shake_timer: Timer = $timer
onready var tween: Tween = $tween

func _ready() -> void:
  GameManager.camera = self
  var _timer_connect = shake_timer.connect('timeout', self, '_on_shake_timer_timeout')


func _process(delta: float) -> void:
  if shaking:
    offset = Vector2(
      rand_range(-shake_amount, shake_amount), 
      rand_range(-shake_amount, shake_amount)
    ) * delta + default_offset 


func shake(shake_strong: float, shake_duration: float = 0.4, shake_limit: float = 100) -> void:
  shake_amount += shake_strong
  if shake_amount > shake_limit:
    shake_amount = shake_limit
  shaking = true
  shake_timer.wait_time = shake_duration
  shake_timer.start()


func _on_shake_timer_timeout() -> void:
  shake_amount = 0
  shaking = false
  var _tween_property = tween.interpolate_property(self, 'offset', offset, default_offset, 0.1, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
  var _tween_start = tween.start()
