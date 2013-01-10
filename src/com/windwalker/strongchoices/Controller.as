package com.windwalker.strongchoices 
{

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
			trace('model: ' + (model.state));
			model.update("START");
		}

		public function onPreClick() : Function 
		{
			return null;
		}
	}
}
