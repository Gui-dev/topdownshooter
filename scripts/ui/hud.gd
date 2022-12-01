extends CanvasLayer
class_name HUD


onready var hp: ProgressBar = $ui_game_player/player/hp
onready var weapon_name_label: Label = $ui_game_player/weapon/weapon_name
onready var ammo_label: Label = $ui_game_player/weapon/ammo
onready var max_ammo_label: Label = $ui_game_player/weapon/max_ammo
onready var death: Label = $ui_game_player/zoombies/death
onready var life: Label = $ui_game_player/zoombies/life
onready var winner: Control = $ui_game_player/winner


func _ready() -> void:
  yield(get_tree(), 'idle_frame')
  life.text = str(get_node('../').total_zombies)


func ui_update_health(health) -> void:
  hp.value = health


func ui_update_weapon(weapon_name: String, ammo: int, max_ammo: int) -> void:
  weapon_name_label.text = weapon_name
  ammo_label.text = str(ammo)
  max_ammo_label.text = str(max_ammo)


func ui_update_zombie_death() -> void:
  death.text = str(get_node('../').zombies_death)


func ui_winner() -> void:
  winner.visible = true
