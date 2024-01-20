state("xrEngine")
{
	bool Loading: 0x969D8;
	bool Escape: "xrGame.dll", 0x606622;
	int Sync: "xrGame.dll", 0x606621;
	bool OldLoad: "xrGame.dll", 0x4DAC10, 0x688;
	byte OnLoad: "xrEngine.exe", 0x8DDC, 0x10;
	float onSync: "xrEngine.exe", 0x96D50;
}

init {
	refreshRate = 60;
	vars.x = 0;
	settings.Add("warps", false, "For SaveWarps");
	vars.running = 0;
}

isLoading
{
	if(vars.x == 0){
		vars.x = current.OnLoad;
	}
	if(current.Sync == 1){
		vars.x = 0;
	}
	if(settings["warps"){
		vars.running =  current.OnLoad != vars.x || !current.OldLoad || !current.Loading || current.Sync == 1 || old.Sync == 1 || (current.onSync>0.09 && current.onSync<0.11);
	}else{
		vars.running =  current.OnLoad != vars.x || !current.OldLoad || !current.Loading || current.Sync == 1 || old.Sync == 1 || current.Escape || (current.onSync>0.09 && current.onSync<0.11);
	}
	return vars.running;
}
exit
{
    timer.IsGameTimePaused = true;
}
