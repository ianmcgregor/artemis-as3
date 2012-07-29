package {
	import org.alwaysinbeta.pong.systems.EnemyMovementSystem;
	import org.alwaysinbeta.pong.components.Rect;
	import com.artemis.Entity;
	import com.artemis.EntitySystem;
	import com.artemis.SystemManager;
	import com.artemis.World;

	import org.alwaysinbeta.debug.Monitor;
	import org.alwaysinbeta.game.BasicGame;
	import org.alwaysinbeta.game.Canvas;
	import org.alwaysinbeta.game.GameContainer;
	import org.alwaysinbeta.pong.components.Enemy;
	import org.alwaysinbeta.pong.components.Player;
	import org.alwaysinbeta.pong.components.Transform;
	import org.alwaysinbeta.pong.components.Velocity;
	import org.alwaysinbeta.pong.constants.EntityGroup;
	import org.alwaysinbeta.pong.constants.EntityTag;
	import org.alwaysinbeta.pong.systems.BallMovementSystem;
	import org.alwaysinbeta.pong.systems.BallRenderSystem;
	import org.alwaysinbeta.pong.systems.CollisionSystem;
	import org.alwaysinbeta.pong.systems.EnemyRenderSystem;
	import org.alwaysinbeta.pong.systems.PlayerControlSystem;
	import org.alwaysinbeta.pong.systems.PlayerRenderSystem;

	/**
	 * @author McFamily
	 */
	
	[SWF(backgroundColor="#000000", frameRate="60", width="640", height="480")]
	
	public final class Pong extends BasicGame {
		private var _world : World;
		private var _container : GameContainer;
		private var _debug : Monitor;
		private var _playerControlSystem : EntitySystem;
		private var _playerRenderSystem : EntitySystem;
		private var _enemyRenderSystem : EntitySystem;
		private var _ballRenderSystem : EntitySystem;
		private var _ballMovementSystem : EntitySystem;
		private var _collisionSystem : EntitySystem;
		private var _enemyMovementSystem : EntitySystem;
		
		public function Pong() {
			super(640, 480);
		}
		
		override public function init(container : GameContainer) : void {
			_container = container;

			_world = new World();
			
			addChild(_debug = new Monitor(_world));
			_debug.x = _container.getWidth() - _debug.width;
			
			// init systems
			
			var systemManager : SystemManager = _world.getSystemManager();
			
			_playerControlSystem = systemManager.setSystem(new PlayerControlSystem(_container));
			_playerRenderSystem = systemManager.setSystem(new PlayerRenderSystem(_container));
			_enemyRenderSystem = systemManager.setSystem(new EnemyRenderSystem(_container));
			_ballRenderSystem = systemManager.setSystem(new BallRenderSystem(_container));
			_ballMovementSystem = systemManager.setSystem(new BallMovementSystem(_container));
			_collisionSystem = systemManager.setSystem(new CollisionSystem());
			_enemyMovementSystem = systemManager.setSystem(new EnemyMovementSystem(_container));
			
			systemManager.initializeAll();
			
			// init entities
			
			var e : Entity;
			e = _world.createEntity();
			e.setTag(EntityTag.PLAYER);
			e.setGroup(EntityGroup.PLAYERS);
			e.addComponent(new Transform(20, ( _container.getHeight() * 0.5 ) - 30 ));
			e.addComponent(new Rect(0, 0, 20, 60));
			e.addComponent(new Player());
			e.refresh();
			
			e = _world.createEntity();
			e.setTag(EntityTag.ENEMY);
			e.setGroup(EntityGroup.PLAYERS);
			e.addComponent(new Transform(_container.getWidth() - 40, ( _container.getHeight() * 0.5 ) - 30 ));
			e.addComponent(new Rect(0, 0, 20, 60));
			e.addComponent(new Enemy());
			e.refresh();
			
			e = _world.createEntity();
			e.setTag(EntityTag.BALL);
			e.addComponent(new Transform(100, 100));
			e.addComponent(new Rect(0, 0, 20, 20));
			e.addComponent(new Velocity(1,1));
			e.refresh();
		}
		
		override public function update(container : GameContainer, delta : int) : void {
			container;
			
			_world.loopStart();

			_world.setDelta(delta);
			
			// process systems
			
			_collisionSystem.process();
			_ballMovementSystem.process();
			_playerControlSystem.process();
			_enemyMovementSystem.process();
		}

		override public function render(container : GameContainer, g : Canvas) : void {
			container, g;
			
			// process systems
			
			_playerRenderSystem.process();
			_enemyRenderSystem.process();
			_ballRenderSystem.process();
		}
	}
}
