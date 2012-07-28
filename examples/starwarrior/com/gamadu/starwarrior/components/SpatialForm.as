package com.gamadu.starwarrior.components {
	import com.artemis.Component;

	public class SpatialForm extends Component {
		private var spatialFormFile : String;

		public function SpatialForm(spatialFormFile : String) {
			this.spatialFormFile = spatialFormFile;
		}

		public function getSpatialFormFile() : String {
			return spatialFormFile;
		}
	}
}