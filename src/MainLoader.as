package  
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	/**
	 * @author Quan
	 */
	public class MainLoader extends MovieClip
	{
		private static var instance : MainLoader;
		
		private var preloader: MovieClip;
		private var _targetFrame		:Number;

		public static function getInstance() : MainLoader 
		{ 
			return instance; 
		};

		public function MainLoader()
		{
			instance = this;
			preloader = MovieClip(this.getChildByName("preloader_mc"));
			preloader.gotoAndPlay("START");
			preloader.addEventListener("ANIMATE_IN", _startLoad, false, 0, true);
			preloader.addEventListener("ANIMATE_OUT", _onPreloaderOut, false, 0, true);
		}

		protected function _startLoad($evt : Event) : void
		{
			var l : Loader = new Loader();
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, _onLoadComplete, false, 0, true);
			l.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, _onLoadProgress, false, 0, true);

//			var baseSWFPath : String = stage.loaderInfo.parameters.baseSWFPath || "./";
			var baseSWFPath : String = stage.loaderInfo.parameters.baseSWFPath || "";

			l.load(new URLRequest(baseSWFPath + "main.swf"));
		}

		protected function _onLoadProgress($evt : ProgressEvent) : void 
		{ 
//			preloader.updateProgress($evt.bytesLoaded, $evt.bytesTotal, 0, 10); 
			updateProgress($evt.bytesLoaded, $evt.bytesTotal, 0, 10); 
		}
		
		public function updateProgress($bytesLoaded:Number, $bytesTotal:Number, $itemsLoaded:Number, $itemsTotal:Number):void{
			var framesPerItem:Number = Math.floor(preloader.progress_mc.totalFrames/($itemsTotal));
			var pct:Number = $bytesLoaded/$bytesTotal;
			_targetFrame = Math.floor(framesPerItem * pct) + (framesPerItem * $itemsLoaded);
			//	Out.debug(this, "updatePreloader :: " + $bytesLoaded + "/" + $bytesTotal + " :: " + $itemsLoaded + "/" + $itemsTotal + " :: " + preloader_mc.progress_mc.currentFrame + "/" + preloader_mc.progress_mc.totalFrames + " :: " + targetFrame);
		}

		protected function _onLoadComplete($evt : Event) : void 
		{ 
			addChild($evt.target.content); 
		}

		protected function _onPreloaderOut($evt : Event) : void 
		{ 
			instance = null; 
		}
	}
}
