extends KinematicBody2D
class_name ZombieSkeleton


const Blood = preload('res://scenes/prefabs/blood.tscn')

func _ready() -> void:
  pass


func _blink() -> void:
  modulate = Color.red
  yield(get_tree().create_timer(.2), 'timeout')
  modulate = Color.white


func _death() -> void:
  get_parent().get_node('HUD').ui_winner()
  var blood = Blood.instance()
  get_node('../../').zombies_death += 1
  get_node('../../HUD').ui_update_zombie_death()
  get_node('../../content').add_child(blood)
  blood.global_position = global_position
  blood.global_rotation = global_rotation
  queue_free()
