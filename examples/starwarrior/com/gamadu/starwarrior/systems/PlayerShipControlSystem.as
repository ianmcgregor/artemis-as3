package com.gamadu.starwarrior.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import com.gamadu.starwarrior.EntityFactory;
	import com.gamadu.starwarrior.components.Player;
	import com.gamadu.starwarrior.components.Transform;
	import com.gamadu.starwarrior.components.Velocity;
	import flash.ui.Keyboard;
	import org.alwaysinbeta.game.GameContainer;
	import org.alwaysinbeta.game.Input;

	public class PlayerShipControlSystem extends EntityProcessingSystem implements IKeyListener {
		private var _container : GameContainer;
		private var _moveRight : Boolean;
		private var _moveLeft : Boolean;
		private var _shoot : Boolean;
		private var _transformMapper : ComponentMapper;

		public function PlayerShipControlSystem(container : GameContainer) {
			super(Transform, [Player]);
			_container = container;
		}

		override public function initialize() : void {
			_transformMapper = new ComponentMapper(Transform, _world);
			_container.getInput().addKeyListener(this);
		}

		override protected function processEntity(e : Entity) : void {
			var transform : Transform = _transformMapper.get(e);

			//trace('moveLeft: ' + (moveLeft));
			if (_moveLeft) {
				transform.addX(_world.getDelta() * -0.3);
			}
			if (_moveRight) {
				transform.addX(_world.getDelta() * 0.3);
			}

			if (_shoot) {
				var missile : Entity = EntityFactory.createMissile(_world);
				Transform(missile.getComponent(Transform)).setLocation(transform.getX(), transform.getY() - 20);
				Velocity(missile.getComponent(Velocity)).setVelocity(-0.5);
				Velocity(missile.getComponent(Velocity)).setAngle(90);
				missile.refresh();

				_shoot = false;
			}
		}

		public function keyPressed(key : uint, c : String) : void {
			switch(key){
				case Keyboard.A:
				case Keyboard.LEFT:
					_moveLeft = true;
					_moveRight = false;
					break;
				case Keyboard.D:
				case Keyboard.RIGHT:
					_moveRight = true;
					_moveLeft = false;
					break;
				case Keyboard.SPACE:
					_shoot = true;
					break;
				default:
			}
			
//			if (key == Keyboard.A || key == Keyboard.LEFT) {
//				_moveLeft = true;
//				_moveRight = false;
//			} else if (key == Keyboard.D || key == Keyboard.RIGHT) {
//				_moveRight = true;
//				_moveLeft = false;
//			} else if (key == Keyboard.SPACE) {
//				_shoot = true;
//			}
		}

		public function keyReleased(key : uint, c : String) : void {
			switch(key){
				case Keyboard.A:
				case Keyboard.LEFT:
					_moveLeft = false;
					break;
				case Keyboard.D:
				case Keyboard.RIGHT:
					_moveRight = false;
					break;
				case Keyboard.SPACE:
					_shoot = false;
					break;
				default:
			}
			
//			if (key == Keyboard.A || key == Keyboard.LEFT) {
//				_moveLeft = false;
//			} else if (key == Keyboard.D || key == Keyboard.RIGHT) {
//				_moveRight = false;
//			} else if (key == Keyboard.SPACE) {
//				_shoot = false;
//			}
		}

		public function inputEnded() : void {
		}

		public function inputStarted() : void {
		}

		public function isAcceptingInput() : Boolean {
			return true;
		}

		public function setInput(input : Input) : void {
		}
	}
}