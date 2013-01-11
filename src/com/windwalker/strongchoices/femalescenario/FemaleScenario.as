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
		
		private var prevMC : MovieClip;
		private var nextMC : MovieClip;
		
		
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
			
			prevMC = MovieClip(navMC.getChildByName("prev_mc"));
			prevMC.addEventListener(MouseEvent.CLICK, controller.onPreClick);
			prevMC.buttonMode = true;
			prevMC.mouseEnabled = false;
			
			nextMC = MovieClip(navMC.getChildByName("next_mc"));
			nextMC.addEventListener(MouseEvent.CLICK, controller.onNextClick);
			nextMC.buttonMode = true;
			
			var containerMC : MovieClip = MovieClip(getChildByName("container_mc"));
			containerMC.addChild(view);
			
			disableBtn(prevMC);
			controller.init();
		}

		private function onModelChange(event : Event) : void 
		{
			var userHistory : Array = model.userHistory;
			
			// If first frame
			if (userHistory.length == 1)
				disableBtn(prevMC);
			else 			
				enableBtn(prevMC);
				
			view.update(event);
		}

		private function enableBtn(btn : MovieClip) : void 
		{
			btn.mouseEnabled = true;
			btn.alpha = 1;
		}

		private function disableBtn(btn : MovieClip) : void 
		{
			btn.mouseEnabled = false;
			btn.alpha = .25;
		}
	}
}
