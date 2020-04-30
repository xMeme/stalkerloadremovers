state("XR_3DA")
{
	int Loading: 	0x10BB58;
	int Sync:		0x10BB8C;
	int NoControl:	0x10BD18;
}

update
{

	vars.doStart = false;
	vars.doSplit = false;
	vars.doReset = false;
	
	vars.Quit.Update(game);
	vars.Load2.Update(game);

	if(!vars.Started && !vars.doStart && vars.Quit.Current == 1 && vars.Quit.Old == 0){
		vars.doStart = true;
		vars.Started = true;
	}
	if (current.Loading == 0 || current.Sync == 1 || vars.Escape.Current == 1 || vars.IsLag)
	{
		vars.Loading = true; 
		if(vars.Escape.Current == 1 && !vars.IsLag){
			if(settings["fix"]){
				vars.Escape.UpdateInterval = TimeSpan.FromMilliseconds(320);
			}else{
				vars.Escape.UpdateInterval = TimeSpan.FromMilliseconds(250);
			}
			vars.IsLag = true;
		}
		else{
			if(current.Loading == 0 || (vars.Escape.Current == 0 && vars.Load2.Current == 1 && vars.Escape.Changed)){
				vars.IsLag = false;
				vars.Escape.UpdateInterval = TimeSpan.Zero;
			}
		}

		
		if(current.Sync == 1 && old.Sync == 0){
			vars.doSplit = true;
		}
	} 
	else
	{
		vars.Loading = false;
	}
	
	if(!settings["fix"]){
		if(vars.Quit.Current == 0 && vars.Quit.Old == 1 && !vars.Loading && current.NoControl == 1){
			vars.doStart = false;
			vars.doReset = true;
			vars.Started = false;		
		}
	}
	vars.Escape.Update(game);
	
}

startup
{
	refreshRate = 48;
	settings.Add("fix", false, "Low PC Fix (false splitting, etc)");
}

init
{
	vars.Started = false;
	vars.IsLag = false;
	vars.Quit = new MemoryWatcher<byte>(new DeepPointer("ODE.dll", 0x2EA30));
	vars.Escape = new MemoryWatcher<byte>(new DeepPointer("xrGame.dll", 0x560668));
	vars.Load2 = new MemoryWatcher<byte>(new DeepPointer("xrNetServer.dll", 0x13E84));
	if(settings["fix"]){
		refreshRate = 40;
	}
	vars.doReset = false;
	vars.doStart = false;
	vars.doSplit = false;
	vars.Loading = true;
	
}

split
{
	return vars.doSplit;
}

reset
{
	return vars.doReset;
}

start
{
	return vars.doStart;
}

isLoading
{
	return vars.Loading;
}
