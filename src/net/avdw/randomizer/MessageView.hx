package net.avdw.randomizer;

import openfl.Assets;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author Andrew van der Westhuizen
 */
class MessageView extends Sprite
{
	var main:Main;
	var format:TextFormat;
	var bg:Sprite = new Sprite();
	var sign:TextField = new TextField();
	var boundary:Int = 15;
	var messages:Array<Dynamic>;
	var displayMessage:String;
	var displayHistory:Array<String> = new Array();
	var tf:TextField;

	public function new(messages:Array<Dynamic>)
	{
		super();

		try
		{
			format = new TextFormat(Assets.getFont("font/OpenSans-Regular.ttf").fontName, 12);
			format.align = TextFormatAlign.CENTER;
			
			tf = new TextField();
			tf.selectable = false;
			tf.multiline = true;
			tf.wordWrap = true;
			tf.setTextFormat(format);
			tf.autoSize = TextFieldAutoSize.CENTER;
			bg.addChild(tf);
			addChild(bg);

			this.messages = messages;

			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		catch (e:Dynamic)
		{
			trace(e);
		}
	}

	function resize(?e:Event):Void
	{
		try
		{
			trace("resize");
			tf.width = stage.stageWidth - 2 * boundary;
			
			bg.graphics.clear();
			bg.graphics.lineStyle(1, 0x0);
			bg.graphics.beginFill(0xdddddd);
			bg.graphics.drawRoundRect(0, 0, tf.width, tf.height, boundary, boundary);
			bg.graphics.endFill();
			
			bg.x = Math.round((stage.stageWidth - bg.width) / 2);
			bg.y = Math.round((stage.stageHeight - bg.height) / 2);
			sign.x = Math.round(stage.stageWidth - sign.width - boundary);
			sign.y = Math.round(stage.stageHeight - sign.height - boundary);
		}
		catch (e:Dynamic)
		{
			trace(e);
		}
	}

	function added(e:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		addEventListener(Event.REMOVED_FROM_STAGE, removed);

		main = cast (parent, Main);
		stage.addEventListener(Event.RESIZE, resize);
		stage.addEventListener(GestureEvent.SWIPE_LEFT, previousMessage);
		stage.addEventListener(GestureEvent.SWIPE_RIGHT, nextMessage);

		addChild(new Button("Back", function(e:MouseEvent)
		{
			main.restoreDisplay();
		}, boundary));

		try
		{
			sign.setTextFormat(format);
			sign.text = "@avanderw.co.za";
			sign.autoSize = TextFieldAutoSize.LEFT;
			addChild(sign);

			nextMessage();
		}
		catch (e:Dynamic)
		{
			trace(e);
		}
	}

	function removed(e:Event):Void
	{
		removeEventListener(Event.REMOVED_FROM_STAGE, removed);

		stage.removeEventListener(Event.RESIZE, resize);
		stage.removeEventListener(GestureEvent.SWIPE_LEFT, previousMessage);
		stage.removeEventListener(GestureEvent.SWIPE_RIGHT, nextMessage);
	}

	function nextMessage(?e:Event):Void
	{
		if (displayMessage != null)
		{
			displayHistory.push(displayMessage);
		}

		try {
			var message:String = messages[Math.floor(Math.random() * messages.length)];
			message = "\n" + message;
			message = message.split(". ").join(".\n");
			message = message.split("\" ").join("\"\n");
			message = message.split(": ").join(":\n");
			message = message.split("\nsaid").join(" ");
			message = message.split("\nasked").join(" ");
			message = message.split("\nanswered").join(" ");
			message = message.split("\nsuggested").join(" ");
			message = message.split("\nthe").join(" ");
			message = message.split("\nshe").join(" ");
			message = message.split("\nhe").join(" ");
			message = message.split("\ncommented").join(" ");
			message = message.split("\nconsented").join(" ");
			message = message.split("\ninquired").join(" ");
			message = message.split("\nreplied").join(" ");
			message = message.split("\ndemanded").join(" ");
			if (message.charCodeAt(message.length - 1) != '\n'.code)
			{
				message = message + "\n";
			}

			display(message);
		}
		catch (e:Dynamic)
		{
			trace(e);
		}
	}

	function previousMessage(e:Event):Void
	{
		if (displayHistory.length > 0)
		{
			display(displayHistory.pop());
		}
		else {
			main.restoreDisplay();
		}
	}

	function display(message:String)
	{
		try
		{
			
			tf.text = message;

			resize();

			displayMessage = message;
		}
		catch (e:Dynamic)
		{
			trace(e);
		}
	}

}