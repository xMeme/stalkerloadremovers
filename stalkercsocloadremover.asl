state("XR_3DA")
{
	int Loading: 0x10BB58;
	int Sync:	0x10BB8C;
}
update
{
	vars.doStart = false;
	vars.doSplit = false;
	vars.doReset = false;
	if (current.Loading == 0 || current.Sync == 1)
	{
		vars.Loading = true;
	}
	else
	{
		vars.Loading = false;
	}
	if(!vars.Started && !vars.doStart && vars.Quit.Current == 1 && vars.Quit.Old == 0 ){
		vars.doStart = true;
		vars.Started = true;
	} 
	if (current.Loading == 0 || current.Sync == 1)
	{
		vars.Loading = true;
		if (settings["locsplit"]) { 
			if(current.Sync == 1 && old.Sync == 0){
				vars.doSplit = true;
			}
		}
	}
	else
	{
		vars.Loading = false;
		vars.Quit.Update(game);
	}
	

	if(vars.Quit.Current == 0 && vars.Quit.Old == 1 && !vars.Loading){
		vars.doStart = false;
		vars.doReset = true;
		vars.Started = false;		
	}
	
}

startup
{
	refreshRate = 42;
	settings.Add("locsplit", true, "Split on next location");
}

init
{	
	vars.Started = false;
	vars.Quit = new MemoryWatcher<byte>(new DeepPointer("xrRender_R1.dll", 0x63578));
	vars.doReset = false;
	vars.doStart = false;
	vars.doSplit = false;
	vars.Loading = true;
}

split
{
	return vars.doSplit;
}

start
{
	return vars.doStart;
}

reset
{
	return vars.doReset;
}

isLoading
{
	return vars.Loading;
}
