extends Node
class_name StatusEffectManager

var status_effect_list = Array()

func _process(delta):
	for status in status_effect_list:
		var remove_signal = status.update(delta)
		if remove_signal == 1:
			status_effect_list.erase(status)

func add(status_effect):
	var new_status = true
	for status in status_effect_list:
		if status.status_name == status_effect.status_name:
			status = status_effect
			new_status = false
	
	if new_status:
		status_effect_list.append(status_effect)
