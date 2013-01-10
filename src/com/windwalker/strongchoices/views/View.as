package com.windwalker.strongchoices.views 
{
	import qhn.mvc.view.CompositeView;

	import com.windwalker.strongchoices.Model;

	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * @author Quan
	 */
	public class View extends CompositeView 
	{
		private var mc : MovieClip;

		public function View(aModel : Object, aController : Object = null)
		{
			super(aModel, aController);
		}

		override public function update(event : Event = null) : void
		{
			switch((model as Model).state)
			{
				case "LOAD_COMPLETE":
					trace("dfd");
					addChild((model as Model).getContent('appContent'));	
					break;
				default:
			}
			
			super.update(event);
		}
	}
}
