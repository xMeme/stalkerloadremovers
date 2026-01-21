state("xrEngine", "Enhanced"){}
state("XR_3DA","1.0006"){}
state("XR_3DA","1.0000"){}

startup
{
    settings.Add("autosplitter", true, "Autosplit per level - Автосплит для каждого уровня");
    settings.SetToolTip
    (
    "autosplitter",
    "Enable autosplitter on every level transition \n"+
    "Автоматическое переключение при переходе на локацию"
    );
    settings.Add("fix", false, "Low PC Fix");
    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show
        (
            "This game uses Load Removed Time (Game Time) as default timing method \n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time? This will make verification easier",
            "LiveSplit | S.T.A.L.K.E.R.: Shadow of Chernobyl",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );
        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
    refreshRate = 60;
}

init
{
    timer.IsGameTimePaused = false;

    if (game.ProcessName == "xrEngine")
    {
        var scanner = new SignatureScanner(game, modules.First().BaseAddress, modules.First().ModuleMemorySize);

        var LoadSig = new SigScanTarget(3, "44 8B ?? ?? ?? ?? ?? 48 8D ?? ?? ?? ?? ?? 45 8B ?? 41 83");
        var LoadLocation = scanner.Scan(LoadSig);
        var LoadRIP = memory.ReadValue<int>(LoadLocation);
        var LoadRIPAddr = LoadLocation + 4 + LoadRIP;
        vars.Loading = new MemoryWatcher<bool>(LoadRIPAddr);

        var PromptSig = new SigScanTarget(2, "C6 ?? ?? ?? ?? ?? ?? 48 8D ?? ?? ?? ?? ?? 44 8B ?? 44 8B");
        var PromptLocation = scanner.Scan(PromptSig);
        var PromptRIP = memory.ReadValue<int>(PromptLocation);
        var PromptRIPAddr = PromptLocation + 5 + PromptRIP;
        vars.Prompt = new MemoryWatcher<bool>(PromptRIPAddr);

        var isPausedSig = new SigScanTarget(3, "0F B6 ?? ?? ?? ?? ?? 90 C3 ?? ?? ?? ?? ?? ?? ?? 48 89");
        var isPausedLocation = scanner.Scan(isPausedSig);
        var isPausedRIP = memory.ReadValue<int>(isPausedLocation);
        var isPausedRIPAddr = isPausedLocation + 4 + isPausedRIP;
        vars.isPaused = new MemoryWatcher<bool>(isPausedRIPAddr);

        var SyncSig = new SigScanTarget(4, "C5 ?? ?? ?? ?? ?? ?? ?? C5 ?? ?? ?? ?? ?? ?? ?? C5 ?? ?? ?? C5 ?? ?? ?? 72 ?? C5 ?? ?? ?? C5");
        var SyncLocation = scanner.Scan(SyncSig);
        var SyncRIP = memory.ReadValue<int>(SyncLocation);
        var SyncRIPAddr = SyncLocation + 4 + SyncRIP;
        vars.sync = new MemoryWatcher<float>(SyncRIPAddr);

        var CurMapSig = new SigScanTarget(3, "4C ?? ?? ?? ?? ?? ?? 39 ?? ?? ?? ?? ?? 0F 84 ?? ?? ?? ?? 48 89 ?? ?? ?? ?? ?? ?? 33");
        var CurMapLocation = scanner.Scan(CurMapSig);
        var CurMapRIP = memory.ReadValue<int>(CurMapLocation);
        var CurMapRIPAddr = CurMapLocation + 4 + CurMapRIP + 0xC;
        vars.CurMap = new StringWatcher(CurMapRIPAddr, 20);

        //Placeholder, until GSC stops updating Enhanced Edition.
        vars.End = new StringWatcher(IntPtr.Zero, 5);

        vars.watchers = new MemoryWatcherList()
        {
            vars.Loading,
            vars.Prompt,
            vars.isPaused,
            vars.sync,
            vars.CurMap
            
        };
    }
    if (game.ProcessName == "XR_3DA")
    {
        //print(modules.First().ModuleMemorySize.ToString());
        if (modules.First().ModuleMemorySize == 1662976 || modules.First().ModuleMemorySize == 1613824)
        {
            version = "1.0000";
        }
        else
        {
            version = "1.0006";
        }

        var xrNetServer = modules.First(m => m.ModuleName.Equals("xrNetServer.dll", StringComparison.OrdinalIgnoreCase)).BaseAddress;
        var xrGame = modules.First(m => m.ModuleName.Equals("xrGame.dll", StringComparison.OrdinalIgnoreCase)).BaseAddress;
        var xrCore = modules.First(m => m.ModuleName.Equals("xrCore.dll", StringComparison.OrdinalIgnoreCase)).BaseAddress;

        if (version == "1.0000")
        {
            vars.Loading = new MemoryWatcher<bool>(xrNetServer + 0xFAC4);
            vars.Prompt = new MemoryWatcher<bool>(xrGame + 0x54C2F9);
            vars.isPaused = new MemoryWatcher<bool>(modules.First().BaseAddress + 0x1047C0);
            vars.sync = new MemoryWatcher<float>(modules.First().BaseAddress + 0x104928);
            vars.CurMap = new StringWatcher(new DeepPointer(xrCore + 0xBA040, 0x4, 0x0, 0x40, 0x8, 0x20, 0x14), 20);
            vars.End = new StringWatcher(new DeepPointer(modules.First().BaseAddress + 0x1048BC, 0x54, 0x14, 0x0, 0x0, 0x44, 0xC, 0x12), 5);
        }
        if (version == "1.0006")
        {
            vars.Loading = new MemoryWatcher<bool>(xrNetServer + 0x13E84);
            vars.Prompt = new MemoryWatcher<bool>(xrGame + 0x560668);
            vars.isPaused = new MemoryWatcher<bool>(modules.First().BaseAddress + 0x10BCD0);
            vars.sync = new MemoryWatcher<float>(modules.First().BaseAddress + 0x10BE80);
            vars.CurMap = new StringWatcher(new DeepPointer(xrCore + 0xBF368, 0x4, 0x0, 0x40, 0x8, 0x28, 0x4), 20);
            vars.End = new StringWatcher(new DeepPointer(modules.First().BaseAddress + 0x10BDB0, 0x3C, 0x10, 0x0, 0x0, 0x44, 0xC, 0x12), 5);
        }

        vars.watchers = new MemoryWatcherList()
        {
            vars.Loading,
            vars.Prompt,
            vars.isPaused,
            vars.sync,
            vars.CurMap,
            vars.End
        };
    }

    if(settings["fix"])
    {
        refreshRate = 30;
    }
}

update
{
    vars.watchers.UpdateAll(game);
}

start
{
    if (vars.Loading.Current && vars.Loading.Changed && game.ProcessName == "XR_3DA")
    {
        timer.IsGameTimePaused = true;
        return true;
    }
    if (!vars.isPaused.Current && vars.isPaused.Changed && vars.Loading.Current && game.ProcessName == "xrEngine") //Annoying, until GSC stops updating Enhanced Edition.
    {
        return true;
    }
}
split
{
    return vars.CurMap.Changed && vars.CurMap.Current != "" && vars.CurMap.Old != "" && settings["autosplitter"] || (vars.End.old != "final" && vars.End.current == "final");
}
isLoading
{
    return !vars.Loading.Current || (vars.sync.Current > 0.057 && vars.sync.Current < 0.11) || vars.Prompt.Current || !vars.isPaused.Current && vars.sync.Current == 0;
}
exit
{
    timer.IsGameTimePaused = true;
    vars.watchers.Clear();
}
