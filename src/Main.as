package  
{
	import com.windwalker.strongchoices.Controller;
	import com.windwalker.strongchoices.Model;
	import com.windwalker.strongchoices.views.View;

	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;

	/**
	 * @author qngo
	 */
	public class Main extends MovieClip 
	{
		private var model : Model;
		private var view : View;
		private var controller : Controller;
		
		public function Main()
		{
			stop();
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(event : Event = null) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align     = StageAlign.TOP_LEFT;
			
			var configFile : String = stage.loaderInfo.parameters.configSrc || "";
			
			model = Model.getInstance();
			model.addEventListener(Event.COMPLETE, onModelComplete);
			model.load(new URLRequest(configFile + "flash_config.xml"));
			
			trace("main.fla :: init()");
		}

		private function onModelComplete(event : Event) : void 
		{
			model.removeEventListener(Event.COMPLETE, onModelComplete);
			model.addEventListener(Event.CHANGE, onModelChange);
			controller = new Controller(model);
			view = new View(model, controller);

			addChild(view);

			controller.init();
		}
		
		private function onModelChange(event : Event) : void 
		{
			view.update(event);
		}
	}
}
