state("XR_3DA","1.0006")
{
	bool Loading: "xrNetServer.dll", 0x13E84;
	bool NoControl:	"xrGame.dll", 0x560668;
	bool isPaused: "XR_3DA.exe", 0x10BCD0;
	float sync: "XR_3DA.exe", 0x10BE80;
	string20 CurMap: "xrCore.dll", 0xBF368, 0x4, 0x0, 0x40, 0x8, 0x28, 0x4;
	string5 End: "XR_3DA.exe", 0x10BDB0, 0x3C, 0x10, 0x0, 0x0, 0x44, 0xC, 0x12;
}
state("XR_3DA","1.0000")
{
	bool Loading: "xrNetServer.dll", 0xFAC4;
	bool NoControl:	"xrGame.dll", 0x54C2F9;
	bool isPaused: "XR_3DA.exe", 0x1047C0;
	float sync: "XR_3DA.exe", 0x104928;
	string20 CurMap: "xrCore.dll", 0xBA040, 0x4, 0x0, 0x40, 0x8, 0x20, 0x14;
	string5 End: "XR_3DA.exe", 0x1048BC, 0x54, 0x14, 0x0, 0x0, 0x44, 0xC, 0x12;
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
	settings.Add("fix", false, "Low PC Fix (incase of inaccurate LRT)");
	if (timer.CurrentTimingMethod == TimingMethod.RealTime)
	{
    	var timingMessage = MessageBox.Show
		(
        	"This game uses Load Removed Time (Game Time) as default timing method \n"+
        	"LiveSplit is currently set to show Real Time (RTA).\n"+
        	"Would you like to set the timing method to Game Time? This will make verification easier",
        	"LiveSplit | S.T.A.L.K.E.R.: Shadow of Chernobyl",
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
	timer.IsGameTimePaused = false;

	//print(modules.First().ModuleMemorySize.ToString());
	switch(modules.First().ModuleMemorySize)
	{
		case 1662976:
		    version = "1.0000";
			break;
		case 1613824:
		    version = "1.0000";
			break;
	}
	if(settings["fix"])
	{
		refreshRate = 30;
	}
}

start
{
    while (current.Loading && !old.Loading)
    {
        timer.IsGameTimePaused = true;
        return true;
    }
}
split
{
    return current.CurMap != old.CurMap && current.CurMap != "" && old.CurMap != "" && settings["autosplitter"] || current.End == "final";
}
isLoading
{
	return !current.Loading || (current.sync > 0.057 && current.sync < 0.11) || current.NoControl || !current.isPaused && current.sync == 0;
}
exit
{
	timer.IsGameTimePaused = true;
}
