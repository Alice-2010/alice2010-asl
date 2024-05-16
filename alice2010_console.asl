//========================================================//
// Alice in Wonderland 2010 AutoSplitter and Load Remover //
//        Created by https://github.com/DeathHound6       //
//             Last Updated: 16th May 2024                //
//========================================================//

// map - int
// -1 - loading
// 0 - menu
// 10 - round hall
// 20 - garden
// 30 - tulgey
// 40 - hare house
// 50 - hightopps
// 60 - cabin
// 70 - desert
// 75 - moat
// 80 - salazen
// 85 - stables
// 90 - marmoreal
// 100 - frabjous

// audioStatus - int
// 0 - playing audio
// 1 - not playing audio
// 4 - playing prerendered cutscene


// NOTE: State blocks won't have any pointers
// NOTE: Pointers will be stored as MemoryWatchers and DeepPointers
state("Alice", "Steam") {}

state("Dolphin", "Dolphin Wii NTSC") {}

state("Dolphin", "Dolphin Wii PAL") {}

startup
{
    // Utility
    settings.Add("utility", true, "Utility Options");
    settings.Add("log_file", true, "Debug Log File", "utility");
    settings.Add("load_removal", true, "Load Remover", "utility");
    settings.Add("game_time", false, "Show IGT (Game Time)", "utility");
    settings.SetToolTip("game_time", "Warning: Can cause lag to LiveSplit timer");
    settings.Add("boss_level", false, "Autostart Boss Levels", "utility");

    // Story
    settings.Add("garden", true, "Strange Garden");
    settings.Add("garden_cake", true, "Upel Cake", "garden");
    settings.Add("bandersnatch", true, "Bandersnatch Boss Fight", "garden");
    settings.Add("bandersnatch0", false, "Start of the fight", "bandersnatch");
    settings.Add("bandersnatch1", false, "End of Phase 1", "bandersnatch");
    settings.Add("bandersnatch2", false, "End of Phase 2", "bandersnatch");
    settings.Add("bandersnatch3", true, "End of Phase 3 (End of fight)", "bandersnatch");

    settings.Add("woods", true, "Tulgey Woods");

    settings.Add("hare_house", true, "March Hare House");

    settings.Add("cabin", true, "Cabin");
    settings.Add("cabin_pishsalver", true, "Pishsalver", "cabin");

    settings.Add("hightopps", true, "Hightopps");

    settings.Add("desert", true, "Red Desert");

    settings.Add("moat", true, "Moat");

    settings.Add("rq", true, "Salazen Grum - Red Queen");
    settings.Add("rq_pishsalver", true, "Pishsalver", "rq");

    settings.Add("stables", true, "Bandersnatch Stables");
    settings.Add("stayne", true, "Stayne Boss Fight", "stables");
    settings.Add("stayne0", false, "Start of the fight", "stayne");
    settings.Add("stayne1", false, "End of Phase 1", "stayne");
    settings.Add("stayne2", false, "End of Phase 2", "stayne");
    settings.Add("stayne3", true, "End of Phase 3 (End of fight)", "stayne");

    settings.Add("wq", true, "Marmoreal - White Queen");
    // TODO: If the bug where Alice stays small happens, do we want to check for and update this?
    settings.Add("wq_visit", true, "Visit the White Queen", "wq");

    settings.Add("frabjous", true, "Frabjous Day");
    settings.Add("jabberwocky", true, "Jabberwocky Boss Fight", "frabjous");
    settings.Add("jabberwocky0", true, "Start of the fight", "jabberwocky");
    settings.Add("jabberwocky1", false, "End of Phase 1", "jabberwocky");
    settings.Add("jabberwocky2", false, "End of Phase 2", "jabberwocky");
    settings.Add("jabberwocky3", false, "End of Phase 3", "jabberwocky");
    settings.Add("jabberwocky4", true, "End of Phase 4 (End of fight)", "jabberwocky");

    settings.Add("achievements", false, "Story Achievements");
    settings.Add("ach_round_hall", false, "Round Hall", "achievements");
    settings.Add("ach_absolem", false, "Absolem", "achievements");
    settings.Add("ach_hare_house", false, "March Hare House", "achievements");
    settings.Add("ach_rq", false, "Salazen Grum", "achievements");
    settings.Add("ach_rq_potion", false, "Salazen Grum: The Potion", "achievements");
    settings.Add("ach_stayne", false, "Stayne", "achievements");
    settings.Add("ach_wq", false, "Marmoreal", "achievements");
    settings.Add("ach_armour", false, "Alice's Armor", "achievements");

    // Upgrades
    // settings.Add("upgrades", false, "Upgrades");
    // // mctwisp
    // settings.Add("upgrades_enemy_freeze", false, "Enemy Freeze", "upgrades");
    // settings.Add("Upgrades_back2vortex", false, "Back to Vortex", "upgrades");
    // settings.Add("upgrades_mctwisp_combo", false, "McTwisp 3 Hit Combo", "upgrades");
    // // mally
    // settings.Add("upgrades_attack_speed", false, "2x Attack Speed", "upgrades");
    // settings.Add("upgrades_mally_sweep", false, "Mallymkin Sweep", "upgrades");
    // settings.Add("upgrades_mally_finish", false, "Mallymkin Finishing Move", "upgrades");
    // // hare
    // settings.Add("upgrades_push", false, "Push", "upgrades");
    // settings.Add("Upgrades_up", false, "Up", "upgrades");
    // settings.Add("upgrades_homing", false, "Homing Dishes", "upgrades");
    // // hatter
    // settings.Add("upgrades_hatter_sweep", false, "Hatter Sweep", "upgrades");
    // settings.Add("upgrades_hatter_finish", false, "Hatter Finishing Move", "upgrades");
    // settings.Add("upgrades_crush", false, "Crush", "upgrades");
    // // chessur
    // settings.Add("upgrades_cat_combo", false, "Chessur 3 Hit Combo", "upgrades");
    // settings.Add("upgrades_backstab", false, "Backstab", "upgrades");
    // settings.Add("upgrades_invis", false, "Extended Invisibility", "upgrades");
    // // general
    // settings.Add("upgrades_extra_life", false, "Extra Life", "upgrades");
    // settings.Add("upgrades_switch_bomb", false, "Switch Bomb", "upgrades");
    // settings.Add("upgrades_multiplier", false, "Impossible Ideas Multiplier", "upgrades");
}

init
{
    vars.logPath = "alice2010.log";
    // Log functions taken from https://github.com/VideoGameRoulette/re2-remake-autosplitter
    Action<string, string> SaveLogs = (filePath, text) => {
        if (!File.Exists(filePath)) {
            // Create a new file with the specified name
            using (StreamWriter sw = File.CreateText(filePath))
                sw.WriteLine(text);
        }
        else {
            // Append the new line to the file
            using (StreamWriter sw = File.AppendText(filePath))
                sw.WriteLine(text);
        }
    };
    Action<string> Log = (text) => {
        string log = "[Debug";
        // NOTE: If the timer value > 0, then show the timer info in log
        if (timer.CurrentPhase != TimerPhase.NotRunning)
            log += " " + timer.CurrentTime.GameTime.ToString();
        log += "]: " + text;
        print(log);
        if (settings["log_file"])
            SaveLogs(vars.logPath, log);
    };
    vars.Log = Log;
    Action<string> LogsClear = (filePath) => {
        if (settings["log_file"])
        {
            Log("Clearing Logs");
            if (File.Exists(filePath))
                File.WriteAllLines(filePath, new string[0]);
        }
    };
    vars.LogsClear = LogsClear;

    if (game.ProcessName == "Dolphin")
    {
        vars.mem1 = IntPtr.Zero;
        vars.mem2 = IntPtr.Zero;
        foreach (var item in ExtensionMethods.MemoryPages(game, true))
        {
            if (item.Type == MemPageType.MEM_MAPPED && item.AllocationProtect == MemPageProtect.PAGE_READWRITE &&
                item.State == MemPageState.MEM_COMMIT && item.Protect == MemPageProtect.PAGE_READWRITE && (int)item.RegionSize == 0x2000000)
            {
                vars.mem1 = item.BaseAddress;
                vars.mem2 = (
                    long.Parse(item.BaseAddress.ToString(), System.Globalization.NumberStyles.HexNumber) +
                    long.Parse(item.RegionSize.ToString(), System.Globalization.NumberStyles.HexNumber)
                );
                break;
            }
        }
        if (vars.mem1 == IntPtr.Zero)
            version = "Unknown";
        else
        {
            switch(ExtensionMethods.ReadString(game, (IntPtr)vars.mem1, 6))
            {
                case "SALP4Q":
                    version = "Dolphin Wii PAL";
                    break;
                case "SALE4Q":
                    version = "Dolphin Wii NTSC";
                    break;
            }
        }
    }
    else if (game.ProcessName == "Alice")
        version = "Steam";

    vars.splitsDone = new List<string>();
    vars.achievementsDone = new List<string>();

    // set text taken from Poppy Playtime C2
    // used here for showing completed achievement count - for 100% runs
    Action<string, string> SetTextComponent = (id, text) => {
        var textSettings = timer.Layout.Components.Where(x => x.GetType().Name == "TextComponent").Select(x => x.GetType().GetProperty("Settings").GetValue(x, null));
        var textSetting = textSettings.FirstOrDefault(x => (x.GetType().GetProperty("Text1").GetValue(x, null) as string) == id);
        if (textSetting == null)
        {
            var textComponentAssembly = Assembly.LoadFrom("Components\\LiveSplit.Text.dll");
            var textComponent = Activator.CreateInstance(textComponentAssembly.GetType("LiveSplit.UI.Components.TextComponent"), timer);
            timer.Layout.LayoutComponents.Add(new LiveSplit.UI.Components.LayoutComponent("LiveSplit.Text.dll", textComponent as LiveSplit.UI.Components.IComponent));

            textSetting = textComponent.GetType().GetProperty("Settings", BindingFlags.Instance | BindingFlags.Public).GetValue(textComponent, null);
            textSetting.GetType().GetProperty("Text1").SetValue(textSetting, id);
        }

        if (textSetting != null)
            textSetting.GetType().GetProperty("Text2").SetValue(textSetting, text);
    };
    vars.SetTextComponent = SetTextComponent;

    Func<string, bool> Split = (splitName) => {
        if (vars.splitsDone.Contains(splitName))
            return false;
        Log("Splitting: " + splitName);
        vars.splitsDone.Add(splitName);
        return settings[splitName];
    };
    vars.Split = Split;

    Func<uint, uint> GetUint = (value) => {
        byte[] bytes = BitConverter.GetBytes(value);
        if (version != "Steam")
            Array.Reverse(bytes);
        return BitConverter.ToUInt32(bytes, 0);
    };
    vars.GetUint = GetUint;
    Func<int, int> GetInt = (value) => {
        byte[] bytes = BitConverter.GetBytes(value);
        if (version != "Steam")
            Array.Reverse(bytes);
        return BitConverter.ToInt32(bytes, 0);
    };
    vars.GetInt = GetInt;
    Func<float, float> GetFloat = (value) => {
        byte[] bytes = BitConverter.GetBytes(value);
        if (version != "Steam")
            Array.Reverse(bytes);
        return BitConverter.ToSingle(bytes, 0);
    };
    vars.GetFloat = GetFloat;
    Func<int, int[], IntPtr> ReadPointer = (baseAddress, offsets) => {
        byte[] bytes = new byte[] {};
        game.ReadBytes((IntPtr)((long)vars.mem1 + (long)baseAddress), 4, out bytes);
        uint addr = vars.GetUint(BitConverter.ToUInt32(bytes, 0)) - 0x80000000;
        for (int i = 0; i < offsets.Length - 1; i++) {
            game.ReadBytes((IntPtr)((long)vars.mem1 + (long)addr + (long)offsets[i]), 4, out bytes);
            addr = vars.GetUint(BitConverter.ToUInt32(bytes, 0)) - 0x80000000;
        }
        return (IntPtr)((long)vars.mem1 + (long)addr + (long)offsets[offsets.Length - 1]);
    };
    vars.ReadPointer = ReadPointer;

    if (version.Contains("PAL"))
    {
        // Wii PAL release
        vars.gameTime = new MemoryWatcher<float>((IntPtr)((long)vars.mem1 + (long)0x61CAE4));
        vars.map = new MemoryWatcher<int>((IntPtr)((long)vars.mem1 + (long)0x77F870));
        vars.mapSector = new MemoryWatcher<int>((IntPtr)((long)vars.mem1 + (long)0x77676C));
        // vars.charID = new MemoryWatcher<uint>((IntPtr)((int)vars.mem1 + (int)0x7DA583));
        vars.audioStatus = new MemoryWatcher<int>((IntPtr)((long)vars.mem1 + (long)0x7FCA10));
        vars.aliceIDPtr = 0x7DE5D4;
        vars.aliceIDOffsets = new int[] {0x9D0};
        // vars.roundHall = new MemoryWatcher<uint>((IntPtr)((int)vars.mem1 + (int)0x7E2534));
        // vars.findAbsolem = new MemoryWatcher<uint>();
        // vars.vorpal = new MemoryWatcher<uint>();
        // vars.visitWq = new MemoryWatcher<uint>();
        // vars.chests = new MemoryWatcher<uint>();
        // vars.bchest = new MemoryWatcher<uint>();
        // vars.money =  new MemoryWatcher<short>((IntPtr)((int)vars.mem1 + (int)0x4524));
        // vars.enemies = new MemoryWatcher<uint>();
        // vars.chess = new MemoryWatcher<uint>();
        // vars.upgrades = new MemoryWatcher<uint>();
        // vars.vegetation = new MemoryWatcher<short>();
        // vars.furniture = new MemoryWatcher<short>();
        // vars.mosquitos = new MemoryWatcher<uint>();
        // vars.pigs = new MemoryWatcher<uint>();
        // vars.lizards = new MemoryWatcher<uint>();
        // vars.birds = new MemoryWatcher<uint>();
        // vars.clocks = new MemoryWatcher<uint>();
        // vars.roses = new MemoryWatcher<uint>();
        // vars.statues = new MemoryWatcher<uint>();
        // vars.paintings = new MemoryWatcher<uint>();
        // Bandersnatch health from UI values
        vars.bandersnatchHealth = new MemoryWatcher<int>((IntPtr)((long)vars.mem1 + (long)0x7DA380));
        // Stayne is 'enemy group -> enemy 1'
        // pointer from enemygroup to health
        vars.stayneHealthPtr = 0x6F4FE4;
        vars.stayneHealthPtrOffsets = new int[]{0x4F8};
        // Jabberwocky Phase is a CKIntegerCounter inside CKSrvCounter service
        vars.jabberwockyPtr = 0x7762EC;
        vars.jabberwockyPtrOffsets = new int[] {0x1C, 0x4};
    }
    else if (version.Contains("NTSC"))
    {
        // Wii NTSC release
        vars.map = new MemoryWatcher<int>((IntPtr)((long)vars.mem1 + (long)0x77F8F0));
        vars.aliceIDPtr = 0x0;
        vars.aliceIDOffsets = new int[] {0x0};
        // Bandersnatch health from UI values
        vars.bandersnatchHealth = new MemoryWatcher<int>((IntPtr)((long)vars.mem1 + (long)0x0));
        // Stayne is 'enemy group -> enemy 1'
        // pointer from enemygroup to health
        vars.stayneHealthPtr = 0x0;
        vars.stayneHealthPtrOffsets = new int[]{0x0};
        // Jabberwocky Phase is a CKIntegerCounter inside CKSrvCounter service
        vars.jabberwockyPtr = 0x0;
        vars.jabberwockyPtrOffsets = new int[] {0x0, 0x0};
    }
    else if (version == "Steam")
    {
        // Steam release
        vars.gameTime = new MemoryWatcher<float>(new DeepPointer("Alice.exe", 0x45CF1C, 0x4C, 0x44, 0x10));
        vars.map = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x45CF1C, 0x4C, 0x2BC));
        vars.mapSector = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x45CF1C, 0x4C, 0x18, 0x18));
        // vars.charID = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x90, 0x54, 0x180, 0x13C));
        vars.audioStatus = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x45CF1C, 0x3C, 0xC, 0x0, 0x4, 0x10C, 0x0, 0xC));
        vars.aliceID = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x45CF1C, 0x4C, 0x8, 0x28, 0x9D0));
        // vars.roundHall = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x264, 0x1C));
        // vars.findAbsolem = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x248, 0x1C));
        // vars.achHareHouse = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x24C, 0x1C));
        // vars.achRq = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x250, 0x1C));
        // vars.achRqPotion = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x254, 0x1C));
        // vars.stayne = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x258, 0x1C));
        // vars.visitWq = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x25C, 0x1C));
        // vars.armour = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x260, 0x1C));
        // vars.chests = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x268, 0x1C));
        // vars.bchests = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x26C, 0x1C));
        // vars.money = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x270, 0x1C));
        // vars.enemies = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x274, 0x1C));
        // vars.chess = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x278, 0x1C));
        // vars.upgrades = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x27C, 0x1C));
        // vars.vegetation = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x280, 0x1C));
        // vars.furniture = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x284, 0x1C));
        // vars.mosquitos = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x288, 0x1C));
        // vars.pigs = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x28C, 0x1C));
        // vars.lizards = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x290, 0x1C));
        // vars.birds = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x294, 0x1C));
        // vars.clocks = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x298, 0x1C));
        // vars.roses = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x29C, 0x1C));
        // vars.statues = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x2A0, 0x1C));
        // vars.paintings = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x2A4, 0x1C));
        // vars.extraLife = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x384, 0x1C));
        // vars.multiplier = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x388, 0x1C));
        // vars.switchBomb = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x38C, 0x1C));
        // vars.enemyFreeze = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x390, 0x1C));
        // vars.back2Vortex = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x394, 0x1C));
        // vars.mctwispCombo = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x398, 0x1C));
        // vars.attackSpeed = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x39C, 0x1C));
        // vars.mallySweep = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3A0, 0x1C));
        // vars.mallyFinish = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3A4, 0x1C));
        // vars.up = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3A8, 0x1C));
        // vars.push = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3AC, 0x1C));
        // vars.homing = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3B0, 0x1C));
        // vars.crush = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3B4, 0x1C));
        // vars.hatterSweep = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3B8, 0x1C));
        // vars.hatterFinish = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3BC, 0x1C));
        // vars.catCombo = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3C0, 0x1C));
        // vars.invis = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3C4, 0x1C));
        // vars.backstab = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3C8, 0x1C));
        // Bandersnatch health from UI values
        vars.bandersnatchHealth = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x45CF1C, 0x44, 0x54, 0x15C, 0x1C));
        // Stayne is 'enemy group -> enemy 1' (enemy 1 is 0x58 offset)
        vars.stayneHealth = new MemoryWatcher<float>(new DeepPointer("Alice.exe", 0x45CF1C, 0x4C, 0x4, 0x58, 0x3D0));
        // Jabberwocky Phase is a CKIntegerCounter inside CKSrvCounter service
        vars.jabberwockyPhase = new MemoryWatcher<uint>(new DeepPointer("Alice.exe", 0x45CF1C, 0x28, 0x58, 0xC, 0x1C, 0x4));
    }
}

start
{
    if (settings["boss_level"])
    {
        // check bandersnatch
        if (vars.GetInt(vars.map.Current) == 20 && vars.GetInt(vars.mapSector.Current) == 3 && vars.GetInt(vars.audioStatus.Current) == 1 && vars.GetInt(vars.audioStatus.Old) == 4 && vars.GetInt(vars.bandersnatchHealth.Current) == 3)
        {
            vars.LogsClear(vars.logPath);
            vars.Split("bandersnatch0");
            return true;
        }

        // check stayne
        if (vars.GetInt(vars.map.Current) == 85 && vars.GetInt(vars.audioStatus.Current) == 1 && vars.GetInt(vars.audioStatus.Old) == 4 &&
        vars.GetFloat(vars.stayneHealth.Current) == 1500f)
        {
            vars.LogsClear(vars.logPath);
            vars.Split("stayne0");
            return true;
        }

        // check jabberwocky
        if (vars.GetInt(vars.map.Current) == 100 && vars.GetInt(vars.mapSector.Current) == 2 && vars.GetInt(vars.audioStatus.Current) == 1 && vars.GetInt(vars.audioStatus.Old) == 4 && vars.GetInt(vars.jabberwockyPhase.Current) == 1)
        {
            vars.LogsClear(vars.logPath);
            vars.Split("jabberwocky0");
            return true;
        }
    }
    else
    {
        // if (vars.GetInt(vars.map.Current) == 10 && vars.GetInt(vars.audioStatus.Current) == 1 && vars.GetInt(vars.audioStatus.Old) == 4)
        // {
        //     vars.LogsClear(vars.logPath);
        //     vars.Log("Beginning Main Game Run");
        //     return true;
        // }
    }
}

update
{
    // If this is after the first definition, that means that old will have a value
    // Store this for after the reassignment of the pointers
    // NOTE: THESE WILL ONLY BE REASSIGNED FOR DOLPHIN
    int oldAliceID = -1;
    float oldStayneHealth = -1f;
    int oldJabberPhase = -1;
    if (version != "Steam")
    {
        if (((IDictionary<string, object>)vars).ContainsKey("aliceID"))
            oldAliceID = vars.aliceID.Current;
        if (((IDictionary<string, object>)vars).ContainsKey("stayneHealth"))
            oldStayneHealth = vars.stayneHealth.Current;
        if (((IDictionary<string, object>)vars).ContainsKey("jabberwockyPhase"))
            oldJabberPhase = vars.jabberwockyPhase.Current;

        // Set the new MemoryWatcher's with the potentially updated pointer values
        vars.aliceID = new MemoryWatcher<int>(vars.ReadPointer(vars.aliceIDPtr, vars.aliceIDOffsets));
        vars.stayneHealth = new MemoryWatcher<float>(vars.ReadPointer(vars.stayneHealthPtr, vars.stayneHealthPtrOffsets));
        vars.jabberwockyPhase = new MemoryWatcher<int>(vars.ReadPointer(vars.jabberwockyPtr, vars.jabberwockyPtrOffsets));
    }

    vars.gameTime.Update(game);
    vars.map.Update(game);
    vars.mapSector.Update(game);
    vars.aliceID.Update(game);
    // vars.charID.Update(game);
    vars.audioStatus.Update(game);

    // vars.roundHall.Update(game);
    // vars.findAbsolem.Update(game);
    // vars.achHareHouse.Update(game);
    // vars.achRq.Update(game);
    // vars.achRqPotion.Update(game);
    // vars.stayne.Update(game);
    // vars.visitWq.Update(game);
    // vars.armour.Update(game);

    // vars.chests.Update(game);
    // vars.bchests.Update(game);
    // vars.money.Update(game);
    // vars.enemies.Update(game);
    // vars.chess.Update(game);
    // vars.upgrades.Update(game);
    // vars.vegetation.Update(game);
    // vars.furniture.Update(game);
    // vars.mosquitos.Update(game);
    // vars.pigs.Update(game);
    // vars.lizards.Update(game);
    // vars.birds.Update(game);
    // vars.clocks.Update(game);
    // vars.roses.Update(game);
    // vars.statues.Update(game);
    // vars.paintings.Update(game);

    // vars.enemyFreeze.Update(game);
    // vars.back2Vortex.Update(game);
    // vars.mctwispCombo.Update(game);
    // vars.attackSpeed.Update(game);
    // vars.mallySweep.Update(game);
    // vars.mallyFinish.Update(game);
    // vars.up.Update(game);
    // vars.push.Update(game);
    // vars.homing.Update(game);
    // vars.crush.Update(game);
    // vars.hatterSweep.Update(game);
    // vars.hatterFinish.Update(game);
    // vars.invis.Update(game);
    // vars.catCombo.Update(game);
    // vars.backstab.Update(game);
    // vars.extraLife.Update(game);
    // vars.multiplier.Update(game);
    // vars.switchBomb.Update(game);

    vars.bandersnatchHealth.Update(game);
    vars.stayneHealth.Update(game);
    vars.jabberwockyPhase.Update(game);

    // TODO: Do we want to do this? This could have a hit on performance
    // We need to do this in here after the Update call
    if (version != "Steam")
    {
        // Reassign the old values
        if (oldAliceID != -1)
            vars.aliceID.Old = oldAliceID;
        if (oldStayneHealth != -1f)
            vars.stayneHealth.Old = oldStayneHealth;
        if (oldJabberPhase != 1)
            vars.jabberwockyPhase.Old = oldJabberPhase;
    }


    if (vars.GetInt(vars.map.Current) != vars.GetInt(vars.map.Old))
        vars.Log("Changed map from " + vars.GetInt(vars.map.Old) + " to " + vars.GetInt(vars.map.Current));

    // if not on main menu, run other checks, otherwise do nothing (allows reset block to run)
    if (vars.GetInt(vars.map.Current) != 0)
    {
        if (vars.GetInt(vars.mapSector.Current) != vars.GetInt(vars.mapSector.Old))
            vars.Log("Changed sector from " + vars.GetInt(vars.mapSector.Old) + " to " + vars.GetInt(vars.mapSector.Current) + " (map " + vars.GetInt(vars.map.Current) + ")");

        if (settings["game_time"])
            vars.SetTextComponent("IGT", TimeSpan.FromSeconds(vars.GetFloat(vars.gameTime.Current)).ToString(@"hh\:mm\:ss\.fff"));


        // achievement tracking for 100% runs
        if (settings["achievements"])
        {
            // TODO: Should these be looped over instead of manually checked?
            // TODO: Should Alice's Armour be included here? jabberwocky0 will occur at nearly the same time

            // if (!vars.achievementsDone.Contains("chests") && 
            //     ((vars.chests.Current == 1 && vars.chests.Old == 0) || (vars.SwapEndianness(vars.chests.Current) == 1 && vars.SwapEndianness(vars.chests.Old) == 0))
            // )
            //     vars.achievementsDone.Add("chests");

            // if (!vars.achievementsDone.Contains("bchests") && 
            //     ((vars.bchests.Current == 1 && vars.bchests.Old == 0) || (vars.SwapEndianness(vars.bchests.Current) == 1 && vars.SwapEndianness(vars.bchests.Old) == 0))
            // )
            //     vars.achievementsDone.Add("bchests");

            // if (!vars.achievementsDone.Contains("money") && 
            //     ((vars.money.Current == 1 && vars.money.Old == 0) || (vars.SwapEndianness(vars.money.Current) == 1 && vars.SwapEndianness(vars.money.Old) == 0))
            // )
            //     vars.achievementsDone.Add("money");

            // if (!vars.achievementsDone.Contains("enemies") && 
            //     ((vars.enemies.Current == 1 && vars.enemies.Old == 0) || (vars.SwapEndianness(vars.enemies.Current) == 1 && vars.SwapEndianness(vars.enemies.Old) == 0))
            // )
            //     vars.achievementsDone.Add("enemies");

            // if (!vars.achievementsDone.Contains("chess") && 
            //     ((vars.chess.Current == 1 && vars.chess.Old == 0) || (vars.SwapEndianness(vars.chess.Current) == 1 && vars.SwapEndianness(vars.chess.Old) == 0))
            // )
            //     vars.achievementsDone.Add("chess");

            // if (!vars.achievementsDone.Contains("upgrades") && 
            //     ((vars.upgrades.Current == 1 && vars.upgrades.Old == 0) || (vars.SwapEndianness(vars.upgrades.Current) == 1 && vars.SwapEndianness(vars.upgrades.Old) == 0))
            // )
            //     vars.achievementsDone.Add("upgrades");

            // if (!vars.achievementsDone.Contains("vegetation") && 
            //     ((vars.vegetation.Current == 1 && vars.vegetation.Old == 0) || (vars.SwapEndianness(vars.vegetation.Current) == 1 && vars.SwapEndianness(vars.vegetation.Old) == 0))
            // )
            //     vars.achievementsDone.Add("vegetation");

            // if (!vars.achievementsDone.Contains("furniture") && 
            //     ((vars.furniture.Current == 1 && vars.furniture.Old == 0) || (vars.SwapEndianness(vars.furniture.Current) == 1 && vars.SwapEndianness(vars.furniture.Old) == 0))
            // )
            //     vars.achievementsDone.Add("furniture");

            // if (!vars.achievementsDone.Contains("mosquitos") && 
            //     ((vars.mosquitos.Current == 1 && vars.mosquitos.Old == 0) || (vars.SwapEndianness(vars.mosquitos.Current) == 1 && vars.SwapEndianness(vars.mosquitos.Old) == 0))
            // )
            //     vars.achievementsDone.Add("mosquitos");

            // if (!vars.achievementsDone.Contains("pigs") && 
            //     ((vars.pigs.Current == 1 && vars.pigs.Old == 0) || (vars.SwapEndianness(vars.pigs.Current) == 1 && vars.SwapEndianness(vars.pigs.Old) == 0))
            // )
            //     vars.achievementsDone.Add("pigs");

            // if (!vars.achievementsDone.Contains("lizards") && 
            //     ((vars.lizards.Current == 1 && vars.lizards.Old == 0) || (vars.SwapEndianness(vars.lizards.Current) == 1 && vars.SwapEndianness(vars.lizards.Old) == 0))
            // )
            //     vars.achievementsDone.Add("lizards");

            // if (!vars.achievementsDone.Contains("birds") && 
            //     ((vars.birds.Current == 1 && vars.birds.Old == 0) || (vars.SwapEndianness(vars.birds.Current) == 1 && vars.SwapEndianness(vars.birds.Old) == 0))
            // )
            //     vars.achievementsDone.Add("birds");

            // if (!vars.achievementsDone.Contains("clocks") && 
            //     ((vars.clocks.Current == 1 && vars.clocks.Old == 0) || (vars.SwapEndianness(vars.clocks.Current) == 1 && vars.SwapEndianness(vars.clocks.Old) == 0))
            // )
            //     vars.achievementsDone.Add("clocks");

            // if (!vars.achievementsDone.Contains("roses") && 
            //     ((vars.roses.Current == 1 && vars.roses.Old == 0) || (vars.SwapEndianness(vars.roses.Current) == 1 && vars.SwapEndianness(vars.roses.Old) == 0))
            // )
            //     vars.achievementsDone.Add("roses");

            // if (!vars.achievementsDone.Contains("statues") && 
            //     ((vars.statues.Current == 1 && vars.statues.Old == 0) || (vars.SwapEndianness(vars.statues.Current) == 1 && vars.SwapEndianness(vars.statues.Old) == 0))
            // )
            //     vars.achievementsDone.Add("statues");

            // if (!vars.achievementsDone.Contains("paintings") && 
            //     ((vars.paintings.Current == 1 && vars.paintings.Old == 0) || (vars.SwapEndianness(vars.paintings.Current) == 1 && vars.SwapEndianness(vars.paintings.Old) == 0))
            // )
            //     vars.achievementsDone.Add("paintings");

            vars.SetTextComponent("Achievements: ", vars.achievementsDone.Count + "/24");
        }
    }
}

split
{
    // garden
    if (vars.GetInt(vars.map.Current) == 20)
    {
        if (!vars.splitsDone.Contains("garden_cake") && vars.GetInt(vars.aliceID.Current) == 5 && vars.GetInt(vars.aliceID.Old) == 4)
        {
            return vars.Split("garden_cake");
        }

        // if (!vars.splitsDone.Contains("enemy_freeze") && ((vars.enemyFreeze.Current == 1 && vars.enemyFreeze.Old == 0) || (vars.SwapEndianness(vars.enemyFreeze.Current) == 1 && vars.SwapEndianness(vars.enemyFreeze.Old) == 0)))
        // {
        //     vars.splitsDone.Add("enemy_freeze");
        //     return settings["enemy_freeze"];
        // }

        if (!vars.splitsDone.Contains("bandersnatch0") && vars.splitsDone.Contains("garden_cake") && vars.GetInt(vars.mapSector.Current) == 3 && vars.GetInt(vars.audioStatus.Current) == 1 && vars.GetInt(vars.audioStatus.Old) == 4 && vars.GetInt(vars.bandersnatchHealth.Current) == 3)
        {
            return vars.Split("bandersnatch0");
        }

        if (vars.splitsDone.Contains("bandersnatch0") && !vars.splitsDone.Contains("bandersnatch1") && vars.GetInt(vars.mapSector.Current) == 3 && vars.GetInt(vars.bandersnatchHealth.Current) == 2)
        {
            return vars.Split("bandersnatch1");
        }

        if (vars.splitsDone.Contains("bandersnatch1") && !vars.splitsDone.Contains("bandersnatch2") && vars.GetInt(vars.mapSector.Current) == 3 && vars.GetInt(vars.bandersnatchHealth.Current) == 1)
        {
            return vars.Split("bandersnatch2");
        }

        if (vars.splitsDone.Contains("bandersnatch2") && !vars.splitsDone.Contains("bandersnatch3") && vars.GetInt(vars.mapSector.Current) == 3 && vars.GetInt(vars.bandersnatchHealth.Current) == 1 && vars.GetInt(vars.audioStatus.Current) == 4 && vars.GetInt(vars.audioStatus.Old) == 1)
        {
            return vars.Split("bandersnatch3");
        }

        // if (!vars.splitsDone.Contains("find_absolem") && ((vars.findAbsolem.Current == 1 && vars.findAbsolem.Old == 0) || (vars.SwapEndianness(vars.findAbsolem.Current) == 1 && vars.SwapEndianness(vars.findAbsolem.Old) == 0)))
        // {
        //     vars.splitsDone.Add("find_absolem");
        //     return settings["find_absolem"];
        // }

        // if (!vars.splitsDone.Contains("invis") && ((vars.invis.Current == 1 && vars.invis.Old == 0) || (vars.SwapEndianness(vars.invis.Current) == 1 && vars.SwapEndianness(vars.invis.Old) == 0)))
        // {
        //     vars.splitsDone.Add("invis");
        //     return settings["invis"];
        // }
    }

    // tulgey
    if (vars.GetInt(vars.map.Current) == 30)
    {
        // if (!vars.splitsDone.Contains("mally_sweep") && ((vars.mallySweep.Current == 1 && vars.mallySweep.Old == 0) || (vars.SwapEndianness(vars.mallySweep.Current) == 1 && vars.SwapEndianness(vars.mallySweep.Old) == 0)))
        // {
        //     vars.splitsDone.Add("mally_sweep");
        //     return settings["mally_sweep"];
        // }

        // if (!vars.splitsDone.Contains("hatter_finish") && ((vars.hatterFinish.Current == 1 && vars.hatterFinish.Old == 0) || (vars.SwapEndianness(vars.hatterFinish.Current) == 1 && vars.SwapEndianness(vars.hatterFinish.Old) == 0)))
        // {
        //     vars.splitsDone.Add("hatter_finish");
        //     return settings["hatter_finish"];
        // }

        // if (!vars.splitsDone.Contains("mctwisp_combo") && ((vars.mctwispCombo.Current == 1 && vars.mctwispCombo.Old == 0) || (vars.SwapEndianness(vars.mctwispCombo.Current) == 1 && vars.SwapEndianness(vars.mctwispCombo.Old) == 0)))
        // {
        //     vars.splitsDone.Add("mctwisp_combo");
        //     return settings["mctwisp_combo"];
        // }
    }

    // hare house
    if (vars.GetInt(vars.map.Current) == 40)
    {
        // if (!vars.splitsDone.Contains("ach_hare_house") && ((vars.achHareHouse.Current == 1 && vars.achHareHouse.Old == 0) || (vars.SwapEndianness(vars.achHareHouse.Current) == 1 && vars.SwapEndianness(vars.achHareHouse.Old) == 0)))
        // {
        //     vars.splitsDone.Add("ach_hare_house");
        //     return settings["ach_hare_house"];
        // }

        // if (!vars.splitsDone.Contains("attack_speed") && ((vars.attackSpeed.Current == 1 && vars.attackSpeed.Old == 0) || (vars.SwapEndianness(vars.attackSpeed.Current) == 1 && vars.SwapEndianness(vars.attackSpeed.Old) == 0)))
        // {
        //     vars.splitsDone.Add("attack_speed");
        //     return settings["attack_speed"];
        // }

        // if (!vars.splitsDone.Contains("cat_combo") && ((vars.catCombo.Current == 1 && vars.catCombo.Old == 0) || (vars.SwapEndianness(vars.catCombo.Current) == 1 && vars.SwapEndianness(vars.catCombo.Old) == 0)))
        // {
        //     vars.splitsDone.Add("cat_combo");
        //     return settings["cat_combo"];
        // }
    }

    // hightopps
    if (vars.GetInt(vars.map.Current) == 50)
    {
        // if (!vars.splitsDone.Contains("push") && ((vars.push.Current == 1 && vars.push.Old == 0) || (vars.SwapEndianness(vars.push.Current) == 1 && vars.SwapEndianness(vars.push.Old) == 0)))
        // {
        //     vars.splitsDone.Add("push");
        //     return settings["push"];
        // }
    }

    // cabin
    if (vars.GetInt(vars.map.Current) == 60)
    {
        // "large" alice is not the same Alice NPC, and does not have it's own id here
        // "small" alice (entering cabin) -> "normal" alice after pishalver
        if (!vars.splitsDone.Contains("cabin_pishsalver") && vars.GetInt(vars.aliceID.Current) == 5 && vars.GetInt(vars.aliceID.Old) == 4)
        {
            return vars.Split("cabin_pishsalver");
        }

        // if (!vars.splitsDone.Contains("homing") && ((vars.homing.Current == 1 && vars.homing.Old == 0) || (vars.SwapEndianness(vars.homing.Current) == 1 && vars.SwapEndianness(vars.homing.Old) == 0)))
        // {
        //     vars.splitsDone.Add("homing");
        //     return settings["homing"];
        // }

        // if (!vars.splitsDone.Contains("back2vortex") && ((vars.back2Vortex.Current == 1 && vars.back2Vortex.Old == 0) || (vars.SwapEndianness(vars.back2Vortex.Current) == 1 && vars.SwapEndianness(vars.back2Vortex.Old) == 0)))
        // {
        //     vars.splitsDone.Add("back2vortex");
        //     return settings["back2vortex"];
        // }

        // if (!vars.splitsDone.Contains("up") && ((vars.up.Current == 1 && vars.up.Old == 0) || (vars.SwapEndianness(vars.up.Current) == 1 && vars.SwapEndianness(vars.up.Old) == 0)))
        // {
        //     vars.splitsDone.Add("up");
        //     return settings["up"];
        // }
    }

    // red desert
    if (vars.GetInt(vars.map.Current) == 70)
    {
        // if (!vars.splitsDone.Contains("crush") && ((vars.crush.Current == 1 && vars.crush.Old == 0) || (vars.SwapEndianness(vars.crush.Current) == 1 && vars.SwapEndianness(vars.crush.Old) == 0)))
        // {
        //     vars.splitsDone.Add("crush");
        //     return settings["crush"];
        // }

        // if (!vars.splitsDone.Contains("extra_life") && ((vars.extraLife.Current == 1 && vars.extraLife.Old == 0) || (vars.SwapEndianness(vars.extraLife.Current) == 1 && vars.SwapEndianness(vars.extraLife.Old) == 0)))
        // {
        //     vars.splitsDone.Add("extra_life");
        //     return settings["extra_life"];
        // }
    }

    // moat
    if (vars.GetInt(vars.map.Current) == 75)
    {
        // if (!vars.splitsDone.Contains("switch_bomb") && ((vars.switchBomb.Current == 1 && vars.switchBomb.Old == 0) || (vars.SwapEndianness(vars.switchBomb.Current) == 1 && vars.SwapEndianness(vars.switchBomb.Old) == 0)))
        // {
        //     vars.splitsDone.Add("switch_bomb");
        //     return settings["switch_bomb"];
        // }

        // if (!vars.splitsDone.Contains("hatter_sweep") && ((vars.hatterSweep.Current == 1 && vars.hatterSweep.Old == 0) || (vars.SwapEndianness(vars.hatterSweep.Current) == 1 && vars.SwapEndianness(vars.hatterSweep.Old) == 0)))
        // {
        //     vars.splitsDone.Add("hatter_sweep");
        //     return settings["hatter_sweep"];
        // }
    }

    // salazen grum
    if (vars.GetInt(vars.map.Current) == 80)
    {
        // if (!vars.splitsDone.Contains("ach_rq") && ((vars.achRq.Current == 1 && vars.achRq.Old == 0) || (vars.SwapEndianness(vars.achRq.Current) == 1 && vars.SwapEndianness(vars.achRq.Old) == 0)))
        // {
        //     vars.splitsDone.Add("ach_rq");
        //     return settings["ach_rq"];
        // }

        // if (!vars.splitsDone.Contains("ach_rq_potion") && ((vars.achRqPotion.Current == 1 && vars.achRqPotion.Old == 0) || (vars.SwapEndianness(vars.achRqPotion.Current) == 1 && vars.SwapEndianness(vars.achRqPotion.Old) == 0)))
        // {
        //     vars.splitsDone.Add("ach_rq_potion");
        //     return settings["ach_rq_potion"];
        // }

        // if (!vars.splitsDone.Contains("mally_finish") && ((vars.mallyFinish.Current == 1 && vars.mallyFinish.Old == 0) || (vars.SwapEndianness(vars.mallyFinish.Current) == 1 && vars.SwapEndianness(vars.mallyFinish.Old) == 0)))
        // {
        //     vars.splitsDone.Add("mally_finish");
        //     return settings["maly_finish"];
        // }

        // if (!vars.splitsDone.Contains("backstab") && ((vars.backstab.Current == 1 && vars.backstab.Old == 0) || (vars.SwapEndianness(vars.backstab.Current) == 1 && vars.SwapEndianness(vars.backstab.Old) == 0)))
        // {
        //     vars.splitsDone.Add("backstab");
        //     return settings["backstab"];
        // }
    }

    // bandersnatch stables
    if (vars.GetInt(vars.map.Current) == 85)
    {
        if (!vars.splitsDone.Contains("stayne0") && vars.splitsDone.Contains("ach_rq_potion") && vars.GetFloat(vars.stayneHealth.Current) == 1500f  && vars.GetInt(vars.audioStatus.Current) == 1 && vars.GetInt(vars.audioStatus.Old) == 4)
        {
            return vars.Split("stayne0");
        }

        if (!vars.splitsDone.Contains("stayne1") && vars.splitsDone.Contains("stayne0") && vars.GetFloat(vars.stayneHealth.Current) < 1000f)
        {
            return vars.Split("stayne1");
        }

        if (!vars.splitsDone.Contains("stayne2") && vars.splitsDone.Contains("stayne1") && vars.GetFloat(vars.stayneHealth.Current) < 500f)
        {
            return vars.Split("stayne2");
        }

        if (!vars.splitsDone.Contains("stayne3") && vars.splitsDone.Contains("stayne2") && vars.GetFloat(vars.stayneHealth.Current) == 0f && vars.GetInt(vars.audioStatus.Current) == 4)
        {
            return vars.Split("stayne3");
        }
    }

    // marmoreal
    if (vars.GetInt(vars.map.Current) == 90)
    {
        // if (!vars.splitsDone.Contains("visit_wq") && ((vars.visitWq.Current == 1 && vars.visitWq.Old == 0) || (vars.SwapEndianness(vars.visitWq.Current) == 1 && vars.SwapEndianness(vars.visitWq.Old) == 0)))
        // {
        //     vars.splitsDone.Add("visit_wq");
        //     return settings["visit_wq"];
        // }

        // if (!vars.splitsDone.Contains("multiplier") && ((vars.multiplier.Current == 1 && vars.multiplier.Old == 0) || (vars.SwapEndianness(vars.multiplier.Current) == 1 && vars.SwapEndianness(vars.multiplier.Old) == 0)))
        // {
        //     vars.splitsDone.Add("multiplier");
        //     return settings["multiplier"];
        // }
    }

    // frabjous
    if (vars.GetInt(vars.map.Current) == 100)
    {
        // TODO: Should this split be moved to the `update` block?
        // if (!vars.splitsDone.Contains("armour") &&
        //     ((vars.armour.Current == 1 && vars.armour.Old == 0) || (vars.SwapEndianness(vars.armour.Current) == 1 && vars.SwapEndianness(vars.armour.Old) == 0)))
        // {
        //     vars.splitsDone.Add("armour");
        //     return settings["armour"];
        // }

        if (!vars.splitsDone.Contains("jabberwocky0") && vars.GetInt(vars.mapSector.Current) == 2 && vars.GetInt(vars.audioStatus.Current) == 1 && vars.GetInt(vars.audioStatus.Old) == 4 && vars.GetInt(vars.jabberwockyPhase.Current) == 1)
        {
            return vars.Split("jabberwocky0");
        }

        if (!vars.splitsDone.Contains("jabberwocky1") && vars.splitsDone.Contains("jabberwocky0") && vars.GetInt(vars.mapSector.Current) == 2 && vars.GetInt(vars.jabberwockyPhase.Current) == 2)
        {
            return vars.Split("jabberwocky1");
        }

        if (!vars.splitsDone.Contains("jabberwocky2") && vars.splitsDone.Contains("jabberwocky1") && vars.GetInt(vars.mapSector.Current) == 2 && vars.GetInt(vars.jabberwockyPhase.Current) == 3)
        {
            return vars.Split("jabberwocky2");
        }

        if (!vars.splitsDone.Contains("jabberwocky3") && vars.splitsDone.Contains("jabberwocky2") && vars.GetInt(vars.mapSector.Current) == 2 && vars.GetInt(vars.jabberwockyPhase.Current) == 4)
        {
            return vars.Split("jabberwocky3");
        }

        if (!vars.splitsDone.Contains("jabberwocky4") && vars.splitsDone.Contains("jabberwocky3") && vars.GetInt(vars.mapSector.Current) == 2 && vars.GetInt(vars.jabberwockyPhase.Current) == 4 && vars.GetInt(vars.audioStatus.Old) == 1 && vars.GetInt(vars.audioStatus.Current) == 4)
        {
            return vars.Split("jabberwocky4");
        }
    }

    // no quest triggered
    return false;
}

reset
{
    // NOTE: IF THE GAME BUGS AND YOU NEED TO SAVE +RELOAD, THIS WILL RESET THE TIMER
    if (vars.GetInt(vars.map.Old) == -1 && vars.GetInt(vars.map.Current) == 0)
    {
        vars.Log("Exiting to Menu - Resetting");
        return true;
    }
}

onStart
{
    // include addressess in every log file
    vars.Log("Mem1 Base Address: 0x" + vars.mem1.ToString("X"));
    vars.Log("Mem2 Base Address: 0x" + vars.mem2.ToString("X"));
}

onReset
{
    vars.splitsDone.Clear();
    vars.achievementsDone.Clear();
    if (settings["achievements"])
        vars.SetTextComponent("Achievements: ", "0/24");
}

shutdown
{
    if (settings["achievements"])
        vars.SetTextComponent("Achievements: ", "0/24");
}

isLoading
{
    return settings["load_removal"] && vars.GetInt(vars.map.Current) == -1;
}
