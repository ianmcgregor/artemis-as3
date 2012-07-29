package org.alwaysinbeta.pong.systems {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.EntityProcessingSystem;
	import flash.ui.Keyboard;
	import org.alwaysinbeta.game.GameContainer;
	import org.alwaysinbeta.game.IKeyListener;
	import org.alwaysinbeta.game.Input;
	import org.alwaysinbeta.pong.components.Player;
	import org.alwaysinbeta.pong.components.Transform;



	/**
	 * @author McFamily
	 */
	public class PlayerControlSystem extends EntityProcessingSystem implements IKeyListener {
		private var _container : GameContainer;
		private var _transformMapper : ComponentMapper;
		private var _moveUp : Boolean;
		private var _moveDown : Boolean;
		public function PlayerControlSystem(container : GameContainer) {
			super(Transform, [Player]);
			_container = container;
		}
		
		override public function initialize() : void {
			_transformMapper = new ComponentMapper(Transform, _world);
			_container.getInput().addKeyListener(this);
		}
		
		override protected function processEntity(e : Entity) : void {
			var transform : Transform = _transformMapper.get(e);

			if (_moveUp) {
				transform.addY(_world.getDelta() * -0.3);
			}
			if (_moveDown) {
				transform.addY(_world.getDelta() * 0.3);
			}
			// clamp
			if (transform.y < 0) {
				transform.y = 0;
			} else if(transform.y > _container.getHeight() - 60) {
				transform.y = _container.getHeight() - 60;
			}
		}
		
		
		// input

		public function keyPressed(key : uint, c : String) : void {
			switch(key){
				case Keyboard.W:
					_moveUp = true;
					_moveDown = false;
					break;
				case Keyboard.S:
					_moveDown = true;
					_moveUp = false;
					break;
				default:
			}
		}

		public function keyReleased(key : uint, c : String) : void {
			switch(key){
				case Keyboard.W:
					_moveUp = false;
					break;
				case Keyboard.S:
					_moveDown = false;
					break;
				default:
			}
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
