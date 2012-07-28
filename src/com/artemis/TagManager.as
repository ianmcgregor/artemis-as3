package com.artemis {
	import flash.utils.Dictionary;

	// import java.util.HashMap;
	// import java.util.Map;
	/**
	 * If you need to tag any entity, use this. A typical usage would be to tag
	 * entities such as "PLAYER". After creating an entity call register().
	 * 
	 * @author Arni Arent
	 *
	 */
	public class TagManager {
		private var _world : World;
		// private Map<String, Entity> entityByTag;
		private var entityByTag : Dictionary;

		public function TagManager(world : World) {
			_world = world;
			// entityByTag = new HashMap<String, Entity>();
			entityByTag = new Dictionary();
		}

		public function register(tag : String, e : Entity) : void {
			// entityByTag.put(tag, e);
			entityByTag[tag] = e;
		}

		public function unregister(tag : String) : void {
			// entityByTag.remove(tag);
			delete entityByTag[tag];
		}

		public function isRegistered(tag : String) : Boolean {
			// return entityByTag.containsKey(tag);
			return entityByTag[tag];
		}

		public function getEntity(tag : String) : Entity {
			// return entityByTag.get(tag);
			return entityByTag[tag];
		}

		public function remove(e : Entity) : void {
			// entityByTag.values().remove(e);
			for (var i : String in entityByTag) {
				if (entityByTag[i] == e) {
					delete entityByTag[i];
					break;
				}
			}
		}
	}
}