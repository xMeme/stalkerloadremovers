state("XR_3DA", "1.0006")
{
	bool Loading: 0x10BB58;
}

state("XR_3DA", "1.0000")
{
	bool Loading: "xrGame.dll", 0x3EBC58, 0xC;
}

init
{
	version = modules.Where(x => x.ModuleName == "xrGame.dll").First().ModuleMemorySize == 6344704 ? "1.0006" : "1.0000";
}

isLoading
{
	return version == "1.0006" ? !current.Loading : current.Loading;
}
