package helm;
import lde.Lde;
import lde.Key;
import lde.Lde.IGame;
import openfl.display.BitmapData;
import openfl.ui.Keyboard;

/**
 * ...
 * @author scorder
 */
class Game implements IGame
{
	public var WIDTH = 640;
	public var HEIGHT = 360;
	public var SCALE = 2;
	
	public function new() 
	{
	}
	
	var item : Entity;
	var items = new List<Entity>();
	public function init()
	{
		for (i in 0...1000)
		{
			var e = new Entity();
			e.x = Math.random() * (WIDTH - 20);
			e.y = Math.random() * (HEIGHT - 20);
			e.anim = new Animation();
			e.anim.data.push(new BitmapData(20, 20, false,
				Std.int(Math.random() * 0xffffff)));
			
			items.add(e);
			Lde.add(e);
		}
		
		item = new Entity();
		item.x = 0;
		item.y = 0;
		item.anim = new Animation();
		item.anim.data.push(new BitmapData(20, 20, false, 0xff0000));
		item.anim.data.push(new BitmapData(20, 20, false, 0xff4000));
		item.anim.data.push(new BitmapData(20, 20, false, 0xff8000));
		item.anim.data.push(new BitmapData(20, 20, false, 0xffc000));
		item.anim.data.push(new BitmapData(20, 20, false, 0xffff00));
		Lde.add(item);
	}
	
	public function step()
	{
		if (Key.isDown(Keyboard.A)) item.x -= 1;
		if (Key.isDown(Keyboard.D)) item.x += 1;
		if (Key.isDown(Keyboard.W)) item.y -= 1;
		if (Key.isDown(Keyboard.S)) item.y += 1;
		if (Key.isPushed(Keyboard.SPACE))
		{
			item.x = (WIDTH - item.anim.data[0].rect.width) / 2;
			item.y = (HEIGHT - item.anim.data[0].rect.height) / 2;
		}
		item.anim.i = Std.int(Lde.frame/10) % item.anim.data.length;
	}
}