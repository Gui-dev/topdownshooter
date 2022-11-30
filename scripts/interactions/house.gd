extends StaticBody2D
class_name House

onready var texture_house_out: Sprite = $texture_house_out
onready var tween: Tween = $tween


func _on_area_house_body_entered(body: Node) -> void:
  if body.name == 'Player':
    var _twee_props = tween.interpolate_property(
      texture_house_out, 
      'modulate:a',
      1,
      0,
      2,
      Tween.TRANS_LINEAR,
      Tween.EASE_OUT  
    )
    var _twee_start = tween.start()


func _on_area_house_body_exited(body: Node) -> void:
  if body.name == 'Player':
    var _twee_props = tween.interpolate_property(
      texture_house_out, 
      'modulate:a',
      0,
      1,
      0.3,
      Tween.TRANS_LINEAR,
      Tween.EASE_OUT  
    )
    var _twee_start = tween.start()
