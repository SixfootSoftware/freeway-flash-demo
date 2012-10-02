package com.sixfootsoftware 
{
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author David Long
	 */
	public interface IAlignable {
		
		function alignWith( parentLayer:IAlignable ):void;
		function setScreenPosition( newCoords:FlxPoint ):void;
		function getScreenPosition():FlxPoint;
		
	}	

}