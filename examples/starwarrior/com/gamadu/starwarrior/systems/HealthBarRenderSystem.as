package com.gamadu.starwarrior.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;
	import com.gamadu.starwarrior.components.Health;
	import com.gamadu.starwarrior.components.Transform;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import org.alwaysinbeta.game.Canvas;
	import org.alwaysinbeta.game.GameContainer;


	public class HealthBarRenderSystem extends EntityProcessingSystem {
		private var _container : GameContainer;
		private var _g : Canvas;
		private var _healthMapper : ComponentMapper;
		private var _transformMapper : ComponentMapper;
		private var _bitmapData : BitmapData;
		private var _rect : Rectangle;

		public function HealthBarRenderSystem(container : GameContainer) {
			super(Health, [Transform]);
			this._container = container;
		}

		override public function initialize() : void {
			_healthMapper = new ComponentMapper(Health, _world);
			_transformMapper = new ComponentMapper(Transform, _world);
			_bitmapData = new BitmapData(52, 4);
			_rect = new Rectangle(1, 1, 50, 2);
			_g = _container.getGraphics();
		}
		
		override protected function processEntities(entities : IImmutableBag) : void {
//			trace("HealthBarRenderSystem.processEntities(",entities,entities.size(),")");
			super.processEntities(entities);
		}

		override protected function processEntity(e : Entity) : void {
//			trace("HealthBarRenderSystem.processEntity(",e,")");
			var health : Health = _healthMapper.get(e);
			var transform : Transform = _transformMapper.get(e);
			
			_bitmapData.fillRect(_bitmapData.rect, 0xff333333);
			_rect.width = health.getHealthPercentage() * 0.5;
			_bitmapData.fillRect(_rect, 0xffff0000);
			_g.blit(_bitmapData, transform.getX() - 10, transform.getY() - 20);
		}
	}
}