state("xrEngine")
{
	bool Loading: "xrGame.dll", 0x512CC4, 0x14;
}

isLoading
{
	return !current.Loading;
}
