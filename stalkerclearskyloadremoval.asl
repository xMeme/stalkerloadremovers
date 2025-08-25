state("xrEngine", "Enhanced"){}
state("xrEngine", "1.5.10"){}

startup
{
    settings.Add("autosplitter", true, "Autosplit per level - Автосплит для каждого уровня");
    settings.SetToolTip
    (
        "autosplitter",
        "Enable autosplitter on every level transition \n"+
        "Автоматическое переключение при переходе на локацию"
    );
    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show
        (
            "This game uses Load Removed Time (Game Time) as default timing method \n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time? This will make verification easier",
            "LiveSplit | S.T.A.L.K.E.R.: Clear Sky",
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

    //print(modules.First().ModuleMemorySize.ToString());
    if (modules.First().ModuleMemorySize == 1130496 || modules.First().ModuleMemorySize == 1720320)
    {
        version = "1.5.10";
    }
    else
    {
        version = "Enhanced";
    }

    if (version == "Enhanced")
    {
        var scanner = new SignatureScanner(game, modules.First().BaseAddress, modules.First().ModuleMemorySize);

        var LoadSig = new SigScanTarget(3, "44 8B ?? ?? ?? ?? ?? 48 8D ?? ?? ?? ?? ?? 45 8B ?? 41 83");
        var LoadLocation = scanner.Scan(LoadSig);
        var LoadRIP = memory.ReadValue<int>(LoadLocation);
        var LoadRIPAddr = LoadLocation + 4 + LoadRIP;
        vars.Loading = new MemoryWatcher<bool>(LoadRIPAddr);

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

        //Placeholders, until GSC stops updating Enhanced Edition.
        vars.Start = new StringWatcher(IntPtr.Zero, 5);
        vars.End = new StringWatcher(IntPtr.Zero, 5);
        vars.NoControl = new MemoryWatcher<bool>(IntPtr.Zero);

        vars.watchers = new MemoryWatcherList()
        {
            vars.Loading,
            vars.isPaused,
            vars.sync,
            vars.CurMap
        };
    }
    if (version == "1.5.10")
    {
        var xrNetServer = modules.First(m => m.ModuleName.Equals("xrNetServer.dll", StringComparison.OrdinalIgnoreCase)).BaseAddress;
        var xrGame = modules.First(m => m.ModuleName.Equals("xrGame.dll", StringComparison.OrdinalIgnoreCase)).BaseAddress;
        var xrCore = modules.First(m => m.ModuleName.Equals("xrCore.dll", StringComparison.OrdinalIgnoreCase)).BaseAddress;

        vars.Loading = new MemoryWatcher<bool>(xrNetServer + 0x13E04);
        vars.NoControl = new MemoryWatcher<bool>(xrGame + 0x606320);
        vars.sync = new MemoryWatcher<float>(modules.First().BaseAddress + 0x96D50);
        vars.Start = new StringWatcher(new DeepPointer(xrGame + 0x2A6B19, 0xE1), 5);
        vars.CurMap = new StringWatcher(new DeepPointer(xrCore + 0xBE718, 0x18, 0x28, 0x0), 21);
        vars.End = new StringWatcher(new DeepPointer(modules.First().BaseAddress + 0x96CC0, 0x30, 0x10, 0x4, 0x34, 0x4, 0xC, 0x16), 5);

        //Placeholder, until GSC stops updating Enhanced Edition.
        vars.isPaused = new MemoryWatcher<bool>(IntPtr.Zero);

        vars.watchers = new MemoryWatcherList()
        {
            vars.Loading,
            vars.NoControl,
            vars.sync,
            vars.Start,
            vars.CurMap,
            vars.End
        };
    }
}

update
{
    vars.watchers.UpdateAll(game);
}

start
{
    if (vars.NoControl.Current && vars.NoControl.Changed && vars.Start.Current == "intro" && version == "1.5.10")
    {
        return true;
    }
    if (!vars.isPaused.Current && vars.isPaused.Changed && vars.Loading.Current && version == "Enhanced") //Annoying, until GSC stops updating Enhanced Edition.
    {
        return true;
    }
}
split
{
    return vars.CurMap.Changed && vars.CurMap.Current != "" && vars.CurMap.Old != "" && settings["autosplitter"] || vars.End.Current == "outro";
}
isLoading
{
    return !vars.Loading.Current || (vars.sync.Current > 0.08 && vars.sync.Current < 0.11) || (vars.sync.Current > 0.00000019 && vars.sync.Current < 0.00000021);
}
exit
{
    timer.IsGameTimePaused = true;
    vars.watchers.Clear();
}
