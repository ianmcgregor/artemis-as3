package com.artemis {
	import flash.utils.Dictionary;
	// import java.util.HashMap;
	// import java.util.Map;
	import com.artemis.utils.Bag;
	import com.artemis.utils.IImmutableBag;

	/**
	 * If you need to group your entities together, e.g. tanks going into "units" group or explosions into "effects",
	 * then use this manager. You must retrieve it using world instance.
	 * 
	 * A entity can only belong to one group at a time.
	 * 
	 * @author Arni Arent
	 *
	 */
	public class GroupManager {
		private var _world : World;
		// private Bag<Entity> EMPTY_BAG;
		// private Map<String, Bag<Entity>> entitiesByGroup;
		// private Bag<String> groupByEntity;
		private var _emptyBag : Bag;
		private var _entitiesByGroup : Dictionary;
		private var _groupByEntity : Bag;

		public function GroupManager(world : World) {
			_world = world;
			// entitiesByGroup = new HashMap<String, Bag<Entity>>();
			_entitiesByGroup = new Dictionary();
			_groupByEntity = new Bag();
			_emptyBag = new Bag();
		}

		/**
		 * Set the group of the entity.
		 * 
		 * @param group group to set the entity into.
		 * @param e entity to set into the group.
		 */
		public function set(group : String, e : Entity) : void {
			remove(e);
			// Entity can only belong to one group.

			// Bag<Entity> entities = entitiesByGroup.get(group);
			var entities : Bag = _entitiesByGroup[group];
			if (entities == null) {
				// entities = new Bag<Entity>();
				entities = new Bag();
				// entitiesByGroup.put(group, entities);
				_entitiesByGroup[group] = entities;
			}
			entities.add(e);

			_groupByEntity.set(e.getId(), group);
		}

		/**
		 * Get all entities that belong to the provided group.
		 * @param group name of the group.
		 * @return read-only bag of entities belonging to the group.
		 */
		// public ImmutableBag<Entity> getEntities(var group:String) {
		public function getEntities(group : String) : IImmutableBag {
			// Bag<Entity> bag = entitiesByGroup.get(group);
			var bag : Bag = _entitiesByGroup[group];
			if (bag == null)
				return _emptyBag;
			return bag;
		}

		/**
		 * Removes the provided entity from the group it is assigned to, if any.
		 * @param e the entity.
		 */
		public function remove(e : Entity) : void {
			if (e.getId() < _groupByEntity.getCapacity()) {
				var group : String = _groupByEntity.get(e.getId());
				if (group != null) {
					_groupByEntity.set(e.getId(), null);

					// Bag<Entity> entities = entitiesByGroup.get(group);
					var entities : Bag = _entitiesByGroup[group];
					if (entities != null) {
						entities.removeOb(e);
					}
				}
			}
		}

		/**
		 * @param e entity
		 * @return the name of the group that this entity belongs to, null if none.
		 */
		public function getGroupOf(e : Entity) : String {
			if (e.getId() < _groupByEntity.getCapacity()) {
				return _groupByEntity.get(e.getId());
			}
			return null;
		}

		/**
		 * Checks if the entity belongs to any group.
		 * @param e the entity to check.
		 * @return true if it is in any group, false if none.
		 */
		public function isGrouped(e : Entity) : Boolean {
			return getGroupOf(e) != null;
		}

		/**
		 * Check if the entity is in the supplied group.
		 * @param group the group to check in.
		 * @param e the entity to check for.
		 * @return true if the entity is in the supplied group, false if not.
		 */
		public function isInGroup(group : String, e : Entity) : Boolean {
			// return group != null && group.equalsIgnoreCase(getGroupOf(e));
			return group != null && group.toLowerCase() == getGroupOf(e).toLowerCase();
		}
	}
}