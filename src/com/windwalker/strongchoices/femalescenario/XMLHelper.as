package com.windwalker.strongchoices.femalescenario 
{

	/**
	 * @author qngo
	 */
	public class XMLHelper 
	{
		private var xml : XML;
		private var nodeList : XMLList;
		
		public function XMLHelper($xml : XML)
		{
			xml = $xml;
			nodeList = xml.nodes.node;
		}

		public function getSrcByNodeID($ID : int) : String 
		{
			var node : XMLList = xml.nodes.node.(@id == $ID);
			
			return node.file.@src;
		}
	}
}
