package com.gamadu.starwarrior.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.Bag;
	import com.artemis.utils.IImmutableBag;
	import com.gamadu.starwarrior.components.SpatialForm;
	import com.gamadu.starwarrior.components.Transform;
	import com.gamadu.starwarrior.constants.SpatialFormFile;
	import com.gamadu.starwarrior.spatials.EnemyShip;
	import com.gamadu.starwarrior.spatials.Explosion;
	import com.gamadu.starwarrior.spatials.Missile;
	import com.gamadu.starwarrior.spatials.PlayerShip;
	import com.gamadu.starwarrior.spatials.Spatial;
	import org.alwaysinbeta.game.Canvas;
	import org.alwaysinbeta.game.GameContainer;


	public class RenderSystem extends EntityProcessingSystem {
		private var _graphics : Canvas;
		private var _spatials : Bag;
		private var _spatialFormMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;
		private var _container : GameContainer;

		public function RenderSystem(container : GameContainer) {
			super(Transform, [SpatialForm]);
			_container = container;
			_graphics = container.getGraphics();

			_spatials = new Bag();
		}

		override public function initialize() : void {
			_spatialFormMapper = new ComponentMapper(SpatialForm, _world);
			_transformMapper = new ComponentMapper(Transform, _world);
		}

		override protected function processEntities(entities : IImmutableBag) : void {
			// trace("RenderSystem.processEntities(",entities,")");
			super.processEntities(entities);
		}

		override protected function processEntity(e : Entity) : void {
			// trace("RenderSystem.processEntity(",e,")");
			var spatial : Spatial = _spatials.get(e.getId());
			var transform : Transform = _transformMapper.get(e);

			if (transform.getX() >= 0 
				&& transform.getY() >= 0 
				&& transform.getX() < _container.getWidth() 
				&& transform.getY() < _container.getHeight() 
				&& spatial != null) {
				spatial.render(_graphics);
			}
		}

		override protected function added(e : Entity) : void {
			// trace("RenderSystem.added(",e,")");
			var spatial : Spatial = createSpatial(e);
			if (spatial != null) {
				spatial.initalize();
				_spatials.set(e.getId(), spatial);
			}
		}

		override protected function removed(e : Entity) : void {
			_spatials.set(e.getId(), null);
		}

		private function createSpatial(e : Entity) : Spatial {
			// trace("RenderSystem.createSpatial(",e,")");
			var spatialForm : SpatialForm = _spatialFormMapper.get(e);
			var spatialFormFile : String = spatialForm.getSpatialFormFile();
			// trace('spatialFormFile: ' + (spatialFormFile));

			switch(spatialFormFile) {
				case SpatialFormFile.PLAYER_SHIP:
					return new PlayerShip(_world, e);
					break;
				case SpatialFormFile.ENEMY_SHIP:
					return new EnemyShip(_world, e);
					break;
				case SpatialFormFile.MISSILE:
					return new Missile(_world, e);
					break;
				case SpatialFormFile.BULLET_EXPLOSION:
					return new Explosion(_world, e, 10);
					break;
				case SpatialFormFile.SHIP_EXPLOSION:
					return new Explosion(_world, e, 30);
					break;
				default:
					break;
			}

			return null;
		}

		override public function change(e : Entity) : void {
			// trace("RenderSystem.change(",e,")");
			super.change(e);
		}
	}
}