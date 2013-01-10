package com.windwalker.strongchoices 
{

	/**
	 * @author qngo
	 */
	public class GlobalData 
	{
		public var dataType : String;
		
		private var _xml : XML;
		public var appSrc : String;
		public var contentCollection : Array = new Array();

		public function GlobalData($dataType : String)
		{
			dataType = $dataType;
		}
		
		public function set xml ($xml : XML)
		{
			_xml = $xml;
			appSrc = _xml.app_src.@value;
		}

		public function setContent(string : String, content : *) : void 
		{
			contentCollection[string] = content;
		}
	}
}
