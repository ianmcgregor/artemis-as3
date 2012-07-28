package com.gamadu.starwarrior.spatials {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;
	import com.gamadu.starwarrior.components.Expires;
	import com.gamadu.starwarrior.components.Transform;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import org.alwaysinbeta.game.Canvas;



	public class Explosion extends Spatial {
		private var _transform : Transform;
		private var _expires : Expires;
		private var _initialLifeTime : int;
		private var _color : uint;
		private var _radius : int;
		private var _alpha : Number;
		private var _circle : Shape;
		private var _matrix : Matrix;

		public function Explosion(world : World, owner : Entity, radius : int) {
			super(world, owner);
			_radius = radius;
		}

		override public function initalize() : void {
			var transformMapper : ComponentMapper = new ComponentMapper(Transform, _world);
			_transform = transformMapper.get(_owner);

			var expiresMapper : ComponentMapper = new ComponentMapper(Expires, _world);
			_expires = expiresMapper.get(_owner);
			_initialLifeTime = _expires.getLifeTime();

			_color = 0xFFFF00;
			_circle = new Shape();
			_matrix = new Matrix();
		}

		override public function render(g : Canvas) : void {
			_alpha = _expires.getLifeTime() / _initialLifeTime;
			var graphics : Graphics = _circle.graphics;
			graphics.clear();
			graphics.beginFill(_color, _alpha);
			graphics.drawCircle(x, y, _radius * 2);
			graphics.endFill();

			var x : int = _transform.getX() - _radius;
			var y : int = _transform.getY() - _radius;

			_matrix.identity();
			_matrix.translate(x, y);
			
			g.drawHighQuality(_circle, _matrix);
		}
	}
}