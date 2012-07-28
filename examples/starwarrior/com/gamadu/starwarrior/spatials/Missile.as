package com.gamadu.starwarrior.spatials {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;
	import com.gamadu.starwarrior.components.Transform;

	import flash.geom.Rectangle;

	import org.alwaysinbeta.starwarrior.Canvas;

	public class Missile extends Spatial {
		private var _transform : Transform;
		private const _rect : Rectangle = new Rectangle(0, 0, 2, 6);

		public function Missile(world : World, owner : Entity) {
			super(world, owner);
		}

		override public function initalize() : void {
			var transformMapper : ComponentMapper = new ComponentMapper(Transform, _world);
			_transform = transformMapper.get(_owner);
		}

		override public function render(g : Canvas) : void {
			_rect.x = _transform.getX() - 1;
			_rect.y = _transform.getY() - 3;
			g.fillRect(_rect, 0xffffffff);
		}
	}
}