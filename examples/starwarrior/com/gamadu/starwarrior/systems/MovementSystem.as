package com.gamadu.starwarrior.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.gamadu.starwarrior.components.Transform;
	import com.gamadu.starwarrior.components.Velocity;

	import org.alwaysinbeta.starwarrior.GameContainer;

	public class MovementSystem extends EntityProcessingSystem {
		private var _container : GameContainer;
		private var _velocityMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;

		public function MovementSystem(container : GameContainer) {
			super(Transform, [Velocity]);
			_container = container;
		}

		override public function initialize() : void {
			_velocityMapper = new ComponentMapper(Velocity, _world);
			_transformMapper = new ComponentMapper(Transform, _world);
		}

		override protected function processEntity(e : Entity) : void {
			var velocity : Velocity = _velocityMapper.get(e);
			var v : Number = velocity.getVelocity();

			var transform : Transform = _transformMapper.get(e);

			var r : Number = velocity.getAngleAsRadians();

//			var xn : Number = transform.getX() + (TrigLUT.cos(r) * v * world.getDelta());
//			var yn : Number = transform.getY() + (TrigLUT.sin(r) * v * world.getDelta());
			var xn : Number = transform.getX() + (Math.cos(r) * v * _world.getDelta());
			var yn : Number = transform.getY() + (Math.sin(r) * v * _world.getDelta());

			transform.setLocation(xn, yn);
		}
	}
}