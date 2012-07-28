package com.gamadu.starwarrior.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntitySystem;
	import com.artemis.utils.IImmutableBag;
	import com.gamadu.starwarrior.EntityFactory;
	import com.gamadu.starwarrior.components.Health;
	import com.gamadu.starwarrior.components.Transform;
	import com.gamadu.starwarrior.components.Velocity;
	import com.gamadu.starwarrior.constants.EntityGroup;

	public class CollisionSystem extends EntitySystem {
		private var _transformMapper : ComponentMapper;
		private var _velocityMapper : ComponentMapper;
		private var _healthMapper : ComponentMapper;

		public function CollisionSystem() {
			super([Transform]);
		}

		override public function initialize() : void {
			_transformMapper = new ComponentMapper(Transform, _world);
			_velocityMapper = new ComponentMapper(Velocity, _world);
			_healthMapper = new ComponentMapper(Health, _world);
		}

		override protected function processEntities(entities : IImmutableBag) : void {
			entities;
			
			var bullets : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.BULLETS);
			var ships : IImmutableBag = _world.getGroupManager().getEntities(EntityGroup.SHIPS);

			if (bullets != null && ships != null) {
				shipLoop:
				for (var a : int = 0; ships.size() > a; a++) {
					var ship : Entity = ships.get(a);
					for (var b : int = 0; bullets.size() > b; b++) {
						var bullet : Entity = bullets.get(b);

						if (collisionExists(bullet, ship)) {
							var tb : Transform = _transformMapper.get(bullet);
							EntityFactory.createBulletExplosion(_world, tb.getX(), tb.getY()).refresh();
//							trace('world.deleteEntity(bullet);: ');
							_world.deleteEntity(bullet);

							var health : Health = _healthMapper.get(ship);
							health.addDamage(4);

							if (!health.isAlive()) {
								var transform : Transform = _transformMapper.get(ship);

								EntityFactory.createShipExplosion(_world, transform.getX(), transform.getY()).refresh();

//								trace('world.deleteEntity(ship);: ');
								_world.deleteEntity(ship);
								continue shipLoop;
							}
						}
					}
				}
			}
		}

		private function collisionExists(e1 : Entity, e2 : Entity) : Boolean {
			var t1 : Transform = _transformMapper.get(e1);
			var t2 : Transform = _transformMapper.get(e2);
			return t1.getDistanceTo(t2) < 15;
		}

		override protected function checkProcessing() : Boolean {
			return true;
		}
	}
}