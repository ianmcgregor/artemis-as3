package com.gamadu.starwarrior.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.gamadu.starwarrior.components.Expires;

	public class ExpirationSystem extends EntityProcessingSystem {
		private var _expiresMapper : ComponentMapper;

		public function ExpirationSystem() {
			super(Expires,  []);
		}

		override public function initialize() : void {
			_expiresMapper = new ComponentMapper(Expires, _world);
		}

		override protected function processEntity(e : Entity) : void {
			var expires : Expires = _expiresMapper.get(e);
			expires.reduceLifeTime(_world.getDelta());

			if (expires.isExpired()) {
				_world.deleteEntity(e);
			}
		}
	}
}