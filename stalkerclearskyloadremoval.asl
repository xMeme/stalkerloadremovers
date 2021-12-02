state("xrEngine")
{
	bool Loading: 0x969D8;
	bool Escape: "xrGame.dll", 0x606622;
	int Sync: "xrGame.dll", 0x606621;
	bool OldLoad: "xrGame.dll", 0x4DAC10, 0x688;
	float onSync: "xrEngine.exe", 0x96D50;
}

init {
	refreshRate = 60;
}

isLoading
{
	return !current.OldLoad || !current.Loading || current.Sync == 1 || old.Sync == 1 || current.Escape || (current.onSync>0.09 && current.onSync<0.11);
}


