state("xrEngine")
{
	bool Loading: 0x969D8;
	int Sync: "xrGame.dll", 0x606621;
	bool OldLoad: "xrGame.dll", 0x4DAC10, 0x688;
	byte OnLoad: "xrEngine.exe", 0x8DDC, 0x10;
	float onSync: "xrEngine.exe", 0x96D50;
	byte NoControl: "xrGame.dll", 0x606320;
	string5 Start: "xrGame.dll", 0x2A6B19, 0xE1;
	string21 CurMap: "xrCore.dll", 0xBE718, 0x18, 0x20, 0x50;
	string10 End: "xrEngine.exe", 0x96CC0, 0x30, 0x10, 0x4, 0x34, 0x4, 0xC, 0x16;
}

startup
{
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
    vars.doneMaps = new List<string>();
	vars.x = 0;
	vars.running = 0;
	timer.IsGameTimePaused = false;
}

start
{
	return current.NoControl == 1 && current.Start == "intro";
}

split
{
    if (current.CurMap != old.CurMap && vars.running == true || current.End == "outro_half")
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
	if (vars.x == 0)
	{
		vars.x = current.OnLoad;
	}
	if (current.Sync == 1)
	{
		vars.x = 0;
	}
	vars.running =  current.OnLoad != vars.x || !current.OldLoad || !current.Loading || current.Sync == 1 || old.Sync == 1 || (current.onSync>0.09 && current.onSync<0.11);
	return vars.running;
}

exit
{
	timer.IsGameTimePaused = true;
}
