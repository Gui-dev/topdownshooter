extends Node2D
class_name WeaponController


export(Resource) var pistol = null
export(Resource) var rifle = null


func _process(delta: float) -> void:
  if Input.is_physical_key_pressed(KEY_1):
    get_parent().weapon = pistol
  elif Input.is_physical_key_pressed(KEY_2):
    get_parent().weapon = rifle
