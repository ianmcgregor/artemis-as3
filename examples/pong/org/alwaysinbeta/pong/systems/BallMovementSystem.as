package org.alwaysinbeta.pong.systems {
	import org.alwaysinbeta.pong.components.Rect;
	import org.alwaysinbeta.game.GameContainer;
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	import org.alwaysinbeta.pong.components.Transform;
	import org.alwaysinbeta.pong.components.Velocity;

	/**
	 * @author McFamily
	 */
	public class BallMovementSystem extends EntityProcessingSystem {
		
		private var _transformMapper : ComponentMapper;
		private var _velocityMapper : ComponentMapper;
		private var _container : GameContainer;
		private var _rectMapper : ComponentMapper;

		public function BallMovementSystem(container : GameContainer) {
			_container = container;
			super(Transform, [Velocity, Rect]);
		}
		
		override public function initialize() : void {
			_transformMapper = new ComponentMapper(Transform, _world);
			_velocityMapper = new ComponentMapper(Velocity, _world);
			_rectMapper = new ComponentMapper(Rect, _world);
		}

		override protected function processEntity(e : Entity) : void {
			var transform : Transform = _transformMapper.get(e);
			var velocity : Velocity = _velocityMapper.get(e);
			var rect: Rect = _rectMapper.get(e);

			transform.addX( velocity.velocityX * ( _world.getDelta() * 0.3 ) );
			transform.addY( velocity.velocityY * ( _world.getDelta() * 0.3 ) );

			var maxX : int = _container.getWidth() - rect.rect.width;
			if (transform.x > maxX) transform.x = maxX;
			if (transform.x < 0) transform.x = 0;

			var maxY : int = _container.getHeight() - rect.rect.height;
			if (transform.y < 0) transform.y = 0;
			if (transform.y > maxY) transform.y =maxY;

			if (transform.x >= maxX || transform.x <= 0) {
				velocity.velocityX *= -1;
			}
			
			if (transform.y >= maxY || transform.y <= 0) {
				velocity.velocityY *= -1;
			}
			
			var minVelocity: Number = 0.4;
			if (velocity.velocityY < 0 && velocity.velocityY > -minVelocity) velocity.velocityY = -minVelocity;
			if (velocity.velocityY > 0 && velocity.velocityY < minVelocity) velocity.velocityY = minVelocity;
			if(velocity.velocityY > 1) velocity.velocityY = 1;
			if (velocity.velocityY < -1) velocity.velocityY = -1;
		}
	}
}
