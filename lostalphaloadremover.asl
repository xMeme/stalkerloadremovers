state ("XR_3DA")
{
	 bool Loading: "XR_3DA.exe", 0xA8420;
}	

isLoading
{
	return !current.Loading;
}
