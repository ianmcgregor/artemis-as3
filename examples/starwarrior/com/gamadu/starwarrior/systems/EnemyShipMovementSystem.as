package com.gamadu.starwarrior.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.gamadu.starwarrior.components.Enemy;
	import com.gamadu.starwarrior.components.Transform;
	import com.gamadu.starwarrior.components.Velocity;
	import org.alwaysinbeta.starwarrior.GameContainer;

	public class EnemyShipMovementSystem extends EntityProcessingSystem {
		private var _container : GameContainer;
		private var _transformMapper : ComponentMapper;
		private var _velocityMapper : ComponentMapper;

		public function EnemyShipMovementSystem(container : GameContainer) {
			super(Transform, [Enemy, Velocity]);
			_container = container;
		}

		override public function initialize() : void {
			_transformMapper = new ComponentMapper(Transform, _world);
			_velocityMapper = new ComponentMapper(Velocity, _world);
		}

		override protected function processEntity(e : Entity) : void {
			//trace("EnemyShipMovementSystem.processEntity(",e,")");
			var transform : Transform = _transformMapper.get(e);
			var velocity : Velocity = _velocityMapper.get(e);

			if (transform.getX() > _container.getWidth() || transform.getX() < 0) {
				velocity.addAngle(180);
			}
		}
	}
}