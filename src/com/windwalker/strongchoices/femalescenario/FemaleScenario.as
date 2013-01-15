package com.windwalker.strongchoices.femalescenario 
{
	import com.windwalker.display.ProMovieClip;
	import com.windwalker.strongchoices.femalescenario.views.View;

	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;

	/**
	 * @author qngo
	 */
	public class FemaleScenario extends ProMovieClip 
	{
		private var model : Model;
		private var view : View;
		private var controller : Controller;

		private var navMC : MovieClip;
		private var prevMC : MovieClip;
		private var nextMC : MovieClip;
		private var titleTF : TextField;

		public function FemaleScenario()
		{
			super();
			stop();
			
			// A super class variable. This will get override from the parent.
			requiredDataSrc = "female_scenario.xml";
			
			// Standalone detecting technique.
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		override public function init(event : Event = null) : void
		{
			trace("Female Scenario init()");
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align     = StageAlign.TOP_LEFT;
			
			model = Model.getInstance();
			model.addEventListener(Event.COMPLETE, onModelComplete);
			model.load(new URLRequest(requiredDataSrc));
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
			navMC = MovieClip(getChildByName("nav_mc"));
			
			prevMC = MovieClip(navMC.getChildByName("prev_mc"));
			prevMC.addEventListener(MouseEvent.CLICK, controller.onPreClick);
			prevMC.buttonMode = true;
			prevMC.mouseEnabled = false;
			
			nextMC = MovieClip(navMC.getChildByName("next_mc"));
			nextMC.addEventListener(MouseEvent.CLICK, controller.onNextClick);
			nextMC.buttonMode = true;
			
			var containerMC : MovieClip = MovieClip(getChildByName("container_mc"));
			containerMC.addChild(view);
			
			titleTF = TextField(navMC.getChildByName("title_txt"));
			
			stage.addEventListener(Event.RESIZE, onStageResize);
			onStageResize();
			
			disableBtn(prevMC);
			controller.init();
		}

		private function onStageResize(event : Event = null) : void 
		{
			navMC.y = (stage.stageHeight - navMC.height) + 1;
		}

		private function onModelChange(event : Event) : void 
		{
			var userHistory : Array = model.userHistory;
			
			// If first frame
			if (userHistory.length == 1)
				disableBtn(prevMC);
			else 			
				enableBtn(prevMC);
			
			// Update the title
			var currentNodeData : XMLList = model.currentNodeData;
			var fileSrc : String = currentNodeData.file.@src;
			var splitString : Array = fileSrc.split('/');
			titleTF.text = splitString.pop();
			
			// Check node type
			switch(String(currentNodeData.@type))
			{
				case "eval":
					disableBtn(nextMC);
					break;
				default:
					enableBtn(nextMC);
			}
				
			// If end frame
			if (String(currentNodeData.complete.@action) == "end")
				disableBtn(nextMC);
				
			// Update view	
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
			btn.alpha = .1;
		}
	}
}
