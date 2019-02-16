state("XR_3DA")
{
	bool Loading: 0x10BB58;
}

state("xrEngine", "CS")
{
	bool Loading: "xrGame.dll", 0x4DAC10, 0x688;
}

state("xrEngine", "CoP")
{
	bool Loading: "xrGame.dll", 0x512CC4, 0x14;
}

init
{
	if (modules.First().FileVersionInfo.FileDescription == "X-Ray 1.6 Engine")
		version = "CoP";
	else if (game.ProcessName != "XR_3DA")
		version = "CS";
}

isLoading
{
	return !current.Loading;
}

exit
{
	timer.IsGameTimePaused = true;
}
