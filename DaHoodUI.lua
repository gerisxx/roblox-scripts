--[[

    TBH i just wanted to remake the Da Hood UI and add some other features i would like when i play. (UI Scaling may be a little off due to the fact it was made on 3440x1440)
    Open-Source XD :3

]]--

-- // Keybind Settings
getgenv().EmoteKeybinds = {
    ["Lay"] = Enum.KeyCode.X,
    ["Greet"] = Enum.KeyCode.C,
}

-- // Await until game is fully loaded
repeat wait() until game:IsLoaded()
repeat wait() until game:GetService("Workspace").Players:FindFirstChild(game:GetService("Players").LocalPlayer.Name)

-- // Services
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")

-- // Variables
local LocalPlayer = Players.LocalPlayer

-- // Libarys
local NotificationLibary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua", true))();
local Notification = NotificationLibary.Notify

-- // ANTI AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
end)

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

-- // Sky Box
Lighting.Sky:Destroy()
local Sky = Instance.new("Sky")
Sky.Name = "Sky"
Sky.Parent = Lighting
Sky.SkyboxBk = "http://www.roblox.com/asset/?id=393845394"
Sky.SkyboxDn = "http://www.roblox.com/asset/?id=393845204"
Sky.SkyboxFt = "http://www.roblox.com/asset/?id=393845629"
Sky.SkyboxLf = "http://www.roblox.com/asset/?id=393845750"
Sky.SkyboxRt = "http://www.roblox.com/asset/?id=393845533"
Sky.SkyboxUp = "http://www.roblox.com/asset/?id=393845287"

-- // Destroying the annoying ADs
Workspace.ForwardPortal:Destroy()

-- // Destroying PepperSpray Affect
Lighting.PepperSprayBlur:Destroy()

-- // Disabling Seats
for _, v in pairs(Workspace:GetDescendants()) do
    if v:IsA("Seat") then
        v.Disabled = true
    end
end

-- // Destroying Pickups
for _, v in pairs(Workspace.Ignored.ItemsDrop:GetChildren()) do
    v:Destroy()
end

-- // Finishing later babes
