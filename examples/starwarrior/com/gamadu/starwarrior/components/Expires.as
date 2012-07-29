package com.gamadu.starwarrior.components {
	import com.artemis.Component;

	public class Expires extends Component {
		private var _lifeTime : int;

		public function Expires(lifeTime : int) {
			_lifeTime = lifeTime;
		}

		public function getLifeTime() : int {
			return _lifeTime;
		}

		public function setLifeTime(lifeTime : int) : void {
			_lifeTime = lifeTime;
		}

		public function reduceLifeTime(lifeTime : int) : void {
			_lifeTime -= lifeTime;
		}

		public function isExpired() : Boolean {
			return _lifeTime <= 0;
		}
	}
}