package com.windwalker.strongchoices.views 
{
	import com.windwalker.display.ProMovieClip;
	import qhn.mvc.view.CompositeView;

	import com.windwalker.strongchoices.Model;

	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * @author Quan
	 */
	public class View extends CompositeView 
	{
		private var mc : ProMovieClip;

		public function View(aModel : Object, aController : Object = null)
		{
			super(aModel, aController);
		}

		override public function update(event : Event = null) : void
		{
			switch((model as Model).state)
			{
				case "LOAD_COMPLETE":
					mc = ProMovieClip((model as Model).getContent('app_src'));
					mc.requiredDataSrc = (model as Model).flash_configXML.app_src.@requires;
					trace('mc.requiredDataSrc: ' + (mc.requiredDataSrc));
					addChild(mc);	
					break;
				default:
			}
			
			super.update(event);
		}
	}
}
