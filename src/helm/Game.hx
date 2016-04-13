package helm;
import lde.Lde;
import lde.Key;
import lde.Lde.IGame;
import lde.Lde.Pointer;
import openfl.display.BitmapData;
import openfl.ui.Keyboard;
import openfl.ui.Mouse;

/**
 * ...
 * @author scorder
 */
class Game implements IGame
{
	public var WIDTH = 320;
	public var HEIGHT = 180;
	public var SCALE = 4;
	
	public function new() 
	{
	}
	
	var level : LevelOne;
	public function init()
	{
		LevelOne.Graphics.load();
		level = new LevelOne();
	}
	
	public function step()
	{
		level.step();
	}
}