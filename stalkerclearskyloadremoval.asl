state("xrEngine", "1.5.10")
{
	byte Loading: "xrGame.dll", 0x6072F4, 0x8, 0x94, 0xFC, 0xD4, 0x48, 0x3CC;
	byte OnLoad: "xrGame.dll", 0x39517D, 0x23;
	float onSync: "xrEngine.exe", 0x96D50;
	byte NoControl: "xrGame.dll", 0x606320;
	string5 Start: "xrGame.dll", 0x2A6B19, 0xE1;
	string21 CurMap: "xrCore.dll", 0xBE718, 0x18, 0x28, 0x0;
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
	timer.IsGameTimePaused = false;
}

start
{
	return current.NoControl == 1 && current.Start == "intro";
}

split
{
    if (current.CurMap != old.CurMap && current.Loading == 1 || current.End == "outro_half")
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
	return current.Loading == 1 || (current.onSync>0.09 && current.onSync<0.11) || current.OnLoad == 1;
}

exit
{
	timer.IsGameTimePaused = true;
}
