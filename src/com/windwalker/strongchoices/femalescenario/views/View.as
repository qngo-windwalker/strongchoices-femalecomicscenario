package com.windwalker.strongchoices.femalescenario.views 
{
	import qhn.mvc.view.CompositeView;

	import com.windwalker.strongchoices.femalescenario.Controller;
	import com.windwalker.strongchoices.femalescenario.Model;

	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * @author Quan
	 */
	public class View extends CompositeView 
	{
		private var disObj : DisplayObject;
		
		public function View(aModel : Object, aController : Object = null)
		{
			super(aModel, aController);
		}

		override public function update(event : Event = null) : void
		{
			switch((model as Model).state)
			{
				case "LOAD_COMPLETE":
					// If there's old content then remove old content.
					if (disObj) removeChild(disObj);
					
					// Display new content.					
					displayContent((model as Model).currentContent);
					break;
				default:
			}
			
			super.update(event);
		}

		private function displayContent($disObj : DisplayObject) : void 
		{
			disObj = $disObj;
			var type : String = (model as Model).currentNodeData.@type;
			switch(type)
			{
				case "eval":
					disObj.addEventListener(Event.COMPLETE, onContentComplete);
					break;
				default:
			}
			addChild(disObj);	
		}

		private function onContentComplete(event : Event) : void 
		{
			var selectedValue : String = String(event.target.value);
			
			// Parsing out the available option in the XML.
			var valueOptions : String = String((model as Model).currentNodeData.complete.@value);
			
			// Return example 0:4,1:25,3:34
			var valueCollection : Array = valueOptions.split(',');
			for (var i : int = 0; i < valueCollection.length; i++) 
			{
				var keyValuePair : String = valueCollection[i];
				var keyValuePairCollection : Array = keyValuePair.split(':');
				
				// If the selected value matches with the key, get the value.
				if (selectedValue == keyValuePairCollection[0])
				{
					var nextNodeID = keyValuePairCollection[1];
					(controller as Controller).gotoNode(nextNodeID);
					break;
				}
			}
			
			disObj.removeEventListener(Event.COMPLETE, onContentComplete);
		}
	}
}
