state("XR_3DA")
{
	bool Loading: 0x10BB58;
}

state("xrEngine", "Clear Sky")
{
	bool Loading: "xrGame.dll", 0x4DAC10, 0x688;
}

state("xrEngine", "Call of Pripyat")
{
	bool Loading: "xrGame.dll", 0x512CC4, 0x14;
}

init
{
	if (modules.First().ModuleMemorySize == 1961984)
		version = "Call of Pripyat";
	else if (modules.First().ModuleMemorySize == 1720320)
		version = "Clear Sky";
}

isLoading
{
	return !current.Loading;
}

exit
{	
	timer.IsGameTimePaused = true;
}
