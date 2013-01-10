package  
{
	import media.AudioPlayer;

	import com.windwalker.strongchoices.Controller;
	import com.windwalker.strongchoices.Model;
	import com.windwalker.strongchoices.views.View;

	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;

	/**
	 * @author qngo
	 */
	public class Main extends MovieClip 
	{
		private var audioPlayer : AudioPlayer;
		
		private var model : Model;
		private var view : View;
		private var controller : Controller;
		
		public function Main()
		{
					
			audioPlayer = AudioPlayer.getInstance();
			
			stop();
			
//			alpha = 0;
//			visible = false;
			
//			TweenPlugin.activate([AutoAlphaPlugin]);
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
//			audioPlayer.addMP3(
//				Sound(Library.createSound(this, "U1L11T2C5_1_mp3")),
//				Sound(Library.createSound(this, "U1L11T2C5_2_mp3")),
//				Sound(Library.createSound(this, "U1L11T2C5_3_mp3")),
//				Sound(Library.createSound(this, "U1L11T2C5_4_mp3"))
//			);
			
//			 initContent(); // testing
		}
		
		public function initContent() : void
		{
//			TweenLite.to(this, .5, {autoAlpha : 1, onComplete : play});
		}
		
		override public function stop() : void
		{
			super.stop();
			
			// These frames call stop() on the timeline.
			if (currentFrame == 1 || currentFrame == 67 || currentFrame == 68 || currentFrame == 69 || currentFrame == 103)
			{
				return;
			}
			audioPlayer.stop();
		}

		private function init(event : Event = null) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.CHANGE, onUpdate);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align     = StageAlign.TOP_LEFT;
			
			model = Model.getInstance();
			model.addEventListener(Event.COMPLETE, onModelComplete);
			model.addEventListener(Event.CHANGE, onModelChange);
			model.load(new URLRequest("xml/site.xml"));
			
			trace("main.fla :: init()");
		}
		
		private function onModelChange(event : Event) : void 
		{
			view.update(event);
		}

		private function onModelComplete(event : Event) : void 
		{
		}

		private function onUpdate(event : Event = null) : void 
		{
			switch(currentFrame)
			{
				case 67 :

				break;
				
				case 68 :
				
				break;
				
				case 69 :
				
				break;
				
				case 103 :
				
				break;
			}
		}
		
		private function onCorrectComplete(event : Event) : void
		{
			// Plays the last audio.
		}

		private function lastAudioComplete(event : Event) : void 
		{
			
			// Fades out and dispatch the event.
//			var assEvent : AssetEvent = new AssetEvent(AssetEvent.COMPLETE);
//			TweenLite.to(this, .5, {autoAlpha : 0, delay : .5, onComplete : dispatchEvent, onCompleteParams : [assEvent]});			
		}

		private function onIncorrectComplete(event : Event) : void
		{
		}

		private function onDragNDropComplete(event : Event) : void 
		{
		}
	}
}
