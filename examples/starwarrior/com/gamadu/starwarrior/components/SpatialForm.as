package com.gamadu.starwarrior.components {
	import com.artemis.Component;

	public class SpatialForm extends Component {
		private var _spatialFormFile : String;

		public function SpatialForm(spatialFormFile : String) {
			_spatialFormFile = spatialFormFile;
		}

		public function getSpatialFormFile() : String {
			return _spatialFormFile;
		}
	}
}