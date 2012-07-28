package com.artemis {
	import com.artemis.utils.Bag;

	import flash.utils.Dictionary;
	// import java.util.HashMap;
	// import java.util.Map;

	/**
	 * The primary instance for the framework. It contains all the managers.
	 * 
	 * You must use this to create, delete and retrieve entities.
	 * 
	 * It is also important to set the delta each game loop iteration.
	 * 
	 * @author Arni Arent
	 *
	 */
	public class World {
		private var _systemManager : SystemManager;
		private var _entityManager : EntityManager;
		private var _tagManager : TagManager;
		private var _groupManager : GroupManager;
		private var _delta : int;
		// private Bag<Entity> refreshed;
		// private Bag<Entity> deleted;
		private var _refreshed : Bag;
		private var _deleted : Bag;
		// private Map<Class<? extends Manager>, Manager> managers;
		private var _managers : Dictionary;

		public function World() {
			_entityManager = new EntityManager(this);
			_systemManager = new SystemManager(this);
			_tagManager = new TagManager(this);
			_groupManager = new GroupManager(this);

			// refreshed = new Bag<Entity>();
			// deleted = new Bag<Entity>();
			_refreshed = new Bag();
			_deleted = new Bag();

			// managers = new HashMap<Class<? extends Manager>, Manager>();
			_managers = new Dictionary();
		}

		public function getGroupManager() : GroupManager {
			return _groupManager;
		}

		public function getSystemManager() : SystemManager {
			return _systemManager;
		}

		public function getEntityManager() : EntityManager {
			return _entityManager;
		}

		public function getTagManager() : TagManager {
			return _tagManager;
		}

		/**
		 * Allows for setting a custom manager.
		 * @param manager to be added
		 */
		public function setManager(manager : IManager) : void {
			// managers.put(manager.getClass(), manager);
			_managers[Object(manager).constructor] = manager;
		}

		/**
		 * Returns a manager of the specified type.
		 * 
		 * @param <T>
		 * @param managerType class type of the manager
		 * @return the manager
		 */
		// public <T extends Manager> function getManager(Class<T> managerType):T {
		public function getManager(managerType : Class) : IManager {
			// return managerType.cast(managers.get(managerType));
			return _managers[managerType];
		}

		/**
		 * Time since last game loop.
		 * @return delta in milliseconds.
		 */
		public function getDelta() : int {
			return _delta;
		}

		/**
		 * You must specify the delta for the game here.
		 * 
		 * @param delta time since last game loop.
		 */
		public function setDelta(delta : int) : void {
			this._delta = delta;
		}

		/**
		 * Delete the provided entity from the world.
		 * @param e entity
		 */
		public function deleteEntity(e : Entity) : void {
			 if(!_deleted.contains(e)) {
			 	_deleted.add(e);
			 }
		}

		/**
		 * Ensure all systems are notified of changes to this entity.
		 * @param e entity
		 */
		public function refreshEntity(e : Entity) : void {
			_refreshed.add(e);
		}

		/**
		 * Create and return a new or reused entity instance.
		 * @return entity
		 */
		public function createEntity() : Entity {
			return _entityManager.create();
		}

		/**
		 * Get a entity having the specified id.
		 * @param entityId
		 * @return entity
		 */
		public function getEntity(entityId : int) : Entity {
			return _entityManager.getEntity(entityId);
		}

		/**
		 * Let framework take care of internal business.
		 */
		public function loopStart() : void {
			var i : int;
			if (!_refreshed.isEmpty()) {
				for (i = 0; _refreshed.size() > i; i++) {
					_entityManager.refresh(_refreshed.get(i));
				}
				_refreshed.clear();
			}

			if (!_deleted.isEmpty()) {
				for (i = 0; _deleted.size() > i; i++) {
					var e : Entity = _deleted.get(i);
					_groupManager.remove(e);
					_entityManager.remove(e);
					_tagManager.remove(e);
				}
				_deleted.clear();
			}
		}
	}
}