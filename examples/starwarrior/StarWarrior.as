package {
	import com.artemis.Entity;
	import com.artemis.EntitySystem;
	import com.artemis.SystemManager;
	import com.artemis.World;
	import com.gamadu.starwarrior.EntityFactory;
	import com.gamadu.starwarrior.components.Health;
	import com.gamadu.starwarrior.components.Player;
	import com.gamadu.starwarrior.components.SpatialForm;
	import com.gamadu.starwarrior.components.Transform;
	import com.gamadu.starwarrior.components.Velocity;
	import com.gamadu.starwarrior.constants.EntityGroup;
	import com.gamadu.starwarrior.constants.SpatialFormFile;
	import com.gamadu.starwarrior.systems.CollisionSystem;
	import com.gamadu.starwarrior.systems.EnemyShipMovementSystem;
	import com.gamadu.starwarrior.systems.EnemyShooterSystem;
	import com.gamadu.starwarrior.systems.EnemySpawnSystem;
	import com.gamadu.starwarrior.systems.ExpirationSystem;
	import com.gamadu.starwarrior.systems.HealthBarRenderSystem;
	import com.gamadu.starwarrior.systems.HudRenderSystem;
	import com.gamadu.starwarrior.systems.MovementSystem;
	import com.gamadu.starwarrior.systems.PlayerShipControlSystem;
	import com.gamadu.starwarrior.systems.RenderSystem;
	import org.alwaysinbeta.debug.Monitor;
	import org.alwaysinbeta.game.BasicGame;
	import org.alwaysinbeta.game.Canvas;
	import org.alwaysinbeta.game.GameContainer;


	[SWF(backgroundColor="#000000", frameRate="60", width="640", height="480")]
	
	public final class StarWarrior extends BasicGame {
		private var _world : World;
		private var _container : GameContainer;
		private var _renderSystem : EntitySystem;
		private var _hudRenderSystem : EntitySystem;
		private var _controlSystem : EntitySystem;
		private var _movementSystem : EntitySystem;
		private var _enemyShooterSystem : EntitySystem;
		private var _enemyShipMovementSystem : EntitySystem;
		private var _collisionSystem : EntitySystem;
		private var _healthBarRenderSystem : EntitySystem;
		private var _enemySpawnSystem : EntitySystem;
		private var _expirationSystem : EntitySystem;
		private var _debug : Monitor;

		public function StarWarrior() {
			super(640, 480);
		}

		override public function init(container : GameContainer) : void {
			_container = container;

			_world = new World();

			var systemManager : SystemManager = _world.getSystemManager();
			_renderSystem = systemManager.setSystem(new RenderSystem(container));
			_hudRenderSystem = systemManager.setSystem(new HudRenderSystem(container));
			_controlSystem = systemManager.setSystem(new MovementSystem(container));
			_movementSystem = systemManager.setSystem(new PlayerShipControlSystem(container));
			_enemyShooterSystem = systemManager.setSystem(new EnemyShipMovementSystem(container));
			_enemyShipMovementSystem = systemManager.setSystem(new EnemyShooterSystem());
			_collisionSystem = systemManager.setSystem(new CollisionSystem());
			_healthBarRenderSystem = systemManager.setSystem(new HealthBarRenderSystem(container));
			_enemySpawnSystem = systemManager.setSystem(new EnemySpawnSystem(500, container));
			_expirationSystem = systemManager.setSystem(new ExpirationSystem());

			systemManager.initializeAll();

			initPlayerShip();
			initEnemyShips();
			
			addChild(_debug = new Monitor(_world));
			_debug.x = _container.getWidth() - _debug.width;
			
			
//			var min : Number = -10;
//			var max : Number = 10;
//			var t: int = 0;
//			while(t++ < 5){
//				var count: uint = 1000000;
//				var random: Random = new Random(count, min, max);
//				var n: Number;
//				var startTime: int = getTimer();
//				var i: int = 0;
//				while(i++ < count){
//					n = random.get();
//				}
//				trace("1", getTimer() - startTime);
//				
//				i = 0;
//				while (i++ < count) {
//					n = min + Math.random() * (max - min);
//				}
//				trace("2", getTimer() - startTime);
//			}
		}

		private function initEnemyShips() : void {
			var x : int = _container.getWidth() * Math.random();
			var y : int = 200 * Math.random() + 20;
			var b : Boolean = Math.random() > 0.5;
			var i: int = -1;
			while(++i < 10) {
				var e : Entity = EntityFactory.createEnemyShip(_world);

				Transform(e.getComponent(Transform)).setLocation(x, y);
				Velocity(e.getComponent(Velocity)).setVelocity(0.05);
				Velocity(e.getComponent(Velocity)).setAngle(b ? 0 : 180);

				e.refresh();
			}
		}

		private function initPlayerShip() : void {
			var e : Entity = _world.createEntity();
			e.setGroup(EntityGroup.SHIPS);
			e.addComponent(new Transform(_container.getWidth() * 0.5, _container.getHeight() - 40));
			e.addComponent(new SpatialForm(SpatialFormFile.PLAYER_SHIP));
			e.addComponent(new Health(30));
			e.addComponent(new Player());

			e.refresh();
		}

		override public function update(container : GameContainer, delta : int) : void {
			container;
			
			_world.loopStart();

			_world.setDelta(delta);

			_controlSystem.process();
			_movementSystem.process();
			_enemyShooterSystem.process();
			_enemyShipMovementSystem.process();
			_collisionSystem.process();
			_enemySpawnSystem.process();
			_expirationSystem.process();
		}

		override public function render(container : GameContainer, g : Canvas) : void {
			container, g;
			
			_renderSystem.process();
			_healthBarRenderSystem.process();
			_hudRenderSystem.process();
		}
	}
}