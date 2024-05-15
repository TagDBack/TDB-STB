extends EnemyProjectile

func effect():
	status_manager.add(Dot.new("Hela_dot", player, 1, 0.5, 5.0))
