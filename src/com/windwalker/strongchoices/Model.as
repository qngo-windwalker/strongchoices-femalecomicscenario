package com.windwalker.strongchoices 
{
	import flash.net.URLRequest;
	import flash.events.EventDispatcher;

	/**
	 * @author Quan
	 */
	public class Model extends EventDispatcher 
	{
		private static var _instance : Model;

		public function Model($pvt : PrivateClass) 
		{
			super();
			if( _instance != null ) throw new Error("Error:Model already initialised.");
			if( _instance == null ) _instance = this;
		}

		public static function getInstance() : Model 
		{
			if (_instance == null)
			{
				_instance = new Model(new PrivateClass());
			}
			return _instance;
		}

		public function load(uRLRequest : URLRequest) : void 
		{
		}
	}
}

class PrivateClass
{
	public function PrivateClass()
	{  
	}
}