extends Resource
class_name Weapon


export(String) var name = ''
export(int) var ammo = 0
export(int) var capacity = 0
export(int) var max_ammo = 0
export(int) var strong = 1
export(float) var cooldown = 0.0
export(int) var shake = 35
export(AudioStream) var shoot = null
export(AudioStream) var reload = null
export(AudioStream) var empty = null


func _ready() -> void:
  pass
