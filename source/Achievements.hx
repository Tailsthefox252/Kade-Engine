//im making an achievement system for fnf, not steam just ingame achievements like henry stickmin
package;

import flixel.math.FlxMath;
import flixel.group.FlxGroup;
import haxe.ds.StringMap;
import flixel.FlxG;
import flixel.FlxSprite;
import Song.SwagSong;
import flixel.FlxCamera;

class Achievements extends MusicBeatState
{
	var cameratomakezoomwork:FlxCamera = new FlxCamera();
	var unlockedAchievements:Array<Int> = [0];
	var LudumDare:Bool = false;
	var RulerofEveryAchievement = new FlxTypedGroup<FlxSprite>();
	var Titlestuffs = new FlxTypedGroup<Alphabet>();
	var AchievementsData:Array<StringMap<String>> = [
		["name" => "MILFest", "description" => "Beat Milf on all difficulties with an FC", "frame" => "0"],
		["name" => "Spooky Month Enthusiast", "description" => "Play Week 2 on October and FC it on all three difficulties", "frame" => "0"],
		["name" => "SPOOKY TIME", "description" => "Beat Week 1 in Story mode and unlock Week 2", "frame" => "1"],
		["name" => "Just like the game", "description" => "Funk on a Friday (real time)", "frame" => "2"],
		["name" => "Friday Night Funker", "description" => "Start the game", "frame" => "0"]
	];
	override function create()//need to add code so secret achievements are detected from your save file.
	{
		PlayState.BGThiefHaha('limo');
		var BrickThing:FlxSprite = new FlxSprite(FlxG.width * 0.18, 0).loadGraphic(Paths.image("achievements/bricks"), false);
		BrickThing.setGraphicSize(Std.int(BrickThing.width * 0.8), Std.int(BrickThing.height * 0.8));
		BrickThing.updateHitbox();
		BrickThing.y = FlxG.height * -0.25;
		add(BrickThing);
		
		var FunkyAchievementLogo:FlxSprite = new FlxSprite(FlxG.width * 0.26, FlxG.height * 0.045).loadGraphic(Paths.image("achievements/achievementlogo"), true, 1195, 298);
		FunkyAchievementLogo.animation.add("lil_shake", [0,1], 12);
		FunkyAchievementLogo.animation.play("lil_shake");
		FunkyAchievementLogo.setGraphicSize(Std.int(FunkyAchievementLogo.width / 2), Std.int(FunkyAchievementLogo.height / 2));
		FunkyAchievementLogo.updateHitbox();
		add(FunkyAchievementLogo);
		
		FlxG.cameras.reset(cameratomakezoomwork);//reset camera
		//DiscordClient.changePresence
		FlxCamera.defaultCameras = [cameratomakezoomwork];//set default camera to this
		
		
		
		Conductor.changeBPM(180); //zoom
		add(Titlestuffs);
		add(RulerofEveryAchievement);
		for (shit in AchievementsData)
		{
			
			var POSitionHeight = (FlxG.height * 0.25) + Std.int((75.6 + 6) * AchievementsData.indexOf(shit));
			var pleasekillme:FlxSprite = new FlxSprite(FlxG.width * 0.15, POSitionHeight).loadGraphic(Paths.image('achievements/achievements'), true, 765, 765);
			
			pleasekillme.animation.add("iconstuffs", [Std.parseInt(shit.get("frame"))], 0);//the above thing is using the top lefft corner as the position so you needta fix that, make it somehow calculate on its NEW SIZE
			trace(shit);
			
			var AchievementTitle:Alphabet = new Alphabet(0, POSitionHeight, shit.get("name"), true, false, true);
			AchievementTitle.x = pleasekillme.x + 76.5 + 8;
			RulerofEveryAchievement.add(pleasekillme);
			Titlestuffs.add(AchievementTitle);
			pleasekillme.animation.play("iconstuffs");
			pleasekillme.setGraphicSize((Std.int(pleasekillme.width * 0.1)), (Std.int(pleasekillme.width * 0.1)));
			pleasekillme.updateHitbox();
			trace(AchievementTitle);
			trace(FlxG.height);
		}
		FlxG.sound.playMusic(Paths.inst("milf"), 1);
	}
	
	override function update(elapsed:Float)
	{
		if (controls.BACK)
			FlxG.switchState(new MainMenuState());
			
		LudumDare = true;
		Conductor.songPosition = FlxG.sound.music.time;
		super.update(elapsed); //i think super inherits all calls to it from MusicBeatState aka if something there would call the original it also calls this.
		if (LudumDare)
			FlxG.camera.zoom = FlxMath.lerp(1.0, FlxG.camera.zoom, 0.95);
	}
	
	override function beatHit():Void
	{
		super.beatHit();
		
		trace("k");
		FlxG.camera.zoom += 0.015; //zoom
	}
}
