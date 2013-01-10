package collections 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * @author qngo
	 */
	public class ItemCollection extends EventDispatcher 
	{
		private var collection : Array;
		
		public function ItemCollection()
		{
			collection = new Array();
		}
		
		public function get count() : uint 
		{
			return collection.length;
		}
		
		public function addItem(item : Sprite) : void 
		{
			collection.push(item);
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function removeItem(item : Sprite) : void 
		{
			var myItem : Sprite = item;
			var total : int = collection.length;
			
			for(var i : int = 0; i < total; i++) 
			{
				if(Sprite(collection[i])== myItem) 
				{
					collection.splice(i, 1);
					break;
				}
			}
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function getItem(index : uint) : Sprite 
		{	
			return Sprite(collection[index]);
		}
	}
}
