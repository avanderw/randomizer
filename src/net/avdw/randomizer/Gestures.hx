package net.avdw.randomizer;

import openfl.display.DisplayObject;
import openfl.events.Event;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Andrew van der Westhuizen
 */
class Gestures extends DisplayObject
{

	var swipeMinimum:Int = 100;
	var startX:Float;
	var startY:Float;

	public function new()
	{
		super();

		addEventListener(Event.ADDED_TO_STAGE, added);
	}
	
	function added(e:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		
		stage.addEventListener(MouseEvent.MOUSE_DOWN, markMouseStart);
		stage.addEventListener(MouseEvent.MOUSE_UP, checkSwipeLeft);
		stage.addEventListener(MouseEvent.MOUSE_UP, checkSwipeRight);
	}
	
	function checkSwipeLeft(e:MouseEvent):Void 
	{
		if (e.stageX < startX && startX - e.stageX > swipeMinimum) {
			stage.dispatchEvent(new Event(GestureEvent.SWIPE_LEFT));			
		}
	}
	
	function checkSwipeRight(e:MouseEvent):Void {
		if (e.stageX > startX && e.stageX - startX > swipeMinimum) {
			stage.dispatchEvent(new Event(GestureEvent.SWIPE_RIGHT));
		}
	}
	
	function markMouseStart(e:MouseEvent):Void 
	{
		startX = e.stageX;
		startY = e.stageY;
	}
}