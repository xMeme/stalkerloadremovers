state("xrEngine", "1.5.10")
{
	bool Loading: "xrNetServer.dll", 0x13E04;
	float sync: "xrEngine.exe", 0x96D50;
	bool NoControl: "xrGame.dll", 0x606320;
	string5 Start: "xrGame.dll", 0x2A6B19, 0xE1;
	string21 CurMap: "xrCore.dll", 0xBE718, 0x18, 0x28, 0x0;
	string10 End: "xrEngine.exe", 0x96CC0, 0x30, 0x10, 0x4, 0x34, 0x4, 0xC, 0x16;
}

startup
{
	settings.Add("autosplitter", true, "Autosplit per level - Автосплит для каждого уровня");
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
        	"LiveSplit | S.T.A.L.K.E.R.: Clear Sky",
        	MessageBoxButtons.YesNo,MessageBoxIcon.Question
		);
        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
	refreshRate = 60;
}

init 
{
	//print(modules.First().ModuleMemorySize.ToString());
	vars.doneMaps = new List<string>();
	timer.IsGameTimePaused = false;
}

start
{
	return current.NoControl && !old.NoControl && current.Start == "intro";
}

split
{
    if (current.CurMap != old.CurMap && !current.Loading && current.sync != 0 && settings["autosplitter"] || current.End == "outro_half")
	{
		vars.doneMaps.Add(current.CurMap);
		return true;
	}
}

onReset
{
	vars.doneMaps.Clear();
}

isLoading
{
	return !current.Loading || (current.sync > 0.08 && current.sync < 0.11) || (current.sync > 0.00000019 && current.sync < 0.00000021);
}

exit
{
	timer.IsGameTimePaused = true;
}
