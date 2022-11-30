extends Node

const Boss: PackedScene = null # preload('res://scenes/enemies/zombie_boss.tscn')
var zombies_death: int = 0 setget _set_get
var total_zombies: int = 0
onready var zombies: Node2D = $zombies


func _ready() -> void:
  total_zombies = zombies.get_child_count()


func _set_get(value: int) -> void:
  zombies_death = value
  if zombies_death >= total_zombies:
    print('Boss apareceu')
    pass
#    var boss = Boss.instance()
#    boss.global_position = get_node('spawn_boss').global_position
#    add_child(boss)  
