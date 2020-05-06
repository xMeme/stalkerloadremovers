state("xrEngine")
{
	bool Loading: 0x969D8;
	bool Escape: "xrGame.dll", 0x606622;
	int Sync: "xrGame.dll", 0x606621;
}

isLoading
{
	return !current.Loading || current.Sync == 1 || old.Sync == 1 || current.Escape;
}
