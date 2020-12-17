state("XR_3DA")
{
	bool Loading: 	"xrNetServer.dll", 0x13E84;
	byte Sync:		0x10BB8C;
	byte QLoad:		0xFA40, 0x3C;
	byte Quit:		"ODE.dll", 0x2EA30;
	bool NoControl:	0x10BD18;
	float xpos: 	0x10BE94;
	float ypos: 	0x10BE98;
	float zpos: 	0x10BE9C;
	float sync:		0x10BE80;
}

update
{

	vars.doStart = false;
	vars.doSplit = false;
	vars.doReset = false;
	
	// условие старта таймера
	
	if(!vars.Started && !vars.doStart && current.Quit == 1 && old.Quit == 0){
		vars.doStart = true;
		vars.Started = true;
	}
	
	if ( vars.plashka || !current.Loading || current.Sync == 1 || vars.Escape.Current == 1 || (current.xpos==0.00 && current.ypos==0.00 && current.zpos==0.00 ) || (current.sync > 0.09 && current.sync < 0.11))
	{
		vars.Loading = true; 
		//условие сплита
		if(current.Sync == 1 && old.Sync == 0){
			vars.doSplit = true;
			vars.Escape.UpdateInterval = TimeSpan.Zero;
		}
	} 
	else
	{
		vars.Loading = false;
	}
	vars.Escape.Update(game);
}

startup
{
	settings.Add("fix", false, "Low PC Fix (false splitting, etc)");
	refreshRate = 60;
}

init
{
	if(settings["fix"]){
		refreshRate = 40;
	}
	vars.Escape = new MemoryWatcher<byte>(new DeepPointer("xrGame.dll", 0x560668));
	vars.Started = false;
	vars.doStart = false;
	vars.doSplit = false;
	vars.doReset = false;
	vars.Loading = true;
	vars.plashka = false;
	vars.xplashka = 0.00;
	vars.yplashka = 0.00;
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
