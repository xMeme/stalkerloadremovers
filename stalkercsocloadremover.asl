state("XR_3DA","1.0006")
{
	bool Loading: 	"xrNetServer.dll", 0x13E84;
	bool NoControl:	"xrGame.dll",0x560668;
	float sync:		0x10BE80;
}
state("XR_3DA","1.0000")
{
	bool Loading: 	"xrNetServer.dll",0xFAC4;
	bool NoControl:	"xrGame.dll",0x54C2F9;
	float sync:		0x104928;
}
update
{

	vars.doSplit = false;
	vars.Loading = false;
	if (!current.Loading || (current.sync > 0.09 && current.sync < 0.11)|| current.NoControl)
	{
		vars.Loading = true; 
		//условие сплита
		if(current.NoControl && !vars.SplitDone){
			vars.doSplit = true;
			vars.SplitDone = true;
		}
	} 
	else
	{
		vars.Loading = false;
		vars.SplitDone = false;
	}
}

startup
{
	settings.Add("fix", false, "Low PC Fix (false splitting, etc)");
	refreshRate = 60;
}

init
{
	if(modules.First().ModuleMemorySize == 1662976)
	{
		version = "1.0000";
	}
	else{
		version = "1.0006";
	}
	if(settings["fix"]){
		refreshRate = 40;
	}
	vars.doSplit = false;
	vars.Loading = false;
	vars.SplitDone = false;
}
split
{
	return vars.doSplit;
}
isLoading
{
	return vars.Loading;
}
