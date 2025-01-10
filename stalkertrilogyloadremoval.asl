state("XR_3DA","1.0006")
{
	bool Loading: "xrNetServer.dll", 0x13E84;
	bool NoControl:	"xrGame.dll", 0x560668;
	float sync: "XR_3DA.exe", 0x10BE80;
	string20 CurMap: "xrCore.dll", 0xBF368, 0x4, 0x0, 0x40, 0x8, 0x28, 0x4;
	string21 End: "XR_3DA.exe", 0x171DD4, 0x180;
	string15 TrueEnd: "XR_3DA.exe", 0x7D0F8, 0x1CE;
}
state("XR_3DA","1.0000")
{
	bool Loading: "xrNetServer.dll", 0xFAC4;
	bool NoControl:	"xrGame.dll", 0x54C2F9;
	float sync: "XR_3DA.exe", 0x104928;
	string20 CurMap: "xrCore.dll", 0xBA040, 0x4, 0x0, 0x40, 0x8, 0x20, 0x14;
	string21 End: "XR_3DA.exe", 0x10A878, 0xBC;
	string15 TrueEnd: "XR_3DA.exe", 0x4163C, 0xD30;
}

state("xrEngine", "1.5.10")
{
	bool Loading: "xrNetServer.dll", 0x13E04;
	float onSync: "xrEngine.exe", 0x96D50;
	bool NoControl: "xrGame.dll", 0x606320;
	string5 Start: "xrGame.dll", 0x2A6B19, 0xE1;
	string21 CurMap: "xrCore.dll", 0xBE718, 0x18, 0x28, 0x0;
	string10 End: "xrEngine.exe", 0x96CC0, 0x30, 0x10, 0x4, 0x34, 0x4, 0xC, 0x16;
}

state("xrEngine", "1.6.02")
{
	bool Loading: "xrGame.dll", 0x512CC4, 0x14;
	bool Load2:   0x913F5;
	byte OnLoad:  0x92E84;
	string20 CurMap: "xrCore.dll", 0xBE910, 0x18, 0x28, 0x0;
	float onSync: "xrEngine.exe", 0x92EF4;
	string5 End: "xrGame.dll", 0x36C75D, 0xB0;
	string5 End2: "xrSound.dll", 0x27692, 0xACA;
}

startup
{
	refreshRate = 60;
	
	settings.Add("shocautosplitter", true, "[SHoC] Autosplit per level - Автоматическое переключение при переходе на локацию");
	settings.SetToolTip
	(
	"shocautosplitter",
	"Enable autosplitter on every level transition \n"+
	"Позволяет автоматически разделять каждый уровень"
	);
	settings.Add("csautosplitter", true, "[CS] Autosplit per level - Автоматическое переключение при переходе на локацию");
	settings.SetToolTip
	(
	"csautosplitter",
	"Enable autosplitter on every level transition \n"+
	"Позволяет автоматически разделять каждый уровень"
	);
	settings.Add("copautosplitter", false, "[COP] Autosplit per level - Автоматическое переключение при переходе на локацию");
	settings.SetToolTip
	(
	"copautosplitter",
	"Enable autosplitter on every level transition \n"+
	"Позволяет автоматически разделять каждый уровень"
	);

	if (timer.CurrentTimingMethod == TimingMethod.RealTime)
	{
    	var timingMessage = MessageBox.Show
		(
        	"S.T.A.L.K.E.R. Series use Load Removed Time (Game Time) as default timing method \n"+
        	"LiveSplit is currently set to show Real Time (RTA).\n"+
        	"Would you like to set the timing method to Game Time? This will make verification easier",
        	"LiveSplit | S.T.A.L.K.E.R. Series",
        	MessageBoxButtons.YesNo,MessageBoxIcon.Question
		);
        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
}

init
{
	vars.x = 0;
	vars.doneMaps = new List<string>();
	timer.IsGameTimePaused = false;

	if(modules.First().ModuleMemorySize == 1646592 || modules.First().ModuleMemorySize == 1781760)
	{
		version = "1.0006";
		return;
	}
	else if(modules.First().ModuleMemorySize == 1662976 || modules.First().ModuleMemorySize == 1613824)
	{
		version = "1.0000";
		return;
	}
	else if(modules.First().ModuleMemorySize == 1720320 || modules.First().ModuleMemorySize == 1130496)
	{
		version = "1.5.10";
		return;
	}
	else if(modules.First().ModuleMemorySize == 1961984 || modules.First().ModuleMemorySize == 1372160)
	{
		version = "1.6.02";
		return;
	}
}

start
{
	if(version == "1.0006" || version == "1.0000")
	{
		return current.Loading && !old.Loading;
	}
}

split
{
	if(version == "1.0006" || version == "1.0000")
	{
		if (current.CurMap != old.CurMap && !current.Loading && current.sync != 0 && settings["shocautosplitter"] || current.End == "final_immortal.ogm" && current.sync == 0 && old.sync != 0 || current.End == "final_gold.ogm" && current.sync == 0 && old.sync != 0 || current.End == "final_apocal.ogm" && current.sync == 0 && old.sync != 0 || current.End == "final_blind.ogm" && current.sync == 0 && old.sync != 0 || current.End == "final_to_monolith.ogm" && current.sync == 0 && old.sync != 0 || current.TrueEnd == "final_peace.ogm" && current.sync == 0 && old.sync != 0)
		{
			vars.doneMaps.Add(current.CurMap);
			return true;
		}
	}
	else if(version == "1.5.10")
	{
		if (current.CurMap != old.CurMap && !current.Loading && current.sync != 0 && settings["csautosplitter"] || current.End == "outro_half" && old.End != "outro_half")
		{
			vars.doneMaps.Add(current.CurMap);
			return true;
		}
	}
	else if(version == "1.6.02")
	{
		if (current.CurMap != old.CurMap && !current.Loading && current.sync != 0 && settings["copautosplitter"] || current.End == "outro" || current.End2 == "outro")
		{
			vars.doneMaps.Add(current.CurMap);
			return true;
		}
	}
}

isLoading
{
	if(version == "1.0006" || version == "1.0000")
	{
		return !current.Loading || (current.sync > 0.09 && current.sync < 0.11) || current.NoControl;
	}
	else if(version == "1.5.10")
	{
		return !current.Loading || (current.onSync>0.09 && current.onSync<0.11);
	}
	else if(version == "1.6.02")
	{
		if(vars.x == 0)
		{
			vars.x = current.OnLoad;
		}
		if(old.Load2 && !current.Load2)
		{
			vars.x = 0;
		}
		return current.OnLoad != vars.x || !current.Loading || current.Load2;
	}
}

onReset
{
	vars.doneMaps.Clear();
}

exit
{
	timer.IsGameTimePaused = true;
}
