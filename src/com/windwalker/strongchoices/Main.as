package com.windwalker.strongchoices 
{
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;

	public class Main extends EventDispatcher
	{
		private var _mc : MovieClip;

		public function Main($mc : MovieClip)
		{
			_mc = $mc;
			trace('hello world');
		}

		public function get mc() : MovieClip { 
			return mc; 
		}
	}
}