--[[
  
    Redeems every code Da Hood ever made

    Loadstring version: loadstring(game:HttpGet("https://raw.githubusercontent.com/halloweevn/roblox-scripts/main/DHCodeRedeemer.lua", true))();

]]--

-- // Await until game is fully loaded
repeat wait() until game:IsLoaded()
repeat wait() until game:GetService("Workspace").Players:FindFirstChild(game:GetService("Players").LocalPlayer.Name)

-- // Check game
if game.PlaceId ~= 2788229376 then
    game:GetService("Players").LocalPlayer:Kick("ERROR: Script only works inside of Da Hood.")
    task.wait(3)
    game:Shutdown()
end

-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Variables
local Codes = loadstring(game:HttpGet("https://raw.githubusercontent.com/halloweevn/Spooky/main/codes.lua"))()

-- // Redeem every code in the game
for _, v in pairs(Codes) do
    ReplicatedStorage.MainEvent:FireServer("EnterPromoCode", Codes)
end
