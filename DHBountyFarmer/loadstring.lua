--[[

    Commands: /start, /stop
    
]]--

getgenv().Settings = {
    ["Host"] = 12345, -- // Host ID (Account that inputs commands and collects stomps)
    ["Attacker"] = 12345, -- // Attacker ID (Account that kills all the ALTs)
    ["FPS"] = 3, -- // ALTs FPS
    ["Crew_ID"] = 1, -- // Attacker + Host must be inside of the group
    ["ALTs"] = { -- // WARNING: These ALTs will lose there bounty
        12345,
        12345,
        12345,
    },
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/halloweevn/roblox-scripts/main/DHBountyFarmer/src.lua", true))();
