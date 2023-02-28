--[[

    Setting up config tutorial: https://www.youtube.com/watch?v=9zvx04TQRZY&ab_channel=halloween

    Commands:
    /start -- Begins the bounty farm
    /stop -- Stops the bounty farm
    /cpu -- Loads up CPU Savers for the host account
    /bounty {user} -- Host says the bounty of the user in chat
    /fps {amount} -- Sets the hosts FPS Cap to the inputted amount

]]--

getgenv().Settings = {
    ["HostSettings"] = {
        ["Host"] = 12345, -- // Host ID (Account that inputs commands and collects stomps/bounty)
        ["KickAfter"] = 6, -- // Input nil for no kick | Amount of hours you want the host to be kicked after (Prevents not saving due to crashing/data-overflow)
    },
    ["AttackerSettings"] = {
        ["Attacker"] = 12345, -- // Attacker ID (Account that kills all the ALTs)
        ["Location"] = "Admin", -- // Location that the attacker will kill the ALTs (Admin, Bank, School, Uphill, Downhill)
    },
    ["CrewID"] = 1, -- // Group ID (Attacker + Host must be inside of the group)
    ["ALTSettings"] = {
        ["FPS"] = 3, -- // ALTs FPS
        ["ALTs"] = { -- // WARNING: These ALTs will lose there bounty
            12345,
            12345,
            12345,
        },
    },
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/socialsuicide/roblox-scripts/main/DaHood/dh-bountyfarm/src.lua", true))();
