extends Position2D
class_name Blood


onready var tween: Tween = $tween


func _ready() -> void:
  randomize()
  var random_blood = randi() % 3
  get_child(random_blood).visible = true
  var _tween_props = tween.interpolate_property(self, 'modulate:a', 1, 0, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
  var _tween_start = tween.start()


func _on_tween_all_completed() -> void:
  queue_free()
