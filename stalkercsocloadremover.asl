state("XR_3DA","1.0006 EU/NA Crack")
{
	bool Loading: "xrNetServer.dll", 0x13E84;
	bool NoControl:	"xrGame.dll",0x560668;
	float sync: 0x10BE80;
	string20 CurMap: "xrCore.dll", 0xBF368, 0x4, 0x0, 0x40, 0x8, 0x20, 0x54;
	string21 End: "xrCore.dll", 0x2120E, -3588;
	string15 TrueEnd: "XR_3DA.exe", 0x10BB70, 0x1C, 0x0, 0x28, 0x8, 0xDB5;
}
state("XR_3DA","1.0006 GOG")
{
	bool Loading: "xrNetServer.dll", 0x13E84;
	bool NoControl:	"xrGame.dll",0x560668;
	float sync: 0x10BE80;
	string20 CurMap: "xrCore.dll", 0xBF368, 0x30, 0x60, 0xD64;
	string21 End: "xrGame.dll", 0x306420, 0xE;
	string15 TrueEnd: "XR_3DA.exe", 0x10BB70, 0x1C, 0x0, 0x28, 0x8, 0xDB5;
}
state("XR_3DA","1.0000 EU/NA")
{
	bool Loading: "xrNetServer.dll",0xFAC4;
	bool NoControl:	"xrGame.dll",0x54C2F9;
	float sync: 0x104928;
	string20 CurMap: "xrCore.dll", 0xBA040, 0x4, 0x0, 0x40, 0x8, 0x28, 0x4;
	string21 End: "XR_3DA.exe", 0x90A4, 0x5F8;
	string15 TrueEnd: "XR_3DA.exe", 0x4163C, 0xD58;
}
state("XR_3DA","1.0000 RU Crack")
{
	bool Loading: "xrNetServer.dll",0xFAC4;
	bool NoControl:	"xrGame.dll",0x54C2F9;
	float sync: 0x104928;
	string20 CurMap: "xrCore.dll", 0xBA040, 0x4, 0x0, 0x20, 0x40, 0x8, 0x28, 0x4;
	string21 End: "XR_3DA.exe", 0x90A4, 0x5E4;
	string15 TrueEnd: "XR_3DA.exe", 0x4163C, 0xD44;
}
startup
{
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
	//print(modules.First().ModuleMemorySize.ToString());
	switch(modules.First().ModuleMemorySize)
	{
		case 1646592:
		    version = "1.0006 GOG";
			break;
		case 1662976:
		    version = "1.0000 RU Crack";
			break;
		case 1613824:
		    version = "1.0000 EU/NA";
			break;
	}
	if(settings["fix"]){
		refreshRate = 40;
	}
	vars.doneMaps = new List<string>();
	timer.IsGameTimePaused = false;
}

start
{
    return current.Loading && !old.Loading;
}
split
{
    if (current.CurMap != old.CurMap && !current.Loading || current.End == "final_immortal.ogm" || current.End == "final_gold.ogm" || current.End == "final_apocal.ogm" || current.End == "final_blind.ogm" || current.End == "final_to_monolith.ogm" || current.TrueEnd == "final_peace.ogm")
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
