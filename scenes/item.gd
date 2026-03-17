class_name Item

var name: String
var icon: Texture2D
var value: int

var speed_mod: float
var zone_mod: float

var description: String

func _init(n, i, v, s := 0.0, z := 0.0, d := ""):
	name = n
	icon = i
	value = v
	speed_mod = s
	zone_mod = z
	description = d
