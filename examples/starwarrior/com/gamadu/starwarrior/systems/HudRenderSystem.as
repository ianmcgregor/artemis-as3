package com.gamadu.starwarrior.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.artemis.utils.IImmutableBag;
	import com.gamadu.starwarrior.components.Health;
	import com.gamadu.starwarrior.components.Player;
	import flash.display.BitmapData;
	import org.alwaysinbeta.starwarrior.Canvas;
	import org.alwaysinbeta.starwarrior.GameContainer;
	import org.alwaysinbeta.starwarrior.TextStamp;


	public class HudRenderSystem extends EntityProcessingSystem {
		private var _container : GameContainer;
		private var _g : Canvas;
		private var _healthMapper : ComponentMapper;

		public function HudRenderSystem(container : GameContainer) {
			super(Health, [Player]);
			_container = container;
			_g = container.getGraphics();
		}

		override public function initialize() : void {
			_healthMapper = new ComponentMapper(Health, _world);
		}
		
		override protected function processEntities(entities : IImmutableBag) : void {
//			trace("HudRenderSystem.processEntities(",entities, entities.size(),")");
			super.processEntities(entities);
		}

		override protected function processEntity(e : Entity) : void {
//			trace("HudRenderSystem.processEntity(",e,")");
			var health : Health = _healthMapper.get(e);

			var bitmapData : BitmapData = TextStamp.getBitmapData("Health: " + health.getHealthPercentage() + "%");
			_g.blit(bitmapData, 2, _container.getHeight() - 16);
		}
	}
}