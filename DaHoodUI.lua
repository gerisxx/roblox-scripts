--[[

    TBH i just wanted to remake the Da Hood UI and add some other features i would like when i play.
    Open-Source XD :3

]]--

-- // Flagged ANTI Cheat Remotes
local flagged_remotes = {
    "TeleportDetect",
    "CHECKER_1",
    "CHECKER_2",
    "OneMoreTime",
    "VirusCough",
    "BreathingHAMON",
}

-- // ANTI Cheat Bypass
local oldnamecall;
oldnamecall = hookmetamethod(game, "__namecall", function(...)
    local args = {...}
    local namecallmethod = getnamecallmethod()
    if (namecallmethod == "FireServer" and args[1] == "MainEvent" and table.find(flagged_remotes, args[2])) then
        return
    end
    return oldnamecall(table.unpack(args))
end)

-- // Finishing later babes
