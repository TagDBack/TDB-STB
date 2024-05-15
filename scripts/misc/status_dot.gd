extends StatusEffect
class_name Dot

var damage
var rate
var timer = 0

func _init(status_name, target, damage = 1.0, rate = 1.0, time = 1.0):
	super._init(status_name, target, time)
	self.damage = damage
	self.rate = rate

func effect(delta):
	timer += delta
	if timer >= rate:
		timer = 0
		#print("take dot")

func remove(delta):
	print("dot done")
