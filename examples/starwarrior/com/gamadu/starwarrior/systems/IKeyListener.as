package com.gamadu.starwarrior.systems {
	import org.alwaysinbeta.starwarrior.Input;
	/**
	 * @author ian
	 */
	public interface IKeyListener {
		function keyPressed(key : uint, c : String) : void;
		function keyReleased(key : uint, c : String) : void;
		
		function inputEnded() : void;
		function inputStarted() : void;
		function isAcceptingInput() : Boolean;
		function setInput(input : Input) : void;
	}
}
