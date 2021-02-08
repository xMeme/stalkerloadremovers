state ("XR_3DA","classic")
{
	 bool Loading: "XR_3DA.exe", 0xA8420;
	 bool presskey: "XR_3DA.exe", 0xA73AC;
	 bool plashka: "xrGame.dll", 0x6A8C42;
}	

state ("XR_3DA","extended")
{
	 bool Loading: "XR_3DA.exe", 0xA8430;
	 bool presskey: "XR_3DA.exe", 0xA73BC;
	 bool plashka: "xrGame.dll", 0x6AED86;
}	

isLoading
{
	return !current.Loading || current.presskey || current.plashka;
}
split
{
	if(current.plashka)
	{
		if(!vars.splitDone)
		{
			vars.splitDone = true;
			return true;
		}
	}
	else
	{
		vars.splitDone = false;
	}
	
}
startup
{
	settings.Add("fix", false, "Low PC Fix (false splitting, etc)");
	refreshRate = 60;
}

init
{
	if(modules.First().ModuleMemorySize==1556480)
	{
		version = "extended";
	}
	else
	{
		version = "classic";
	}
	if(settings["fix"])
	{
		refreshRate = 40;
	}
	vars.splitDone = false;
}
