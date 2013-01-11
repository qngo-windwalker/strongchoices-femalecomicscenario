package com.windwalker.strongchoices.femalescenario 
{
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
			var id : int = userHistory.pop(); // Remove previous one and reference it.
			model.gotoNode(id);  
		}

		public function onNextClick(event : Event = null) : void 
		{
			// NOTE: An unset datatype 'int' is the same as 0
			// Example 'var i : int = null' is the same as 'var i = 0';

			var currentID : int = model.currentNodeID;
//			currentID++;
//			model.gotoNode(currentID);  
			model.forward(currentID);  
		}
	}
}
