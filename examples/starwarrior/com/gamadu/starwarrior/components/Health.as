package com.gamadu.starwarrior.components {
	import com.artemis.Component;

	public class Health extends Component {
		private var _health : Number;
		private var _maximumHealth : Number;

		public function Health(health : Number) {
			_health = _maximumHealth = health;
		}

		public function getHealth() : Number {
			return _health;
		}

		public function getMaximumHealth() : Number {
			return _maximumHealth;
		}

		public function getHealthPercentage() : int {
			return Math.round(_health / _maximumHealth * 100);
		}

		public function addDamage(damage : int) : void {
			_health -= damage;
			if (_health < 0)
				_health = 0;
		}

		public function isAlive() : Boolean {
			return _health > 0;
		}
	}
}