package com.gamadu.starwarrior.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.IntervalEntitySystem;
	import com.artemis.utils.IImmutableBag;
	import com.gamadu.starwarrior.EntityFactory;
	import com.gamadu.starwarrior.components.Enemy;
	import com.gamadu.starwarrior.components.Transform;
	import com.gamadu.starwarrior.components.Velocity;
	import com.gamadu.starwarrior.components.Weapon;
	import org.alwaysinbeta.game.GameContainer;


	public class EnemySpawnSystem extends IntervalEntitySystem {
		private var _weaponMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;
		private var _container : GameContainer;

		public function EnemySpawnSystem(interval : int, container : GameContainer) {
			super(interval, [Transform, Weapon, Enemy]);
			_container = container;
		}

		override public function initialize() : void {
			_weaponMapper = new ComponentMapper(Weapon, _world);
			_transformMapper = new ComponentMapper(Transform, _world);
		}

		override protected function processEntities(entities : IImmutableBag) : void {
			entities;
		//	trace("EnemySpawnSystem.processEntities(",entities,")");
			
			var e : Entity = EntityFactory.createEnemyShip(_world);
			
			var x: int = _container.getWidth() * Math.random();
			var y: int = 260 * Math.random() + 30;
			var b: Boolean = Math.random() > 0.5;

			Transform(e.getComponent(Transform)).setLocation(x, y);
			Velocity(e.getComponent(Velocity)).setVelocity(0.05);
			Velocity(e.getComponent(Velocity)).setAngle(b ? 0 : 180);

			e.refresh();
		}
	}
}