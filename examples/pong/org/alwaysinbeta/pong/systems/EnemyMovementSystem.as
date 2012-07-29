package org.alwaysinbeta.pong.systems {
	import org.alwaysinbeta.pong.components.Velocity;
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;

	import org.alwaysinbeta.game.GameContainer;
	import org.alwaysinbeta.pong.components.Enemy;
	import org.alwaysinbeta.pong.components.Transform;
	import org.alwaysinbeta.pong.constants.EntityTag;

	/**
	 * @author McFamily
	 */
	public class EnemyMovementSystem extends EntityProcessingSystem {
		private var _container : GameContainer;
		private var _transformMapper : ComponentMapper;
		private var _velocityMapper : ComponentMapper;
		private var _moveTo : int = -1;
		
		public function EnemyMovementSystem(container : GameContainer) {
			super(Transform, [Enemy]);
			_container = container;
		}
		
		override public function initialize() : void {
			_transformMapper = new ComponentMapper(Transform, _world);
			_velocityMapper = new ComponentMapper(Velocity, _world);
		}
		
		override protected function processEntity(e : Entity) : void {
			var transform : Transform = _transformMapper.get(e);

			var ball : Entity = _world.getTagManager().getEntity(EntityTag.BALL);
			var ballTransform : Transform = _transformMapper.get(ball);
			var ballVelocity : Velocity = _velocityMapper.get(ball);
			var ballApproaching : Boolean = ballVelocity.velocityX > 0;
			
			var moveUp : Boolean;
			var moveDown : Boolean;

			if(ballApproaching){
				_moveTo = -1;
				moveUp = ballTransform.y < transform.y - 10;
				moveDown = ballTransform.y > transform.y + 10;
			} else if(ballTransform.x < _container.getWidth() - 200) {
				if( _moveTo == -1) {
					_moveTo = 100 + int(280 * Math.random());
				}
				moveUp = _moveTo < transform.y - 10;
				moveDown = _moveTo > transform.y + 10;
			}
			
			if (moveUp) {
				transform.addY(_world.getDelta() * -0.3);
			} else if(moveDown) {
				transform.addY(_world.getDelta() * 0.3);
			}
			// clamp
			if (transform.y < 0) {
				transform.y = 0;
			} else if(transform.y > _container.getHeight() - 60) {
				transform.y = _container.getHeight() - 60;
			}
		}
	}
}
