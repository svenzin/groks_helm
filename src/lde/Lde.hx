package lde;
import openfl.Lib;
import openfl.events.Event;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.geom.Point;

/**
 * ...
 * @author scorder
 */
class Entity
{
	public function new() { }
	public var x : Float;
	public var y : Float;
	public var data : BitmapData;
}

class Lde
{
	static var objects : List<Entity>;
	static public function add(object : Entity)
	{
		objects.add(object);
	}
	
	static var surface : Bitmap;
	static public function init(width : Int, height : Int, scale : Int = 1)
	{
		var data = new BitmapData(width, height, false);
		surface = new Bitmap(data, "always", false);
		surface.x = 0;
		surface.y = 0;
		surface.scaleX = scale;
		surface.scaleY = scale;
		
		objects = new List<Entity>();
		
		Lib.current.stage.addChild(surface);
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, step);
	}
	
	static public function step(_)
	{
		surface.bitmapData.fillRect(surface.bitmapData.rect, 0x000080);
		for (object in objects)
		{
			surface.bitmapData.copyPixels(
				object.data,
				object.data.rect,
				new Point(object.x, object.y));
		}
	}
}