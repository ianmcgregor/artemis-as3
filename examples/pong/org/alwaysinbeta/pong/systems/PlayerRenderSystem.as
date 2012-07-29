package org.alwaysinbeta.pong.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.Bag;
	import com.artemis.utils.IImmutableBag;

	import org.alwaysinbeta.game.Canvas;
	import org.alwaysinbeta.game.GameContainer;
	import org.alwaysinbeta.pong.components.Player;
	import org.alwaysinbeta.pong.components.Transform;
	import org.alwaysinbeta.pong.spatials.Paddle;
	import org.alwaysinbeta.pong.spatials.Spatial;


	public class PlayerRenderSystem extends EntityProcessingSystem {
		private var _graphics : Canvas;
		private var _spatials : Bag;
		private var _transformMapper : ComponentMapper;
		private var _container : GameContainer;

		public function PlayerRenderSystem(container : GameContainer) {
			super(Transform, [Player]);
			_container = container;
			_graphics = container.getGraphics();

			_spatials = new Bag();
		}

		override public function initialize() : void {
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

			if (transform.y >= 0 
				&& transform.y <= _container.getHeight()
				&& spatial != null) {
				spatial.render(_graphics);
			}
		}

		override protected function added(e : Entity) : void {
			var spatial : Spatial = new Paddle(_world, e);
			spatial.initalize();
			_spatials.set(e.getId(), spatial);
		}

		override protected function removed(e : Entity) : void {
			_spatials.set(e.getId(), null);
		}

		override public function change(e : Entity) : void {
			super.change(e);
		}
	}
}