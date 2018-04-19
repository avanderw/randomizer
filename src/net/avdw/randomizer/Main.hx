package net.avdw.randomizer;

import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.events.Event;

/**
 * ...
 * @author Andrew van der Westhuizen
 */
class Main extends Sprite
{
	var displaying:DisplayObject;
	var displayHistory:Array<DisplayObject> = new Array();
	

	public function new()
	{
		super();
		
		addChild(new Gestures());
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		
		display(new Menu());
	}

	public function display(displayObject:DisplayObject)
	{
		try
		{
			if (contains(displaying))
			{
				removeChild(displaying);
				displayHistory.push(displaying);
			}

			displaying = displayObject;
			addChild(displaying);
		}
		catch (e:Dynamic)
		{
			trace(e);
		}
	}

	public function restoreDisplay()
	{
		try
		{
			if (contains(displaying))
			{
				removeChild(displaying);
			}

			displaying = displayHistory.pop();
			addChild(displaying);
		}
		catch (e:Dynamic)
		{
			trace(e);
		}
	}

}