package media 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	/**
	 * @author qngo
	 */
	public class AudioPlayer extends EventDispatcher
	{
		private static var instance : AudioPlayer;
		
		private var channel : SoundChannel;
		private var position : Number = 0;
		
		private var instructionMp3 	: Sound;
		private var incorrectMp3	: Sound;
		private var correctMp3 		: Sound;
		private var whatWouldHappenMp3 : Sound;

		public function AudioPlayer(pvt : PrivateClass)
		{
			
		}
		
		public static function getInstance() : AudioPlayer
		{
			if (instance == null)
			{
				AudioPlayer.instance = new AudioPlayer(new PrivateClass());
			}
			
			return AudioPlayer.instance;
		}
		
		public function addMP3(instruction : Sound, incorrect : Sound, correct : Sound, wwh : Sound) : void
		{
			instructionMp3 = instruction;
			incorrectMp3 = incorrect;
			correctMp3 = correct;
			whatWouldHappenMp3 = wwh;
		}

		public function play(sound : String) : void
		{
			if (channel) channel.stop();
			switch (sound)
			{	
				case "1" :
					channel = instructionMp3.play();
				break;
					
				case "2":
					channel = incorrectMp3.play();
				break;
				
				case "3":
					channel = correctMp3.play();
				break;
				
				case "4":
					channel = whatWouldHappenMp3.play();
					channel.addEventListener(Event.SOUND_COMPLETE, onPlaybackComplete);
				break;
			}
		}

		public function stop() : void
		{
			if (channel)
			{
				position = channel.position;
	        	channel.stop();
			}
		}
		
		private function onPlaybackComplete(event : Event) : void 
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}

class PrivateClass
{
	public function PrivateClass()
	{
		
	}
}