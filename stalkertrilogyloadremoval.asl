state("XR_3DA")
{
	bool Loading: 	"xrNetServer.dll", 0x13E84;
	byte Sync:		0x10BB8C;
	byte QLoad:		0xFA40, 0x3C;
	byte Quit:		"ODE.dll", 0x2EA30;
	bool NoControl:	0x10BD18;
}

state("xrEngine", "CS")
{
	bool Loading: 0x969D8;
	bool Escape: "xrGame.dll", 0x606622;
	int Sync: "xrGame.dll", 0x606621;
	bool OldLoad: "xrGame.dll", 0x4DAC10, 0x688;
	byte OnLoad: "xrEngine.exe", 0x8DDC, 0x10;
}

state("xrEngine", "CoP")
{
	bool Loading: "xrGame.dll", 0x512CC4, 0x14;
	bool Load2:   0x913F5;
	byte OnLoad:  0x92E84;
}

init
{
    vars.x = 0;
    vars.IsLag = false;
	refreshRate = 60;
	if (modules.First().FileVersionInfo.FileDescription == "X-Ray 1.6 Engine")
		version = "CoP";
	else if (game.ProcessName != "XR_3DA"){
        version = "CS";
        vars.x = -1;
    }
	else{
		vars.Loading2 = new MemoryWatcher<byte>(new DeepPointer(0x10BB58));
		vars.Escape = new MemoryWatcher<byte>(new DeepPointer("xrGame.dll", 0x560668));
	}
}

isLoading
{
	if(version == "CoP"){
		if(vars.x == 0){
			vars.x = current.OnLoad;
		}
		if(old.Load2 && !current.Load2){
			vars.x = 0;
		}
        return current.OnLoad != vars.x || !current.Loading || current.Load2;
	}
	else if(version == "CS"){
        return !current.OldLoad || !current.Loading || current.Sync == 1 || old.Sync == 1 || current.Escape;
	}
    else{
        if(vars.x == 0 && current.Loading){
            vars.x = current.QLoad;
        }
        if(old.Loading && !current.Loading){
            vars.x = 0;
        }
        vars.Escape.Update(game);
        if (!current.Loading || current.Sync == 1 || vars.Escape.Current == 1 || vars.IsLag || current.QLoad != vars.x )
        {
            if(vars.Escape.Current == 1 && !vars.IsLag){
                vars.Escape.UpdateInterval = TimeSpan.FromMilliseconds(150);
                vars.IsLag = true;
            }else{
                vars.IsLag = false;
            }
            if(current.Sync == 1 && old.Sync == 0){
                vars.IsLag = false;
                vars.x = 0;
                vars.Escape.UpdateInterval = TimeSpan.Zero;
            }
            return true;
        }
        else
        {
            return false;
        } 
    }

}

exit
{
	timer.IsGameTimePaused = true;
    vars.Loading2 = null;
    vars.Escape = null;
    vars.x = 0;
}

