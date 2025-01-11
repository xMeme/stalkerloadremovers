state("xrEngine", "1.6.02")
{
	bool Loading: "xrGame.dll", 0x512CC4, 0x14;
	bool Load2:   0x913F5;
	byte OnLoad:  0x92E84;
	string20 CurMap: "xrCore.dll", 0xBE910, 0x18, 0x28, 0x0;
	float sync: "xrEngine.exe", 0x92EF4;
	string5 End: "xrGame.dll", 0x36C75D, 0xB0;
	string5 End2: "xrSound.dll", 0x27692, 0xACA;
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
	vars.x = 0;
	vars.doneMaps = new List<string>();
	timer.IsGameTimePaused = false;
}

isLoading
{
	if(vars.x == 0){
		vars.x = current.OnLoad;
	}
	if(old.Load2 && !current.Load2){
		vars.x = 0;
	}
	return current.OnLoad != vars.x || !current.Loading || current.Load2;
}

start
{
    return current.sync > 0.001 && current.sync < 0.11 && (old.sync == 0 && current.sync != old.sync) && current.Loading;
}

split
{
    if (current.CurMap != old.CurMap && !current.Loading && current.sync != 0 && settings["autosplitter"] || current.End == "outro" || current.End2 == "outro")
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
