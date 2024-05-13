extends EnemyProjectile

func effect():
	status_manager.add(SpeedEffect.new("Witch_slow", player, 0.5, 3.0))
