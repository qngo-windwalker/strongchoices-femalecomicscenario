package com.windwalker.display 
{
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * @author qngo
	 */
	public class ProMovieClip extends MovieClip 
	{
		protected var isStandalone : Boolean = true;
		
		public var requiredDataSrc : String;
		
		public function ProMovieClip()
		{
			super();
		}
		
		public function init(event : Event = null) : void
		{
			
		}
	}
}
