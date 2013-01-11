package com.windwalker.strongchoices.femalescenario 
{
	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * @author Quan
	 */
	public class Controller 
	{
		private var model : Model;

		public function Controller(m : Model)
		{
			model = m;	
		}

		public function init() : void 
		{
			model.gotoNode("FIRST");  
		}

		public function onPreClick(event : Event = null) : void 
		{
			var userHistory : Array = model.userHistory;
			userHistory.pop(); // Remove current one.
			var id : String = userHistory.pop(); // Remove previous one and reference it.
			model.updateCurrentNodeById(id);  
		}

		public function onNextClick(event : Event = null) : void 
		{
			var nextNodeID : String;
			var currentNodeData : XMLList = model.currentNodeData;
			
			nextNodeID = currentNodeData.complete.@value;
			model.gotoNode(nextNodeID);
		}
		
		public function gotoNode(nextNodeID : *) : void 
		{
			model.gotoNode(nextNodeID);
		}
	}
}
