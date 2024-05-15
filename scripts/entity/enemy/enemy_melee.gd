extends Enemy

@onready var cooldown = $Cooldown
@export var atk_speed: float = 1.0
@export var atk_range: float = 1.5
var can_attack = true

func more_onready():
	cooldown.timeout.connect(cooldown_timeout)

func act():
	var distance = global_position.distance_to(player.global_position)
	if distance < atk_range:
		dir = Vector3.ZERO
		if can_attack:
			attack()

func attack():
	can_attack = false
	cooldown.start(1.0/atk_speed)
	global_funcs.shake_camera(20,10,10)

func cooldown_timeout():
	can_attack = true
