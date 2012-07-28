package com.artemis {
	import flash.utils.Dictionary;
	// import java.util.HashMap;
	// import java.util.Map;
	import com.artemis.utils.Bag;

	/**
	 * If you need to communicate with systems from other system, then look it up here.
	 * Use the world instance to retrieve a instance.
	 * 
	 * @author Arni Arent
	 *
	 */
	public class SystemManager {
		private var _world : World;
		// private Map<Class<?>, EntitySystem> systems;
		private var _systems : Dictionary;
		// private Bag<EntitySystem> bagged;
		private var _bagged : Bag;

		public function SystemManager(world : World) {
			_world = world;
			// systems = new HashMap<Class<?>, EntitySystem>();
			// bagged = new Bag<EntitySystem>();
			_systems = new Dictionary();
			_bagged = new Bag();
		}

		public function setSystem(system : EntitySystem) : EntitySystem {
			system.setWorld(_world);

			// systems.put(system.getClass(), system);
			_systems[Object(system).constructor] = system;

			if (!_bagged.contains(system))
				_bagged.add(system);

			// system.setSystemBit(SystemBitManager.getBitFor(system.getClass()));
			system.setSystemBit(SystemBitManager.getBitFor(Object(system).constructor as Class));

			return system;
		}

		// public <T extends EntitySystem> function getSystem(Class<T> type):T {
		public function getSystem(type : Class) : * {
			// return type.cast(systems.get(type));
			return _systems[type];
		}

		// public Bag<EntitySystem> getSystems() {
		public function getSystems() : Bag {
			return _bagged;
		}

		/**
		 * After adding all systems to the world, you must initialize them all.
		 */
		public function initializeAll() : void {
			for (var i : int = 0; i < _bagged.size(); i++) {
				EntitySystem(_bagged.get(i)).initialize();
			}
		}
	}
}