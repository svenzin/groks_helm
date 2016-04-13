package helm;
import flash.geom.Point;
import lde.Key;
import lde.Lde;
import lde.gfx.Animation;
import lde.Lde.Entity;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.ui.Keyboard;

/**
 * ...
 * @author scorder
 */
class Graphics
{
	static var data : BitmapData = null;
	static function tile(x : Int, y : Int)
	{
		if (data == null)
		{
			data = Assets.getBitmapData("img/tiles.png");
		}
		var t = new BitmapData(16, 16);
		t.copyPixels(data, new Rectangle(16 * x, 16 * y, 16, 16), new Point(0, 0));
		return t;
	}
	static function slice(tiles : Array<Array<Int>>)
	{
		var t = new Animation();
		for (xy in tiles) 
		{
			t.frames.push(tile(xy[0], xy[1]));
		}
		return t;
	}
	static function rect(width : Int, height : Int, color : Int)
	{
		var t = new Animation();
		t.frames.push(new BitmapData(width, height, false, color));
		return t;
	}
	public static var table : Animation;
	public static var ground_1 : Animation;
	public static var ground_2 : Animation;
	public static var wall : Animation;
	public static var waiter : Animation;
	public static var patron : Animation;
	public static function load()
	{
		table = slice([ [ 10, 2] ]);
		ground_1 = slice([ [ 0, 0 ] ]);
		ground_2 = slice([ [ 1, 0 ] ]);
		wall = slice([ [ 0, 3 ] ]);
		waiter = slice([ [0, 5], [1, 5], [2, 5], [3, 5], [4, 5], [5, 5], [6, 5], [7, 5] ]);
		patron = slice([ [0, 4], [1, 4], [2, 4], [3, 4], [4, 4], [5, 4], [6, 4], [7, 4] ]);
	}
}
class LevelOne
{
	var bg = new Array<Entity>();
	var walls = new Array<Entity>();
	var waiter = new Entity();
	var patrons = new Array<Entity>();
	var tables = new Array<Entity>();
	
	public function new() 
	{
		var map = [
			"##############",
			"#            #",
			"#b @         #",
			"#b           #",
			"#b      &O   #",
			"#b           #",
			"#            #",
			"##############"
			];
		var width = map[0].length;
		var height = map.length;
		
		var f = function (x, y, gfx)
		{
			var e = new Entity();
			e.x = 16 * x;
			e.y = 16 * y;
			e.play(gfx);
			return e;
		}
		for (i in 0...width)
		{
			for (j in 0...height) 
			{
				var e = new Entity();
				e.x = 16 * i;
				e.y = 16 * j;
				if (((i + j) % 2) == 0) e.play(Graphics.ground_1);
				else                    e.play(Graphics.ground_2);
				bg.push(e);
				
				switch (map[j].charAt(i))
				{
					case "#": walls.push(f(i, j, Graphics.wall));
					case "b": tables.push(f(i, j, Graphics.table));
					case "O": tables.push(f(i, j, Graphics.table));
					case "&": patrons.push(f(i, j, Graphics.patron));
					case "@": { waiter = f(i, j, Graphics.waiter); waiter.graphics.loop().speed(0.1); }
				}
			}
		}
		
		for (e in bg) Lde.add(e);
		for (e in patrons) Lde.add(e);
		for (e in tables) Lde.add(e);
		for (e in walls) Lde.add(e); 
		Lde.add(waiter);
	}
	
	public function step()
	{
		if (Key.isDown(Keyboard.LEFT)) waiter.x -= 1;
		if (Key.isDown(Keyboard.RIGHT)) waiter.x += 1;
		if (Key.isDown(Keyboard.UP)) waiter.y -= 1;
		if (Key.isDown(Keyboard.DOWN)) waiter.y += 1;
		if (Key.isPushed(Keyboard.SPACE))
		{
			if (waiter.graphics._running) waiter.graphics.pause();
			else waiter.graphics.resume();
		}
	}
}