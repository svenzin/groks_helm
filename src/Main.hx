package;

import lde.Lde;
import openfl.display.BitmapData;
import openfl.Lib;
import openfl.events.Event;

/**
 * ...
 * @author scorder
 */
class Main
{
	var WIDTH = 640;
	var HEIGHT = 360;
	var SCALE = 2;
	
	var item : Entity;
	var items = new List<Entity>();
	public function new() 
	{
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, step);
		
		Lde.init(WIDTH, HEIGHT, SCALE);
		
		for (i in 0...1000)
		{
			var e = new Entity();
			e.x = Math.random() * (WIDTH - 20);
			e.y = Math.random() * (HEIGHT - 20);
			e.data = new BitmapData(20, 20, false,
				Std.int(Math.random() * 0xffffff));
			
			items.add(e);
			Lde.add(e);
		}
		
		item = new Entity();
		item.x = 0;
		item.y = 0;
		item.data = new BitmapData(20, 20, false, 0xff0000);
		Lde.add(item);
	}
	
	var i = 0;
	public function step(_)
	{
		i = i + 1;
		item.x = 100 + 100 * Math.sin(i / 100);
		item.y = 100 + 100 * Math.cos(i / 100);
		
	}

}
