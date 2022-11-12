extends StaticBody2D
class_name PoliceCar


var play_siren: bool = false
onready var lights: Node2D = $lights
onready var audio_siren: AudioStreamPlayer = $audio_siren


func active_siren() -> void:
  if play_siren:
    return
  play_siren = true
  audio_siren.play()
  
  for _i in range(20):
    for light in lights.get_children():
      light.visible = not light.visible
      yield(get_tree().create_timer(.2), 'timeout')
      light.visible = not light.visible
  audio_siren.stop()
  
  for light in lights.get_children():
    light.visible = false
