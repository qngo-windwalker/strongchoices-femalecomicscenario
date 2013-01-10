package com.windwalker.strongchoices.femalescenario 
{
	import com.windwalker.strongchoices.femalescenario.Controller;
	import flash.events.MouseEvent;
	import com.windwalker.strongchoices.femalescenario.views.View;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;

	/**
	 * @author qngo
	 */
	public class FemaleScenario extends MovieClip 
	{
		private var model : Model;
		private var view : View;
		private var controller : Controller;
		
		public function FemaleScenario()
		{
			super();
			stop();
			
			model = Model.getInstance();
			model.addEventListener(Event.COMPLETE, onModelComplete);
			model.load(new URLRequest("female_scenario.xml"));
		}
		
		public function init() : void
		{
			controller.init();
		}
		
		/*
		 * At this point, all data should been loaded.
		 */
		private function onModelComplete(event : Event) : void 
		{
			model.removeEventListener(Event.COMPLETE, onModelComplete);
			model.addEventListener(Event.CHANGE, onModelChange);
			controller = new Controller(model);
			view = new View(model, controller);

			
			// Adding interaction to the UI.
			var navMC : MovieClip = MovieClip(getChildByName("nav_mc"));
			
			var preMC : MovieClip = MovieClip(navMC.getChildByName("prev_mc"));
			preMC.addEventListener(MouseEvent.CLICK, controller.onPreClick);
			preMC.buttonMode = true;
			
			var nextMC : MovieClip = MovieClip(navMC.getChildByName("next_mc"));
			nextMC.addEventListener(MouseEvent.CLICK, controller.onNextClick);
			nextMC.buttonMode = true;
			
			var containerMC : MovieClip = MovieClip(getChildByName("container_mc"));
			containerMC.addChild(view);
		}

		private function onModelChange(event : Event) : void 
		{
			view.update(event);
		}
	}
}
