state("xrEngine")
{
	bool Loading: "xrGame.dll", 0x512CC4, 0x14;
	bool Load2:   0x913F5;
}

isLoading
{
	return !current.Loading || current.Load2;
}
