package com.artemis {
	import flash.utils.Dictionary;

	// import java.util.HashMap;
	public class ComponentTypeManager {
		// private static HashMap<Class<? extends Component>, ComponentType> componentTypes = new HashMap<Class<? extends Component>, ComponentType>();
		// TODO: make a typed Hashmap?
		private static var _componentTypes : Dictionary = new Dictionary();

		// public static function getTypeFor(Class<? extends Component> c):ComponentType {
		public static function getTypeFor(c : Class) : ComponentType {
			if (!type is Component) {
				throw new ArgumentError("class must be subclass of Component");
			}
			// var type:ComponentType= componentTypes.get(c);
			var type : ComponentType = _componentTypes[c];

			if (type == null) {
				type = new ComponentType();
				// componentTypes.put(c, type);
				_componentTypes[c] = type;
			}

			return type;
		}

		// public static function getBit(Class<? extends Component> c):Number {
		public static function getBit(c : Class) : Number {
			return getTypeFor(c).getBit();
		}

		// public static function getId(Class<? extends Component> c):int {
		public static function getId(c : Class) : int {
			return getTypeFor(c).getId();
		}
	}
}