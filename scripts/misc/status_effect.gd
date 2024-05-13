extends Node
class_name StatusEffect

var status_name
var player
var duration = 0.0

func _init(status_name, target, time = 1.0):
	self.status_name = status_name
	player = target
	duration = time

func update(delta) -> int:
	duration -= delta
	if duration <= 0:
		remove(delta)
		return 1
	else:
		effect(delta)
		return 0

func effect(delta):
	pass

func remove(delta):
	pass
