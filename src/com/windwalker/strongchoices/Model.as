package com.windwalker.strongchoices 
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * @author Quan
	 */
	public class Model extends EventDispatcher 
	{
		private static var _instance : Model;
		
		private var urlLoader : URLLoader;
		private var loader : Loader;
		
		private var globalData : GlobalData;
		
		public var state : String = "preloading";
		public var contentCollection : Array = new Array();
		
		public var flash_configXML : XML;
		
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

		public function load(urlRequest : URLRequest) : void 
		{
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onUrlLoaderComplete);
			urlLoader.load(urlRequest);
		}
		
		private function onUrlLoaderComplete(event : Event) : void 
		{
			urlLoader.removeEventListener(Event.COMPLETE, onUrlLoaderComplete);
			
			flash_configXML = XML(event.target.data);

			globalData = new GlobalData('XML');
			globalData.xml = XML(event.target.data);

			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function update($state : String) : void 
		{
			state = $state;
			
			switch($state){
				case "START":
					loadMedia(globalData.app_src);
					break;
				default:
			}
			
			dispatchEvent(new Event(Event.CHANGE));
		}

		private function loadMedia(src : String) : void 
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _onLoadComplete, false, 0, true);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, _onLoadProgress, false, 0, true);
			
			loader.load(new URLRequest(src));
		}

		private function _onLoadProgress($evt : ProgressEvent) : void 
		{  
//			preloader.updateProgress($evt.bytesLoaded, $evt.bytesTotal, 0, 10); 
//			updateProgress($evt.bytesLoaded, $evt.bytesTotal, 0, 10); 
		}
		
		private function _onLoadComplete($evt : Event) : void 
		{ 
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, _onLoadComplete);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, _onLoadProgress);
			
			contentCollection['app_src'] = [];
			contentCollection['app_src']['DisplayObject'] = $evt.target.content;
			
			state = "LOAD_COMPLETE";
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function getContent( id : String) : DisplayObject
		{
			return contentCollection[id]['DisplayObject'];
		}
		
		private function updateProgress($bytesLoaded:Number, $bytesTotal:Number, $itemsLoaded:Number, $itemsTotal:Number):void{
//			var framesPerItem:Number = Math.floor(preloader.progress_mc.totalFrames/($itemsTotal));
			var pct:Number = $bytesLoaded/$bytesTotal;
//			_targetFrame = Math.floor(framesPerItem * pct) + (framesPerItem * $itemsLoaded);
		}
	}
}

class PrivateClass
{
	public function PrivateClass()
	{  
	}
}