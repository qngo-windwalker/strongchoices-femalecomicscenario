package com.windwalker.strongchoices.femalescenario 
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
		public var state : String = "preloading";
		public var currentContent : DisplayObject;
		public var userHistory : Array = new Array();
		public var currentNodeData : XMLList;
		
		private static var _instance : Model;
		
		private var urlLoader : URLLoader;
		private var loader : Loader;
		private var xmlHelper : XMLHelper;
		

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
			
			xmlHelper = new XMLHelper(XML(event.target.data));

			dispatchEvent(new Event(Event.COMPLETE));
		}

		public function update($state : String) : void 
		{
			state = $state;
			
			switch($state)
			{
				case "START":
					//					loadMedia(globalData.appSrc);
					break;
				default:
			}
			
			dispatchEvent(new Event(Event.CHANGE));
		}

		private function updateProgress($bytesLoaded : Number, $bytesTotal : Number, $itemsLoaded : Number, $itemsTotal : Number) : void
		{
			//			var framesPerItem:Number = Math.floor(preloader.progress_mc.totalFrames/($itemsTotal));
			var pct : Number = $bytesLoaded / $bytesTotal;
//			_targetFrame = Math.floor(framesPerItem * pct) + (framesPerItem * $itemsLoaded);
		}

		private function loadMedia(src : String) : void 
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, _onLoadProgress, false, 0, true);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _onLoadComplete, false, 0, true);
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
			
			currentContent = $evt.target.content;
			
			state = "LOAD_COMPLETE";
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		/*
		 * param @id : String An id such as "1", "2a", or "3.4b".
		 */
		public function updateCurrentNodeById(id : String) : void 
		{
			// record id 
			userHistory.push(id);
			
			// Get the XML data from the xml source.
			currentNodeData = xmlHelper.getNodeDataByID(id);
			
			var fileSrc : String = currentNodeData.file.@src;
			loadMedia(fileSrc);
		}

		/*
		 * @param node : * Can be a string or number. Number can be in String format
		 */
		public function gotoNode(node) : void 
		{
			var nodeID : String;
			// Accept "FIRST" or "1" or "1a". Since XML returns string.
			if (node is String) 
			{ 
				switch(node){
					case "FIRST":
						nodeID = xmlHelper.getFirstNodeID();
						break;
					default:
					nodeID = node;
				} 
			} 
		    else if (node is Number) 
		    { 
				nodeID = node;
		    } 
		    
			updateCurrentNodeById(String(nodeID));
		}
	}
}

class PrivateClass
{
	public function PrivateClass()
	{  
	}
}