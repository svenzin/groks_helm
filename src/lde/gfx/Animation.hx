package lde.gfx;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.geom.Point;

/**
 * ...
 * @author scorder
 */
class Animation
{
	public var frames : Array<BitmapData>;
	public function new()
	{
		frames = new Array<BitmapData>();
	}
	public function renderFrameAt(i : Int, p : Point, surface : Bitmap)
	{
		surface.bitmapData.copyPixels(frames[i], frames[i].rect, p);
	}
}
