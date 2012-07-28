package com.gamadu.starwarrior {
	import com.gamadu.starwarrior.constants.SpatialFormFile;
	import com.gamadu.starwarrior.constants.EntityGroup;
	import com.artemis.Entity;
	import com.artemis.World;
	import com.gamadu.starwarrior.components.Enemy;
	import com.gamadu.starwarrior.components.Expires;
	import com.gamadu.starwarrior.components.Health;
	import com.gamadu.starwarrior.components.SpatialForm;
	import com.gamadu.starwarrior.components.Transform;
	import com.gamadu.starwarrior.components.Velocity;
	import com.gamadu.starwarrior.components.Weapon;

	public class EntityFactory {
		public static function createMissile(world : World) : Entity {
			var missile : Entity = world.createEntity();
			missile.setGroup(EntityGroup.BULLETS);

			missile.addComponent(new Transform());
			missile.addComponent(new SpatialForm(SpatialFormFile.MISSILE));
			missile.addComponent(new Velocity());
			missile.addComponent(new Expires(2000));

			return missile;
		}

		public static function createEnemyShip(world : World) : Entity {
			var e : Entity = world.createEntity();
			e.setGroup(EntityGroup.SHIPS);

			e.addComponent(new Transform());
			e.addComponent(new SpatialForm(SpatialFormFile.ENEMY_SHIP));
			e.addComponent(new Health(10));
			e.addComponent(new Weapon());
			e.addComponent(new Enemy());
			e.addComponent(new Velocity());

			return e;
		}

		public static function createBulletExplosion(world : World, x : Number, y : Number) : Entity {
			var e : Entity = world.createEntity();

			e.setGroup(EntityGroup.EFFECTS);

			e.addComponent(new Transform(x, y));
			e.addComponent(new SpatialForm(SpatialFormFile.BULLET_EXPLOSION));
			e.addComponent(new Expires(1000));

			return e;
		}

		public static function createShipExplosion(world : World, x : Number, y : Number) : Entity {
			var e : Entity = world.createEntity();

			e.setGroup(EntityGroup.EFFECTS);

			e.addComponent(new Transform(x, y));
			e.addComponent(new SpatialForm(SpatialFormFile.SHIP_EXPLOSION));
			e.addComponent(new Expires(1000));

			return e;
		}
	}
}