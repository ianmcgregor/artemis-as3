package org.alwaysinbeta.pong.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;

	import org.alwaysinbeta.pong.components.Rect;
	import org.alwaysinbeta.pong.components.Transform;
	import org.alwaysinbeta.pong.components.Velocity;
	import org.alwaysinbeta.pong.constants.EntityTag;

	/**
	 * @author McFamily
	 */
	public class CollisionSystem extends EntityProcessingSystem {
		private var _transformMapper : ComponentMapper;
		private var _velocityMapper : ComponentMapper;
		private var _rectMapper : ComponentMapper;
		public function CollisionSystem() {
			super(Transform, [Rect]);
		}
		
		override public function initialize() : void {
			_transformMapper = new ComponentMapper(Transform, _world);
			_velocityMapper = new ComponentMapper(Velocity, _world);
			_rectMapper = new ComponentMapper(Rect, _world);
		}
		
		override protected function processEntities(entities : IImmutableBag) : void {
			entities;
			
			var ball : Entity = _world.getTagManager().getEntity(EntityTag.BALL);
			var player : Entity = _world.getTagManager().getEntity(EntityTag.PLAYER);
			var enemy : Entity = _world.getTagManager().getEntity(EntityTag.ENEMY);
			var ballVelocity: Velocity = _velocityMapper.get(ball);
			var ballTransform : Transform = _transformMapper.get(ball);
			if(ballVelocity.velocityX < 0 && collisionExists(ball, player)){
				var playerTransform : Transform = _transformMapper.get(player);
				updateBallVelocity(ballVelocity, ballTransform, playerTransform);
			} 
			else if(ballVelocity.velocityX > 0 && collisionExists(ball, enemy)){
				var enemyTransform : Transform = _transformMapper.get(enemy);
				updateBallVelocity(ballVelocity, ballTransform, enemyTransform);
			}
		}

		private function updateBallVelocity(ballVelocity : Velocity, ballTransform : Transform, playerTransform : Transform) : void {
			ballVelocity.velocityX *= -1;
			ballVelocity.velocityY = map(ballTransform.y - playerTransform.y, -20, 60, -1, 1);
//			var minVelocity: Number = 0.4;
//			if (ballVelocity.velocityY < 0 && ballVelocity.velocityY > -minVelocity) ballVelocity.velocityY = -minVelocity;
//			if (ballVelocity.velocityY > 0 && ballVelocity.velocityY < minVelocity) ballVelocity.velocityY = minVelocity;
//			if(ballVelocity.velocityY > 1) ballVelocity.velocityY = 1;
//			if(ballVelocity.velocityY < -1) ballVelocity.velocityY = -1;
		}
		
		private function map(v:Number, a:Number, b:Number, x:Number = 0, y:Number = 1):Number {
		    return (v == a) ? x : (v - a) * (y - x) / (b - a) + x;
		}
		
		private function collisionExists(e1 : Entity, e2 : Entity) : Boolean {
			var t1 : Transform = _transformMapper.get(e1);
			var t2 : Transform = _transformMapper.get(e2);
			var r1 : Rect = _rectMapper.get(e1);
			var r2 : Rect = _rectMapper.get(e2);
			
			r1.rect.x = t1.x;
			r1.rect.y = t1.y;
			
			r2.rect.x = t2.x;
			r2.rect.y = t2.y;
			
			return r1.rect.intersects(r2.rect);
		}
	}
}
