extends StaticBody2D
class_name Rotate_Weapon

var rotation_angle : float = 0.0
var rotation_speed: float = 80.0   #公转速度
var orbit_radius: float = 30.0   #半径大小
var player: Player

var weapon_num : int = 3 #武器数量
var base_damage : int = 50
var current_damage : int
var weapon_array : Array = []

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var attack_shape: Area2D = $AttackShape
@onready var weapon_0: Node2D = $weapon_0

func _ready():
	add_to_group("weapon")
	current_damage = base_damage
	copy_weapon()

func _physics_process(delta: float) -> void:
	control_weapon(delta)
	pass
	#print("player position: ", player.position, "rotate_weapon_position: ", position)

func copy_weapon():
	weapon_array.append(weapon_0)
	for i in (weapon_num - 1):
		var copyed_weapon = weapon_0.duplicate()
		copyed_weapon.position = Vector2.ZERO
		copyed_weapon.name = "weapon_%d" % (i + 1)
		weapon_array.append(copyed_weapon)
		add_child(copyed_weapon)

func control_weapon(delta : float):
	var gap_angle = 2 * PI / weapon_num as float
	var angle = deg_to_rad(rotation_angle)
	for i in weapon_array.size():
		angle += gap_angle
		var offset = Vector2(cos(angle), sin(angle)) * orbit_radius
		weapon_array[i].position = player.position + offset
	rotation_angle += rotation_speed * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	#print("enter")
	pass
	
