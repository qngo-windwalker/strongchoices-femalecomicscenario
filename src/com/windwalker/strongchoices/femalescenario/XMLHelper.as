package com.windwalker.strongchoices.femalescenario 
{

	/**
	 * @author qngo
	 */
	public class XMLHelper 
	{
		private var xml : XML;
		private var nodeList : XMLList;
		
		var node:Namespace = new Namespace("node", "http://www.test.com/weather/");
//		
//		var soapNS:Namespace = xml.namespace("node");
//		
		public function XMLHelper($xml : XML)
		{
			xml = $xml;
			xml.addNamespace(node);
			nodeList = xml.nodes.node;
		}

		public function getFirstNodeID() : String 
		{
			return xml.@first_node;
		}

		public function getNodeDataByID(id : String) : XMLList 
		{
			var node : XMLList = xml.nodes.node.(@id == id);
			return node;
		}
	}
}
