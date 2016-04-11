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
class Animation
{
	public var i : Int;
	public var data : Array<BitmapData>;
	public function new()
	{
		i = 0;
		data = new Array<BitmapData>();
	}
}
class Entity
{
	public function new()
	{
		anim = null;
	}
	public var x : Float;
	public var y : Float;
	public var anim : Animation;
	public function render(surface : Bitmap)
	{
		if (anim != null)
		{
			var data = anim.data[anim.i];
			surface.bitmapData.copyPixels(data, data.rect, new Point(x, y));
		}
	}
}
interface IGame
{
	public var WIDTH : Int;
	public var HEIGHT : Int;
	public var SCALE : Int;
	public function init() : Void;
	public function step() : Void;
}
class Lde
{
	static var _game : IGame;
	public static function run(game : IGame)
	{
		_game = game;
		init(_game.WIDTH, _game.HEIGHT, _game.SCALE);
	}
	
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
		
		Key.init();
		
		_game.init();
	}
	
	public static var frame = 0;
	static public function step(_)
	{
		_game.step();
		
		++frame;
		
		surface.bitmapData.fillRect(surface.bitmapData.rect, 0x000080);
		for (object in objects)
		{
			object.render(surface);
		}
		
		Key.step();
	}
}