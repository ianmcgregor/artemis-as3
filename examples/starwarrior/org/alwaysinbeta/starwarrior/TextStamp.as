package org.alwaysinbeta.starwarrior {
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.display.BitmapData;
	import flash.text.TextField;
	/**
	 * @author ian
	 */
	public class TextStamp {
		
		private static var _text : TextField;
		private static var _bitmapData : BitmapData;
		
		public static function getBitmapData(string : String) : BitmapData {
			if(!_text) {
				_text = new TextField();
				_text.multiline = false;
				_text.autoSize = TextFieldAutoSize.LEFT;
				_text.defaultTextFormat = new TextFormat('_sans', 10, 0xFFFFFF, true);
				_text.embedFonts = false;
			}
			_text.text = string;
			var w : int = int(_text.textWidth + 1);
			var h : int = int(_text.textHeight + 1);
			
			if (!_bitmapData || w > _bitmapData.width || h > _bitmapData.height) {
				_bitmapData = new BitmapData(w, h, false);
			}
			_bitmapData.fillRect(_bitmapData.rect, 0xFF000000);
			_bitmapData.draw(_text, null, null, null, null, true);
			
			return _bitmapData;
		}
	}
}
