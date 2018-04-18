package net.avdw.randomizer;

import openfl.events.Event;
import haxe.Json;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author Andrew van der Westhuizen
 */
class Main extends Sprite
{

	public static var bigTalk:Array<Dynamic>;
	public static var iceBreaker:Array<Dynamic>;
	public static var koans:Array<Dynamic>;
	
	public function new()
	{
		super();
		
		bigTalk = Json.parse(Assets.getText("json/big-talk.json"));
		iceBreaker = Json.parse(Assets.getText("json/ice-breaker.json"));
		koans = Json.parse(Assets.getText("json/koans.json"));
		
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		
		addChild(new Menu());
	}

}