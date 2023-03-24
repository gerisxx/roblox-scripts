getgenv().Settings = {
    ["Host"] = 12345, -- // Controller ID
    ["Prefix"] = "/", -- // Chat Prefix
    ["FPS"] = 3, -- // Alts FPS
    ["Advert"] = ".gg/halloweens", -- // Your Advert
    ["GUI"] = true, -- // GUI Enabled/Disabled
}

getgenv().Alts = { --// Max is 38
    Alt1 = 12345,
    Alt2 = 12345,
    Alt3 = 12345,
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/socialsuicide/roblox-scripts/main/DaHood/SpookyControl/src.lua", true))();
