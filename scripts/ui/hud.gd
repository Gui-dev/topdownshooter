extends CanvasLayer
class_name HUD


onready var weapon_name_label: Label = $ui_game_player/weapon/weapon_name
onready var ammo_label: Label = $ui_game_player/weapon/ammo
onready var max_ammo_label: Label = $ui_game_player/weapon/max_ammo


func ui_update_weapon(weapon_name: String, ammo: int, max_ammo: int) -> void:
  weapon_name_label.text = weapon_name
  ammo_label.text = str(ammo)
  max_ammo_label.text = str(max_ammo)
