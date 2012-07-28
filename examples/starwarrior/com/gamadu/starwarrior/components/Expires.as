package com.gamadu.starwarrior.components {
	import com.artemis.Component;

	public class Expires extends Component {
		private var lifeTime : int;

		public function Expires(lifeTime : int) {
			this.lifeTime = lifeTime;
		}

		public function getLifeTime() : int {
			return lifeTime;
		}

		public function setLifeTime(lifeTime : int) : void {
			this.lifeTime = lifeTime;
		}

		public function reduceLifeTime(lifeTime : int) : void {
			this.lifeTime -= lifeTime;
		}

		public function isExpired() : Boolean {
			return lifeTime <= 0;
		}
	}
}