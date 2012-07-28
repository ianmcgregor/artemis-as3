package com.gamadu.starwarrior.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.gamadu.starwarrior.EntityFactory;
	import com.gamadu.starwarrior.components.Enemy;
	import com.gamadu.starwarrior.components.Transform;
	import com.gamadu.starwarrior.components.Velocity;
	import com.gamadu.starwarrior.components.Weapon;

	import flash.utils.getTimer;

	public class EnemyShooterSystem extends EntityProcessingSystem {
		private var _weaponMapper : ComponentMapper;
		private var _now : int;
		private var _transformMapper : ComponentMapper;

		public function EnemyShooterSystem() {
			super(Transform, [Weapon, Enemy]);
		}

		override public function initialize() : void {
			_weaponMapper = new ComponentMapper(Weapon, _world);
			_transformMapper = new ComponentMapper(Transform, _world);
		}

		override protected function begin() : void {
			_now = getTimer();
		}

		override protected function processEntity(e : Entity) : void {
			var weapon : Weapon = _weaponMapper.get(e);

			if (weapon.getShotAt() + 2000 < _now) {
				var transform : Transform = _transformMapper.get(e);

				var missile : Entity = EntityFactory.createMissile(_world);
				Transform(missile.getComponent(Transform)).setLocation(transform.getX(), transform.getY() + 20);
				Velocity(missile.getComponent(Velocity)).setVelocity(-0.5);
				Velocity(missile.getComponent(Velocity)).setAngle(270);
				missile.refresh();

				weapon.setShotAt(_now);
			}
		}
	}
}