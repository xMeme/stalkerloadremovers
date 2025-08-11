state("xrEngine", "Enhanced"){}
state("xrEngine", "1.6.02"){}

startup
{
    settings.Add("autosplitter", false, "Autosplit per level - Автосплит для каждого уровня");
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
            "LiveSplit | S.T.A.L.K.E.R.: Call of Pripyat",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );
        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
    refreshRate = 60;
}

init {
    timer.IsGameTimePaused = false;

    //print(modules.First().ModuleMemorySize.ToString());
    if (modules.First().ModuleMemorySize == 1372160 || modules.First().ModuleMemorySize == 1961984)
    {
        version = "1.6.02";
    }
    else
    {
        version = "Enhanced";
    }

    if (version == "Enhanced")
    {
        var scanner = new SignatureScanner(game, modules.First().BaseAddress, modules.First().ModuleMemorySize);

        var LoadSig = new SigScanTarget("44 8B ?? ?? ?? ?? ?? 48 8D ?? ?? ?? ?? ?? 45 8B ?? 41 83");
        var LoadLocation = scanner.Scan(LoadSig);
        var LoadAddr = LoadLocation + 3;
        var LoadRIP = memory.ReadValue<int>(LoadAddr);
        var LoadRIPAddr = LoadLocation + 7 + LoadRIP;
        vars.Load = new MemoryWatcher<bool>(LoadRIPAddr);

        var Load2Sig = new SigScanTarget("38 ?? ?? ?? ?? ?? 74 ?? 83 ?? ?? ?? ?? ?? ?? 75 ?? 48 39 ?? ?? ?? ?? ?? 75 ?? BA");
        var Load2Location = scanner.Scan(Load2Sig);
        var Load2Addr = Load2Location + 2;
        var Load2RIP = memory.ReadValue<int>(Load2Addr);
        var Load2RIPAddr = Load2Location + 6 + Load2RIP;
        vars.Load2 = new MemoryWatcher<bool>(Load2RIPAddr);

        var isPausedSig = new SigScanTarget("0F B6 ?? ?? ?? ?? ?? 90 C3 ?? ?? ?? ?? ?? ?? ?? 48 89");
        var isPausedLocation = scanner.Scan(isPausedSig);
        var isPausedAddr = isPausedLocation + 3;
        var isPausedRIP = memory.ReadValue<int>(isPausedAddr);
        var isPausedRIPAddr = isPausedLocation + 7 + isPausedRIP;
        vars.isPaused = new MemoryWatcher<bool>(isPausedRIPAddr);

        var SyncSig = new SigScanTarget("C5 ?? ?? ?? ?? ?? ?? ?? C5 ?? ?? ?? ?? ?? ?? ?? C5 ?? ?? ?? C5 ?? ?? ?? 72 ?? C5 ?? ?? ?? C5");
        var SyncLocation = scanner.Scan(SyncSig);
        var SyncAddr = SyncLocation + 4;
        var SyncRIP = memory.ReadValue<int>(SyncAddr);
        var SyncRIPAddr = SyncLocation + 8 + SyncRIP;
        vars.sync = new MemoryWatcher<float>(SyncRIPAddr);

        var CurMapSig = new SigScanTarget("4C ?? ?? ?? ?? ?? ?? 39 ?? ?? ?? ?? ?? 0F 84 ?? ?? ?? ?? 48 89 ?? ?? ?? ?? ?? ?? 33");
        var CurMapLocation = scanner.Scan(CurMapSig);
        var CurMapAddr = CurMapLocation + 3;
        var CurMapRIP = memory.ReadValue<int>(CurMapAddr);
        var CurMapRIPAddr = CurMapLocation + 7 + CurMapRIP + 0xC;
        vars.CurMap = new StringWatcher(CurMapRIPAddr, 20);

        vars.watchers = new MemoryWatcherList()
        {
            vars.Load,
            vars.Load2,
            vars.isPaused,
            vars.sync,
            vars.CurMap
        };
    }
    if (version == "1.6.02")
    {
        var xrNetServer = modules.FirstOrDefault(m => m.ModuleName == "xrNetServer.dll").BaseAddress;
        var xrCore = modules.FirstOrDefault(m => m.ModuleName == "xrCore.dll").BaseAddress;

        vars.Load = new MemoryWatcher<bool>(xrNetServer + 0x12E04);
        vars.Load2 = new MemoryWatcher<bool>(modules.First().BaseAddress + 0x913F5);
        vars.isPaused = new MemoryWatcher<bool>(modules.First().BaseAddress + 0x930F0);
        vars.sync = new MemoryWatcher<float>(modules.First().BaseAddress + 0x92EF4);
        vars.CurMap = new StringWatcher(new DeepPointer(xrCore + 0xBE910, 0x18, 0x28, 0x0), 20);

        vars.watchers = new MemoryWatcherList()
        {
            vars.Load,
            vars.Load2,
            vars.isPaused,
            vars.sync,
            vars.CurMap
        };
    }
}

update
{
    vars.watchers.UpdateAll(game);
}

start
{
    if (vars.Load.Current && !vars.Load2.Current && vars.Load2.Changed && version == "1.6.02")
    {
        return true;
    }
}
isLoading
{
    return !vars.Load.Current || vars.Load2.Current || (vars.sync.Current > 0.00000019 && vars.sync.Current < 0.00000021);
}
split
{
    return vars.CurMap.Changed && vars.CurMap.Current != "" && vars.CurMap.Old != "" && settings["autosplitter"];
}
exit
{
    timer.IsGameTimePaused = true;
    vars.watchers.Clear();
}
