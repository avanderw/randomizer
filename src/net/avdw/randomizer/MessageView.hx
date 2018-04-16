package net.avdw.randomizer;

import haxe.Json;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.events.Event;
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
	var format:TextFormat;
	var bg:Sprite = new Sprite();
	var sign:TextField = new TextField();
	var boundary:Int = 15;
	var message:String;

	public function new(message:String)
	{
		super();

		try
		{
		this.message = message;
		format = new TextFormat(Assets.getFont("font/OpenSans-Regular.ttf").fontName, 12);
		format.align = TextFormatAlign.CENTER;

		addEventListener(Event.ADDED_TO_STAGE, added);
		}
		catch (e:Dynamic)
		{
			trace(e);
		}
	}

	function resize(e:Event):Void
	{
		trace("resize");
		bg.x = (stage.stageWidth - bg.width) / 2;
		bg.y = (stage.stageHeight - bg.height) / 2;
		sign.x = stage.stageWidth - sign.width - boundary;
		sign.y = stage.stageHeight - sign.height - boundary;
	}

	function added(e:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		try
		{
			var bigTalk:Array<Dynamic> = Json.parse(Assets.getText("json/big-talk.json"));
			var iceBreaker:Array<Dynamic> = Json.parse(Assets.getText("json/ice-breaker.json"));
			var koans:Array<Dynamic> = Json.parse(Assets.getText("json/koans.json"));

			trace(koans[Math.floor(Math.random() * koans.length)]);
			trace(bigTalk[Math.floor(Math.random() * bigTalk.length)]);
			trace(iceBreaker[Math.floor(Math.random() * iceBreaker.length)]);
			var txt:String = koans[Math.floor(Math.random() * koans.length)];
			txt = "\n" + txt;
			txt = txt.split(". ").join(".\n");
			txt = txt.split("\" ").join("\"\n");
			txt = txt.split(": ").join(":\n");
			txt = txt.split("\nsaid").join(" ");
			txt = txt.split("\nasked").join(" ");
			txt = txt.split("\nanswered").join(" ");
			txt = txt.split("\nsuggested").join(" ");
			txt = txt.split("\nthe").join(" ");
			if (txt.charCodeAt(txt.length - 1) != '\n'.code)
			{
				txt = txt + "\n";
			}

			sign.setTextFormat(format);
			sign.text = "@avanderw.co.za";
			sign.autoSize = TextFieldAutoSize.LEFT;
			addChild(sign);

			var text = new TextField();
			text.width = stage.stageWidth - 2 * boundary;
			text.multiline = true;
			text.wordWrap = true;
			text.setTextFormat(format);
			text.autoSize = TextFieldAutoSize.CENTER;
			text.text = txt;

			bg.graphics.lineStyle(1, 0x0);
			bg.graphics.beginFill(0xdddddd);
			bg.graphics.drawRoundRect(0, 0, text.width, text.height, boundary, boundary);
			bg.graphics.endFill();
			addChild(bg);
			bg.addChild(text);

			resize(null);

		}
		catch (e:Dynamic)
		{
			trace(e);
		}
	}

}