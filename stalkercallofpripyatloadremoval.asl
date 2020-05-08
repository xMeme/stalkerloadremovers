state("xrEngine")
{
	bool Loading: "xrGame.dll", 0x512CC4, 0x14;
	bool Load2:   0x913F5;
	byte OnLoad:  0x92E84;
}

init {
	refreshRate = 60;
	vars.x = 0;
}

isLoading
{
	if(vars.x == 0){
		vars.x = current.OnLoad;
	}
	if(old.Load2 && !current.Load2){
		vars.x = 0;
	}
	return current.OnLoad != vars.x || !current.Loading || current.Load2;
}
