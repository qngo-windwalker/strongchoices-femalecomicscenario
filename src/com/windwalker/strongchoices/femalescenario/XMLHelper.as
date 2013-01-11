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

		public function getNextId(currentID : int) : int 
		{
			var node : XMLList = xml.nodes.node.(@id == currentID);
			return node.complete.@target;
		}

		public function getFirstNodeID() : int 
		{
			return xml.@begin_id;
		}
	}
}
