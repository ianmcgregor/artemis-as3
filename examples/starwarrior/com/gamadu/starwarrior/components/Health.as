package com.gamadu.starwarrior.components {
	import com.artemis.Component;

	public class Health extends Component {
		private var health : Number;
		private var maximumHealth : Number;

		public function Health(health : Number) {
			this.health = this.maximumHealth = health;
		}

		public function getHealth() : Number {
			return health;
		}

		public function getMaximumHealth() : Number {
			return maximumHealth;
		}

		public function getHealthPercentage() : int {
			return Math.round(health / maximumHealth * 100);
		}

		public function addDamage(damage : int) : void {
			health -= damage;
			if (health < 0)
				health = 0;
		}

		public function isAlive() : Boolean {
			return health > 0;
		}
	}
}