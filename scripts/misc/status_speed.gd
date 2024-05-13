extends StatusEffect
class_name SpeedEffect

var speed_rate
var player_speed
var is_affected = false

func _init(status_name, target, speed_rate = 1.0, time = 1.0):
	super._init(status_name, target, time)
	self.speed_rate = speed_rate
	player_speed = player.sRate

func effect(delta):
	if !is_affected:
		player.sRate *= speed_rate
		is_affected = true
	pass

func remove(delta):
	player.sRate /= speed_rate
	pass
	
