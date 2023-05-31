//========================================================//
// Alice In Wonderland 2010 AutoSplitter and Load Remover //
//        Created by https://github.com/DeathHound6       //
//========================================================//

// map
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

// character id
// -1 - menu
// 0 - hare
// 1 - cat
// 2 - mally
// 3 - hatter
// 4 - mctwisp

// playing
// 1 - playing
// 4 - prerendered cutscene
// 0 - loading

state("Alice", "Steam") {}

// state("Dolphin", "Dolphin Wii NTSC-U") {}

// state("Dolphin", "Dolphin Wii PAL") {}

startup
{
    // if (timer.CurrentTimingMethod == TimingMethod.RealTime) // stolen from dude simulator 3, basically asks the runner to set their livesplit to game time
    // {
    //     var timingMessage = MessageBox.Show
    //     (
    //        //"This game uses Real Time as the main timing method.\n"+
    //        "To allow the autosplitter to function, the timing method should be set to Game Time.\n"+
    //         "LiveSplit is currently set to show Real Time.\n"+
    //         "Would you like to set the timing method to Game Time?\n"+
    //         "This will make submission and verification easier",
    //         "LiveSplit | Alice In Wonderland 2010",
    //         MessageBoxButtons.YesNo,
    //         MessageBoxIcon.Question
    //     );
    //     if (timingMessage == DialogResult.Yes)
    //     {
    //         timer.CurrentTimingMethod = TimingMethod.GameTime;
    //     }
    // }

    settings.Add("load_removal", false, "Load Remover (Disallowed for leaderboard runs)");
    settings.Add("achievements", false, "Track In-Game Achievements (for 100% runs)");

    settings.Add("garden", true, "Strange Garden");
    //settings.Add("find_alice", false, "Find Alice", "garden");
    settings.Add("hare", false, "Unlock March Hare", "garden");
    settings.Add("find_absolem", false, "Find Absolem/Defeat Bandersnatch", "garden");
    settings.Add("enemy_freeze", false, "Collect Enemy Freeze chess piece", "garden");
    settings.Add("invis", false, "Collect Extended Invisibility chess piece", "garden");

    settings.Add("woods", true, "Tulgey Woods");
    settings.Add("mally_sweep", false, "Collect Mallymkin Sweep chess piece", "woods");
    settings.Add("hatter_finish", false, "Collect Hatter Finishing Move chess piece", "woods");
    settings.Add("mctwisp_combo", false, "Collect McTwisp 3 Hit Combo chess piece", "woods");

    settings.Add("hare_house", true, "March Hare House");
    settings.Add("hatter", false, "Unlock Mad Hatter", "hare_house");
    settings.Add("ach_hare_house", false, "March Hare House Achievement", "hare_house");
    settings.Add("attack_speed", false, "Collect 2x Attack Speed chess piece", "hare_house");
    settings.Add("cat_combo", false, "Collect Chessur 3 Hit Combo chess piece", "hare_house");

    settings.Add("cabin", true, "Cabin");
    //settings.Add("cake", false, "Collect Upelkuchen Cake", "cabin");
    //settings.Add("cabin_pishsalver", false, "Collect Pishsalver", "cabin");
    settings.Add("homing", false, "Collect Homing Dishes chess piece", "cabin");
    settings.Add("back2vortex", false, "Collect Back to Vortex chess piece", "cabin");
    settings.Add("up", false, "Collect Up chess piece", "cabin");

    settings.Add("hightopps", true, "Hightopps");
    //settings.Add("great_clock", false, "Activate the Great Hightopps Clock", "hightopps");
    settings.Add("push", false, "Collect Push chess piece", "hightopps");

    settings.Add("desert", true, "Red Desert");
    settings.Add("crush", false, "Collect Crush chess piece", "desert");
    settings.Add("extra_life", false, "Collect Extra Life chess piece", "desert");

    settings.Add("moat", true, "Moat");
    settings.Add("cat", false, "Unlock Cheshire Cat", "moat");
    settings.Add("switch_bomb", false, "Collect Switch Bomb chess piece", "moat");
    settings.Add("hatter_sweep", false, "Collect Hatter Sweep chess piece", "moat");

    settings.Add("rq", true, "Salazen Grum - Red Queen");
    settings.Add("ach_rq", false, "Reach Salazen Grum", "rq");
    settings.Add("ach_rq_potion", false, "Collect Pishsalver", "rq");
    settings.Add("mally_finish", false, "Collect Mallymkin Finishing Move chess piece", "rq");
    settings.Add("backstab", false, "Collect Backstab chess piece", "rq");

    settings.Add("stables", true, "Bandersnatch Stables");
    settings.Add("stayne", false, "Collect Vorpal Sword/Defeat Stayne", "stables");

    settings.Add("wq", true, "Marmoreal - White Queen");
    settings.Add("visit_wq", false, "Visit White Queen", "wq");
    settings.Add("mulitiplier", false, "Collect Impossible Ideas Multiplier chess piece", "wq");

    settings.Add("frabjous", true, "Frabjous Day");
    settings.Add("armour", false, "Collect Alice's Armor", "frabjous")
    //settings.Add("jabberwocky", false, "Kill Jabberwocky (End)", "frabjous");
}

init
{
    // if (game.ProcessName == "Dolphin")
    // {
    //     foreach (var item in ExtensionMethods.MemoryPages(game, true))
    //     {
    //         if (item.Type == MemPageType.MEM_MAPPED && item.AllocationProtect == MemPageProtect.PAGE_READWRITE && item.State == MemPageState.MEM_COMMIT
    //             && item.Protect == MemPageProtect.PAGE_READWRITE && item.RegionSize.ToString() == "33554432")
    //         {
    //             vars.mem1 = item.BaseAddress;
    //             vars.mem2 = (
    //                 long.Parse(item.BaseAddress.ToString("X"), System.Globalization.NumberStyles.HexNumber) +
    //                 long.Parse(item.RegionSize.ToString(), System.Globalization.NumberStyles.HexNumber)
    //             );
    //             break;
    //         }
    //     }
    //     print("Mem1 Base Address: 0x" + vars.mem1.ToString("X"));
    //     print("Mem2 Base Address: 0x" + vars.mem2.ToString("X"));
    //     switch(ExtensionMethods.ReadString(game, (IntPtr)vars.mem1, 6))
    //     {
    //         case "SALP4Q":
    //             version = "Dolphin Wii PAL";
    //             break;
    //         case "SALE4Q":
    //             version = "Dolphin Wii NTSC-U";
    //             break;
    //     }
    // }
    /*else*/ if (game.ProcessName == "Alice")
        version = "Steam";

    // if (version.Contains("Dolphin") && timer.Run.Offset != TimeSpan.FromSeconds(3.72))
    // {
    //     var timingMessage = MessageBox.Show
    //     (
    //        "For running on Emulator, the timer offset must be set to 3.72 seconds.\n" +
    //         "Would you like to set the Timer Offset to 3.72 seconds?",
    //         "LiveSplit | Alice In Wonderland 2010",
    //         MessageBoxButtons.YesNo,
    //         MessageBoxIcon.Question
    //     );
    //     if (timingMessage == DialogResult.Yes)
    //     {
    //         timer.Run.Offset = TimeSpan.FromSeconds(3.72);
    //     }
    // }

    // set text taken from Poppy Playtime C2
    // used here for showing completed achievement count - for 100% runs
    vars.SetTextComponent = (Action<string, string>)((id, text) => {
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
    });
    // function content taken from https://github.com/LiveSplit/LiveSplit/blob/master/LiveSplit/LiveSplit.Core/Model/NTP.cs
    // function is required for dolphin since it's BE
    vars.SwapEndianness = (Func<ulong, uint>)((num) => {
        return (uint)(((num & 0x000000ff) << 24) +
                        ((num & 0x0000ff00) << 8) +
                        ((num & 0x00ff0000) >> 8) +
                        ((num & 0xff000000) >> 24));
    });

    vars.splitsDone = new List<string>();
    vars.achievementsDone = new List<string>();

    if (version.Contains("Wii"))
    {
        // convert to BE - doing so when reading Current/Old
        // vars.map = new MemoryWatcher<uint>((IntPtr)((int)vars.mem1 + (int)0x77F8F0));
        // vars.charID = new MemoryWatcher<uint>((IntPtr)((int)vars.mem1 + (int)0x7DA583));
        //vars.playing = new MemoryWatcher<uint>();

        // vars.roundHall = new MemoryWatcher<uint>((IntPtr)((int)vars.mem1 + (int)0x7E2534));
        // vars.findAbsolem = new MemoryWatcher<uint>();

        //vars.hatter = new MemoryWatcher<uint>();

        //vars.vorpal = new MemoryWatcher<uint>();

        //vars.visitWq = new MemoryWatcher<uint>();

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
    }
    else if (version == "Steam")
    {
        vars.gameTime = new MemoryWatcher<float>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x4C, 0x44, 0x10));
        vars.map = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x4C, 0x2BC));
        // vars.charID = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x90, 0x54, 0x180, 0x13C));
        // vars.playing = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x1C, 0xC, 0x0, 0x4, 0x10C, 0x0, 0xC));

        vars.roundHall = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x264, 0x1C));
        // vars.findAlice = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x45CF24, 0x4, 0x168, 0x10, 0x18, 0x18, 0x74, 0xC30));
        vars.hare = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x20C, 0x1C));
        vars.findAbsolem = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x248, 0x1C));

        vars.hatter = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x21C, 0x1C));
        vars.achHareHouse = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x24C, 0x1C));

        vars.cat = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x22C, 0x1C));

        vars.rq = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x250, 0x1C));
        vars.rqPotion = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x254, 0x1C));
        vars.vorpal = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x258, 0x1C));
        vars.visitWq = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x25C, 0x1C));
        vars.armour = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x260, 0x1C));

        vars.chests = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x268, 0x1C));
        vars.bchests = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x26C, 0x1C));
        vars.money = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x270, 0x1C));
        vars.enemies = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x274, 0x1C));
        vars.chess = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x278, 0x1C));
        vars.upgrades = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x27C, 0x1C));
        vars.vegetation = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x280, 0x1C));
        vars.furniture = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x284, 0x1C));
        vars.mosquitos = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x288, 0x1C));
        vars.pigs = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x28C, 0x1C));
        vars.lizards = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x290, 0x1C));
        vars.birds = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x294, 0x1C));
        vars.clocks = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x298, 0x1C));
        vars.roses = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x29C, 0x1C));
        vars.statues = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x2A0, 0x1C));
        vars.paintings = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x2A4, 0x1C));

        vars.extraLife = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x384, 0x1C));
        vars.multiplier = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x388, 0x1C));
        vars.switchBomb = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x38C, 0x1C));
        vars.enemyFreeze = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x390, 0x1C));
        vars.back2Vortex = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x394, 0x1C));
        vars.mctwispCombo = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x398, 0x1C));
        vars.attackSpeed = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x39C, 0x1C));
        vars.mallySweep = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3A0, 0x1C));
        vars.mallyFinish = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3A4, 0x1C));
        vars.up = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3A8, 0x1C));
        vars.push = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3AC, 0x1C));
        vars.homing = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3B0, 0x1C));
        vars.crush = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3B4, 0x1C));
        vars.hatterSweep = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3B8, 0x1C));
        vars.hatterFinish = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3BC, 0x1C));
        vars.catCombo = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3C0, 0x1C));
        vars.invis = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3C4, 0x1C));
        vars.backstab = new MemoryWatcher<int>(new DeepPointer("Alice.exe", 0x44B8A8, 0x34, 0x44, 0x54, 0x3C8, 0x1C));
    }
}

start
{
    // swap Endian for Dolphin only since it's values are in BE
    // steam version values are in LE
    if (
        (vars.roundHall.Old == 0 && vars.roundHall.Current == 1 && vars.map.Current == 10) ||
        (ars.SwapEndianness(vars.roundHall.Old) == 0 && vars.SwapEndianness(vars.roundHall.Current) == 1 && vars.SwapEndianness(vars.map.Current) == 10)
    ) {
        vars.achievementsDone.Add("round_hall");
        return true;
    }
}

update
{
    vars.map.Update(game);
    // vars.charID.Update(game);
    // vars.playing.Update(game);

    vars.roundHall.Update(game);
    // vars.findAlice.Update(game);
    vars.hare.Update(game);
    vars.findAbsolem.Update(game);
    vars.hatter.Update(game);
    vars.achHareHouse.Update(game);
    vars.cat.Update(game);
    vars.achRq.Update(game):
    vars.achRqPotion.Update(game);
    vars.stayne.Update(game);
    vars.visitWq.Update(game);
    vars.armour.Update(game);

    vars.chests.Update(game);
    vars.bchests.Update(game);
    vars.money.Update(game);
    vars.enemies.Update(game);
    vars.chess.Update(game);
    vars.upgrades.Update(game);
    vars.vegetation.Update(game);
    vars.furniture.Update(game);
    vars.mosquitos.Update(game);
    vars.pigs.Update(game);
    vars.lizards.Update(game);
    vars.birds.Update(game);
    vars.clocks.Update(game);
    vars.roses.Update(game);
    vars.statues.Update(game);
    vars.paintings.Update(game);

    vars.enemyFreeze.Update(game);
    vars.back2Vortex.Update(game);
    vars.mctwispCombo.Update(game);
    vars.attackSpeed.Update(game);
    vars.mallySweep.Update(game);
    vars.mallyFinish.Update(game);
    vars.up.Update(game);
    vars.push.Update(game);
    vars.homing.Update(game);
    vars.crush.Update(game);
    vars.hatterSweep.Update(game);
    vars.hatterFinish.Update(game);
    vars.invis.Update(game);
    vars.catCombo.Update(game);
    vars.backstab.Update(game);
    vars.extraLife.Update(game);
    vars.multiplier.Update(game);
    vars.switchBomb.Update(game);

    // if on main menu, dont run anything else
    if (vars.map.Current == 0 || vars.SwapEndianness(vars.map.Current) == 0)
    {
        if (vars.map.Old != 0 || vars.SwapEndianness(vars.map.Old) != 0)
            vars.achievementsDone.Clear();
        return false;
    }

    // achievement tracking for 100% runs
    if (settings["achievements"])
    {
        if (!vars.achievementsDone.Contains("chests") && 
            ((vars.chests.Current == 1 && vars.chests.Old == 0) || (vars.SwapEndianness(vars.chests.Current) == 1 && vars.SwapEndianness(vars.chests.Old) == 0))
        )
            achievementsDone.Add("chests");

        if (!vars.achievementsDone.Contains("bchests") && 
            ((vars.bchests.Current == 1 && vars.bchests.Old == 0) || (vars.SwapEndianness(vars.bchests.Current) == 1 && vars.SwapEndianness(vars.bchests.Old) == 0))
        )
            achievementsDone.Add("bchests");

        if (!vars.achievementsDone.Contains("money") && 
            ((vars.money.Current == 1 && vars.money.Old == 0) || (vars.SwapEndianness(vars.money.Current) == 1 && vars.SwapEndianness(vars.money.Old) == 0))
        )
            achievementsDone.Add("money");

        if (!vars.achievementsDone.Contains("enemies") && 
            ((vars.enemies.Current == 1 && vars.enemies.Old == 0) || (vars.SwapEndianness(vars.enemies.Current) == 1 && vars.SwapEndianness(vars.enemies.Old) == 0))
        )
            achievementsDone.Add("enemies");

        if (!vars.achievementsDone.Contains("chess") && 
            ((vars.chess.Current == 1 && vars.chess.Old == 0) || (vars.SwapEndianness(vars.chess.Current) == 1 && vars.SwapEndianness(vars.chess.Old) == 0))
        )
            achievementsDone.Add("chess");

        if (!vars.achievementsDone.Contains("upgrades") && 
            ((vars.upgrades.Current == 1 && vars.upgrades.Old == 0) || (vars.SwapEndianness(vars.upgrades.Current) == 1 && vars.SwapEndianness(vars.upgrades.Old) == 0))
        )
            achievementsDone.Add("upgrades");

        if (!vars.achievementsDone.Contains("vegetation") && 
            ((vars.vegetation.Current == 1 && vars.vegetation.Old == 0) || (vars.SwapEndianness(vars.vegetation.Current) == 1 && vars.SwapEndianness(vars.vegetation.Old) == 0))
        )
            achievementsDone.Add("vegetation");

        if (!vars.achievementsDone.Contains("furniture") && 
            ((vars.furniture.Current == 1 && vars.furniture.Old == 0) || (vars.SwapEndianness(vars.furniture.Current) == 1 && vars.SwapEndianness(vars.furniture.Old) == 0))
        )
            achievementsDone.Add("furniture");

        if (!vars.achievementsDone.Contains("mosquitos") && 
            ((vars.mosquitos.Current == 1 && vars.mosquitos.Old == 0) || (vars.SwapEndianness(vars.mosquitos.Current) == 1 && vars.SwapEndianness(vars.mosquitos.Old) == 0))
        )
            achievementsDone.Add("mosquitos");

        if (!vars.achievementsDone.Contains("pigs") && 
            ((vars.pigs.Current == 1 && vars.pigs.Old == 0) || (vars.SwapEndianness(vars.pigs.Current) == 1 && vars.SwapEndianness(vars.pigs.Old) == 0))
        )
            achievementsDone.Add("pigs");

        if (!vars.achievementsDone.Contains("lizards") && 
            ((vars.lizards.Current == 1 && vars.lizards.Old == 0) || (vars.SwapEndianness(vars.lizards.Current) == 1 && vars.SwapEndianness(vars.lizards.Old) == 0))
        )
            achievementsDone.Add("lizards");

        if (!vars.achievementsDone.Contains("birds") && 
            ((vars.birds.Current == 1 && vars.birds.Old == 0) || (vars.SwapEndianness(vars.birds.Current) == 1 && vars.SwapEndianness(vars.birds.Old) == 0))
        )
            achievementsDone.Add("birds");

        if (!vars.achievementsDone.Contains("clocks") && 
            ((vars.clocks.Current == 1 && vars.clocks.Old == 0) || (vars.SwapEndianness(vars.clocks.Current) == 1 && vars.SwapEndianness(vars.clocks.Old) == 0))
        )
            achievementsDone.Add("clocks");

        if (!vars.achievementsDone.Contains("roses") && 
            ((vars.roses.Current == 1 && vars.roses.Old == 0) || (vars.SwapEndianness(vars.roses.Current) == 1 && vars.SwapEndianness(vars.roses.Old) == 0))
        )
            achievementsDone.Add("roses");

        if (!vars.achievementsDone.Contains("statues") && 
            ((vars.statues.Current == 1 && vars.statues.Old == 0) || (vars.SwapEndianness(vars.statues.Current) == 1 && vars.SwapEndianness(vars.statues.Old) == 0))
        )
            achievementsDone.Add("statues");

        if (!vars.achievementsDone.Contains("paintings") && 
            ((vars.paintings.Current == 1 && vars.paintings.Old == 0) || (vars.SwapEndianness(vars.paintings.Current) == 1 && vars.SwapEndianness(vars.paintings.Old) == 0))
        )
            achievementsDone.Add("paintings");

        vars.SetTextComponent("Achievements: ", vars.achievementsDone.Count + "/24");
    }
}

split
{
    // garden
    if (!vars.splitsDone.Contains("hare") && ((vars.hare.Current == 1 && vars.hare.Old == 0) || (vars.SwapEndianness(vars.hare.Current) == 1 && vars.SwapEndianness(vars.hare.Old) == 0)))
    {
        vars.splitsDone.Add("hare");
        return settings["hare"];
    }
    if (!vars.splitsDone.Contains("find_absolem") && ((vars.findAbsolem.Current == 1 && vars.findAbsolem.Old == 0) || (vars.SwapEndianness(vars.findAbsolem.Current) == 1 && vars.SwapEndianness(vars.findAbsolem.Old) == 0)))
    {
        vars.splitsDone.Add("find_absolem");
        return settings["find_absolem"];
    }
    if (!vars.splitsDone.Contains("enemy_freeze") && ((vars.enemyFreeze.Current == 1 && vars.enemyFreeze.Old == 0) || (vars.SwapEndianness(vars.enemyFreeze.Current) == 1 && vars.SwapEndianness(vars.enemyFreeze.Old) == 0)))
    {
        vars.splitsDone.Add("enemy_freeze");
        return settings["enemy_freeze"];
    }
    if (!vars.splitsDone.Contains("invis") && ((vars.invis.Current == 1 && vars.invis.Old == 0) || (vars.SwapEndianness(vars.invis.Current) == 1 && vars.SwapEndianness(vars.invis.Old) == 0)))
    {
        vars.splitsDone.Add("invis");
        return settings["invis"];
    }

    // tulgey
    if (!vars.splitsDone.Contains("mally_sweep") && ((vars.mallySweep.Current == 1 && vars.mallySweep.Old == 0) || (vars.SwapEndianness(vars.mallySweep.Current) == 1 && vars.SwapEndianness(vars.mallySweep.Old) == 0)))
    {
        vars.splitsDone.Add("mally_sweep");
        return settings["mally_sweep"];
    }
    if (!vars.splitsDone.Contains("hatter_finish") && ((vars.hatterFinish.Current == 1 && vars.hatterFinish.Old == 0) || (vars.SwapEndianness(vars.hatterFinish.Current) == 1 && vars.SwapEndianness(vars.hatterFinish.Old) == 0)))
    {
        vars.splitsDone.Add("hatter_finish");
        return settings["hatter_finish"];
    }
    if (!vars.splitsDone.Contains("mctwisp_combo") && ((vars.mctwispCombo.Current == 1 && vars.mctwispCombo.Old == 0) || (vars.SwapEndianness(vars.mctwispCombo.Current) == 1 && vars.SwapEndianness(vars.mctwispCombo.Old) == 0)))
    {
        vars.splitsDone.Add("mctwisp_combo");
        return settings["mctwisp_combo"];
    }

    // hare house
    if (!vars.splitsDone.Contains("hatter") && ((vars.hatter.Current == 1 && vars.hatter.Old == 0) || (vars.SwapEndianness(vars.hatter.Current) == 1 && vars.SwapEndianness(vars.hatter.Old) == 0)))
    {
        vars.splitsDone.Add("hatter");
        return settings["hatter"];
    }
    if (!vars.splitsDone.Contains("ach_hare_house") && ((vars.achHareHouse.Current == 1 && vars.achHareHouse.Old == 0) || (vars.SwapEndianness(vars.achHareHouse.Current) == 1 && vars.SwapEndianness(vars.achHareHouse.Old) == 0)))
    {
        vars.splitsDone.Add("ach_hare_house");
        return settings["ach_hare_house"];
    }
    if (!vars.splitsDone.Contains("attack_speed") && ((vars.attackSpeed.Current == 1 && vars.attackSpeed.Old == 0) || (vars.SwapEndianness(vars.attackSpeed.Current) == 1 && vars.SwapEndianness(vars.attackSpeed.Old) == 0)))
    {
        vars.splitsDone.Add("attack_speed");
        return settings["attack_speed"];
    }
    if (!vars.splitsDone.Contains("cat_combo") && ((vars.catCombo.Current == 1 && vars.catCombo.Old == 0) || (vars.SwapEndianness(vars.catCombo.Current) == 1 && vars.SwapEndianness(vars.catCombo.Old) == 0)))
    {
        vars.splitsDone.Add("cat_combo");
        return settings["cat_combo"];
    }

    // cabin
    if (!vars.splitsDone.Contains("homing") && ((vars.homing.Current == 1 && vars.homing.Old == 0) || (vars.SwapEndianness(vars.homing.Current) == 1 && vars.SwapEndianness(vars.homing.Old) == 0)))
    {
        vars.splitsDone.Add("homing");
        return settings["homing"];
    }
    if (!vars.splitsDone.Contains("back2vortex") && ((vars.back2Vortex.Current == 1 && vars.back2Vortex.Old == 0) || (vars.SwapEndianness(vars.back2Vortex.Current) == 1 && vars.SwapEndianness(vars.back2Vortex.Old) == 0)))
    {
        vars.splitsDone.Add("back2vortex");
        return settings["back2vortex"];
    }
    if (!vars.splitsDone.Contains("up") && ((vars.up.Current == 1 && vars.up.Old == 0) || (vars.SwapEndianness(vars.up.Current) == 1 && vars.SwapEndianness(vars.up.Old) == 0)))
    {
        vars.splitsDone.Add("up");
        return settings["up"];
    }

    // hightopps
    if (!vars.splitsDone.Contains("push") && ((vars.push.Current == 1 && vars.push.Old == 0) || (vars.SwapEndianness(vars.push.Current) == 1 && vars.SwapEndianness(vars.push.Old) == 0)))
    {
        vars.splitsDone.Add("push");
        return settings["push"];
    }

    // red desert
    if (!vars.splitsDone.Contains("crush") && ((vars.crush.Current == 1 && vars.crush.Old == 0) || (vars.SwapEndianness(vars.crush.Current) == 1 && vars.SwapEndianness(vars.crush.Old) == 0)))
    {
        vars.splitsDone.Add("crush");
        return settings["crush"];
    }
    if (!vars.splitsDone.Contains("extra_life") && ((vars.extraLife.Current == 1 && vars.extraLife.Old == 0) || (vars.SwapEndianness(vars.extraLife.Current) == 1 && vars.SwapEndianness(vars.extraLife.Old) == 0)))
    {
        vars.splitsDone.Add("extra_life");
        return settings["extra_life"];
    }

    // moat
    if (!vars.splitsDone.Contains("cat") && ((vars.cat.Current == 1 && vars.cat.Old == 0) || (vars.SwapEndianness(vars.cat.Current) == 1 && vars.SwapEndianness(vars.cat.Old) == 0)))
    {
        vars.splitsDone.Add("cat");
        return settings["cat"];
    }
    if (!vars.splitsDone.Contains("switch_bomb") && ((vars.switchBomb.Current == 1 && vars.switchBomb.Old == 0) || (vars.SwapEndianness(vars.switchBomb.Current) == 1 && vars.SwapEndianness(vars.switchBomb.Old) == 0)))
    {
        vars.splitsDone.Add("switch_bomb");
        return settings["switch_bomb"];
    }
    if (!vars.splitsDone.Contains("hatter_sweep") && ((vars.hatterSweep.Current == 1 && vars.hatterSweep.Old == 0) || (vars.SwapEndianness(vars.hatterSweep.Current) == 1 && vars.SwapEndianness(vars.hatterSweep.Old) == 0)))
    {
        vars.splitsDone.Add("hatter_sweep");
        return settings["hatter_sweep"];
    }

    // salazen grum
    if (!vars.splitsDone.Contains("ach_rq") && ((vars.achRq.Current == 1 && vars.achRq.Old == 0) || (vars.SwapEndianness(vars.achRq.Current) == 1 && vars.SwapEndianness(vars.achRq.Old) == 0)))
    {
        vars.splitsDone.Add("ach_rq");
        return settings["ach_rq"];
    }
    if (!vars.splitsDone.Contains("ach_rq_potion") && ((vars.achRqPotion.Current == 1 && vars.achRqPotion.Old == 0) || (vars.SwapEndianness(vars.achRqPotion.Current) == 1 && vars.SwapEndianness(vars.achRqPotion.Old) == 0)))
    {
        vars.splitsDone.Add("ach_rq_potion");
        return settings["ach_rq_potion"];
    }
    if (!vars.splitsDone.Contains("mally_finish") && ((vars.mallyFinish.Current == 1 && vars.mallyFinish.Old == 0) || (vars.SwapEndianness(vars.mallyFinish.Current) == 1 && vars.SwapEndianness(vars.mallyFinish.Old) == 0)))
    {
        vars.splitsDone.Add("mally_finish");
        return settings["maly_finish"];
    }
    if (!vars.splitsDone.Contains("backstab") && ((vars.backstab.Current == 1 && vars.backstab.Old == 0) || (vars.SwapEndianness(vars.backstab.Current) == 1 && vars.SwapEndianness(vars.backstab.Old) == 0)))
    {
        vars.splitsDone.Add("backstab");
        return settings["backstab"];
    }

    // bandersnatch stables
    if (!vars.splitsDone.Contains("stayne") && ((vars.stayne.Current == 1 && vars.stayne.Old == 0) || (vars.SwapEndianness(vars.stayne.Current) == 1 && vars.SwapEndianness(vars.stayne.Old) == 0)))
    {
        vars.splitsDone.Add("stayne");
        return settings["stayne"];
    }

    // marmoreal
    if (!vars.splitsDone.Contains("visit_wq") && ((vars.visitWq.Current == 1 && vars.visitWq.Old == 0) || (vars.SwapEndianness(vars.visitWq.Current) == 1 && vars.SwapEndianness(vars.visitWq.Old) == 0)))
    {
        vars.splitsDone.Add("visit_wq");
        return settings["visit_wq"];
    }
    if (!vars.splitsDone.Contains("multiplier") && ((vars.multiplier.Current == 1 && vars.multiplier.Old == 0) || (vars.SwapEndianness(vars.multiplier.Current) == 1 && vars.SwapEndianness(vars.multiplier.Old) == 0)))
    {
        vars.splitsDone.Add("multiplier");
        return settings["multiplier"];
    }

    // frabjous
    if (!vars.splitsDone.Contains("armour") && ((vars.armour.Current == 1 && vars.armour.Old == 0) || (vars.SwapEndianness(vars.armour.Current) == 1 && vars.SwapEndianness(vars.armour.Old) == 0)))
    {
        vars.splitsDone.Add("armour");
        return settings["armour"];
    }

    // no quest triggered
    return false;
}

reset
{
    return (vars.map.Old != 0 && vars.map.Current == 0) || (vars.SwapEndianness(vars.map.Old) != 0 && vars.SwapEndianness(vars.map.Current));
}

onReset
{
    vars.splitsDone.Clear();
    vars.achievementsDone.Clear();
    if (settings["achievements"])
        vars.SetTextComponent("Achievements: ", "0/18");
}

shutdown
{
    if (settings["achievements"])
        vars.SetTextComponent("Achievements: ", "0/18");
}

isLoading
{
    return (vars.map.Current == -1 || vars.SwapEndianness(vars.map.Current) == -1) && settings["load_removal"];
}

gameTime
{
    return TimeSpan.FromSeconds(version == "Steam" ? vars.gameTime.Current : vars.SwapEndianness(vars.gameTime.Current));
}
