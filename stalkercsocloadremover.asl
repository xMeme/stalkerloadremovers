state("XR_3DA")
{
	int Loading: 0x10BB58;
	int Sync:	0x10BB8C;
}
update
{
	vars.Loading = false;
	if (current.Loading == 0 || current.Sync == 1)
	{
		vars.Loading = true;
	}
}

isLoading
{
	return vars.Loading;
}
