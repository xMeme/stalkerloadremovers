state("XR_3DA","1.0006")
{
	bool Loading: "xrNetServer.dll", 0x13E84;
	bool NoControl:	"xrGame.dll", 0x560668;
	float sync: "XR_3DA.exe", 0x10BE80;
	string20 CurMap: "xrCore.dll", 0xBF368, 0x4, 0x0, 0x40, 0x8, 0x28, 0x4;
	string21 End: "XR_3DA.exe", 0x171DD4, 0x180;
	string15 TrueEnd: "XR_3DA.exe", 0x7D0F8, 0x1CE;
}
state("XR_3DA","1.0000")
{
	bool Loading: "xrNetServer.dll", 0xFAC4;
	bool NoControl:	"xrGame.dll", 0x54C2F9;
	float sync: "XR_3DA.exe", 0x104928;
	string20 CurMap: "xrCore.dll", 0xBA040, 0x4, 0x0, 0x40, 0x8, 0x20, 0x14;
	string21 End: "XR_3DA.exe", 0x10A878, 0xBC;
	string15 TrueEnd: "XR_3DA.exe", 0x4163C, 0xD30;
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
	vars.doneMaps = new List<string>();
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
		refreshRate = 40;
	}
}

start
{
    return current.Loading && !old.Loading;
}
split
{
    if (current.CurMap != old.CurMap && !current.Loading && current.sync != 0 && settings["autosplitter"] || current.End == "final_immortal.ogm" && current.sync == 0 || current.End == "final_gold.ogm" && current.sync == 0 || current.End == "final_apocal.ogm" && current.sync == 0 || current.End == "final_blind.ogm" && current.sync == 0 || current.End == "final_to_monolith.ogm" && current.sync == 0 || current.TrueEnd == "final_peace.ogm" && current.sync == 0)
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
	return !current.Loading || (current.sync > 0.09 && current.sync < 0.11) || current.NoControl;
}
exit
{
	timer.IsGameTimePaused = true;
}
