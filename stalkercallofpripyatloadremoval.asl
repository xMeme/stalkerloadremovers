state("xrEngine", "1.6.02")
{
	bool Loading: "xrNetServer.dll", 0x12E04;
	bool Load2: "xrEngine.exe", 0x913F5;
	string20 CurMap: "xrCore.dll", 0xBE910, 0x18, 0x28, 0x0;
	float sync: "xrEngine.exe", 0x92EF4;
	string5 end: "xrGame.dll", 0x64E058, 0x48, 0x24, 0x4, 0x8, 0x8, 0x8, 0xC, 0x10, 0x0; //works only in renderer_R1
}

startup
{
	settings.Add("autosplitter", false, "Autosplit per level - Автосплит для каждого уровня");
	settings.SetToolTip
	(
	"autosplitter",
	"Enable autosplitter on every level transition \n"+
	"Автоматическое переключение при переходе на локацию"
	);
	if (timer.CurrentTimingMethod == TimingMethod.RealTime)
	{        
		var timingMessage = MessageBox.Show
		(
			"This game uses Load Removed Time (Game Time) as default timing method \n"+
			"LiveSplit is currently set to show Real Time (RTA).\n"+
			"Would you like to set the timing method to Game Time? This will make verification easier",
			"LiveSplit | S.T.A.L.K.E.R.: Call of Pripyat",
			MessageBoxButtons.YesNo,MessageBoxIcon.Question
		);
		if (timingMessage == DialogResult.Yes)
		{
			timer.CurrentTimingMethod = TimingMethod.GameTime;
		}
	}
}

init {
	//print(modules.First().ModuleMemorySize.ToString());
	refreshRate = 60;
	vars.doneMaps = new List<string>();
	timer.IsGameTimePaused = false;
}

isLoading
{
	return !current.Loading || current.Load2 || (current.sync > 0.00000019 && current.sync < 0.00000021);
}

start
{
    return current.sync > 0.001 && current.sync < 0.11 && (old.sync == 0 && current.sync != old.sync) && current.Loading;
}

split
{
    if (current.CurMap != old.CurMap && !current.Loading && current.sync != 0 && settings["autosplitter"] || current.end == "outro")
	{
		vars.doneMaps.Add(current.CurMap);
		return true;
	}
}

onReset
{
	vars.doneMaps.Clear();
}

exit
{
	timer.IsGameTimePaused = true;
}
