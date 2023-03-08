--[[

  Spooky Control V2.5 Source Code, have fun skids.
  (This is not updated and was made over 4 months ago, be careful.)

]]--

--[[

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

]]--

-- // Checking if the script has already been loaded
if getgenv().Spooky_Loaded then
    return
end

-- // Setting Spooky_Loaded boolen to true
getgenv().Spooky_Loaded = true

-- // Checking if place is Da Hood
if game.PlaceId ~= 2788229376 then
    game:GetService("Players").LocalPlayer:Kick("ERROR: Script only works inside of Da Hood.")
    return -- // Incase of anti kick
end

-- // Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

-- // Variables
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local HumanoidRootPart = Character.HumanoidRootPart
local UserID = LocalPlayer.UserId
local SayMessageRequest = ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest
local Host, Prefix = getgenv().Settings.Host, getgenv().Settings.Prefix
local HostName = Players:GetNameFromUserIdAsync(tonumber(Host))
local FlaggedRemotes = { "TeleportDetect", "CHECKER_1", "CHECKER_2", "OneMoreTime", "VirusCough", "BreathingHAMON", "TimerMoney" }

-- // Libarys (not rlly just couldnt be fucked thinking of a name)
local Locations = loadstring(game:HttpGet("https://raw.githubusercontent.com/socialsuicide/roblox-scripts/main/DaHood/spooky-source/resources/setup.lua"))()
local Codes = loadstring(game:HttpGet("https://raw.githubusercontent.com/socialsuicide/roblox-scripts/main/DaHood/spooky-source/resources/codes.lua"))()

-- // Awaiting until game is fully loaded
repeat task.wait() until game:IsLoaded()
repeat task.wait() until Workspace.Players:FindFirstChild(LocalPlayer.Name)

-- // ANTI AFK
for _, v in pairs(getconnections(LocalPlayer.Idled)) do
    v:Disable()
end

-- // Alerting user the script has loaded
StarterGui:SetCore("SendNotification", { Title = "!", Text = "Spooky Control has Loaded", Duration = 5 })

-- // ANTI Cheat bypass
local oldnamecall;
oldnamecall = hookmetamethod(game, "__namecall", function(...)
    local args = {...}
    local namecallmethod = getnamecallmethod()
    if (namecallmethod == "FireServer" and args[1] == "MainEvent" and table.find(FlaggedRemotes, args[2])) then
        return
    end
    return oldnamecall(table.unpack(args))
end)

-- // Chat commands
ReplicatedStorage.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(Chatted)
    local args = string.split(string.lower(Chatted.Message), " ")
    if game.Players[Chatted.FromSpeaker].UserId == Host then

        if args[1] == Prefix .. "drop" then

            if UserID ~= Host then
                getgenv().MoneyDrop = true
                while MoneyDrop do
                    local DropAmount = 10000
                    if LocalPlayer.DataFolder.Currency.Value < 10000 then
                        DropAmount = LocalPlayer.DataFolder.Currency.Value
                    end
                    ReplicatedStorage.MainEvent:FireServer("DropMoney", DropAmount)
                    task.wait()
                    ReplicatedStorage.MainEvent:FireServer("Block", true)
                end
            end
        
        elseif args[1] == Prefix .. "stop" then

            if UserID ~= Host then
                getgenv().MoneyDrop = false
                getgenv().CDrop = false
                task.wait()
                ReplicatedStorage.MainEvent:FireServer("Block", false)
            end
        
        elseif args[1] == Prefix .. "setup" and args[2] ~= nil then

            if UserID ~= Host then
                local SetupLocation = args[2]
                for _, v in pairs(getgenv().ALTs) do
                    if v == UserID then
                        local PositionTable = Locations[SetupLocation][_]
                        local Position = string.split(PositionTable, ",")
                        local X, Y, Z = Position[1], Position[2], Position[3]
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(X, Y, Z)
                    end
                end
            else
                if args[2] == "admin" then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-871.785278, -32.6492119, -652.849182, -0.999992073, 4.68113122e-08, -0.00398096582, 4.69743107e-08, 1, -4.08507184e-08, 0.00398096582, -4.10373957e-08, -0.999992073)
                elseif args[2] == "bank" then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-375.632324, 21.2480183, -351.037842, -0.999990225, -3.82589498e-08, -0.00442149304, -3.79021188e-08, 1, -8.07878067e-08, 0.00442149304, -8.06194365e-08, -0.999990225)
                elseif args[2] == "school" then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-602.800537, 21.4980183, 160.242432, -0.999967217, -3.07487147e-10, -0.0080942288, -3.88604177e-10, 1, 1.0020015e-08, 0.0080942288, 1.00228323e-08, -0.999967217)
                elseif args[2] == "train" then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(641.997253, 48, -114.914413, -0.99968493, 7.91000332e-08, -0.0251009576, 7.79249802e-08, 1, 4.7791449e-08, 0.0251009576, 4.58203999e-08, -0.99968493)
                elseif args[2] == "basket" then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-933.516296, 22.0378437, -526.379272, -0.999972999, -4.88194019e-08, 0.00734632602, -4.81996913e-08, 1, 8.45338661e-08, -0.00734632602, 8.41774934e-08, -0.999972999)
                end
            end
        
        elseif args[1] == Prefix .. "cdrop" and args[2] ~= nil then

            if UserID ~= Host then
                local function Amounts(Cash)
                    local CashAmount = string.lower(Cash)
                    if CashAmount:find("k") then
                        return string.gsub(CashAmount, "k", "") * 1000
                    elseif CashAmount:find("m") then
                        return string.gsub(CashAmount, "m", "") * 1000000
                    elseif CashAmount:find("b") then
                        return string.gsub(CashAmount, "b", "") * 1000000000
                    end
                end
                local Amount = Amounts(args[2])
                local OldMoney = 0
                for _, v in pairs(Workspace.Ignored.Drop:GetChildren()) do
                    if v.Name == "MoneyDrop" then
                        OldMoney = OldMoney + string.gsub(v.BillboardGui.TextLabel.Text, "%D", "")
                    end
                end
                getgenv().CDrop = true
                SayMessageRequest:FireServer("cdrop started", "All")
                repeat
                    local CashDropped = 0
                    ReplicatedStorage.MainEvent:FireServer("DropMoney", 10000)
                    task.wait()
                    ReplicatedStorage.MainEvent:FireServer("Block", true)
                    for _, v in pairs(Workspace.Ignored.Drop:GetChildren()) do
                        if v.Name == "MoneyDrop" then
                            local CashAmount = string.gsub(v.BillboardGui.TextLabel.Text, "%D", "")
                            CashDropped = CashDropped + CashAmount
                        end
                    end
                until CashDropped >= Amount + OldMoney or getgenv().CDrop == false
                SayMessageRequest:FireServer("cdrop complete", "All")
                task.wait()
                game.ReplicatedStorage.MainEvent:FireServer("Block", false)
            end
        
        elseif args[1] == Prefix .. "bring" then
                
            if UserID ~= Host then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Players[HostName].Character.HumanoidRootPart.CFrame.Position) * CFrame.new(-4, 0, 4)
            end
        
        elseif args[1] == Prefix .. "wallet" then
                
            if UserID ~= Host then
                if LocalPlayer.Backpack:FindFirstChild("Wallet") then
                    LocalPlayer.Backpack:FindFirstChild("Wallet").Parent = LocalPlayer.Character
                elseif LocalPlayer.Character:FindFirstChild("Wallet") then
                    LocalPlayer.Character:FindFirstChild("Wallet").Parent = LocalPlayer.Backpack
                end
            end
        
        elseif args[1] == Prefix .. "freeze" then

            if UserID ~= Host then
                if not HumanoidRootPart.Anchored then
                    HumanoidRootPart.Anchored = true
                elseif HumanoidRootPart.Anchored then
                    HumanoidRootPart.Anchored = false
                end
            end
        
        elseif args[1] == Prefix .. "reset" then

            if UserID ~= Host then
                for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v:Destroy()
                    end
                end
            end
        
        elseif args[1] == Prefix .. "kick" then

            if UserID ~= Host then
                LocalPlayer:Kick("Kicked by host")
            end
        
        elseif args[1] == Prefix .. "airlock" then

            if UserID ~= Host then
                if not Airlock then
                    getgenv().Airlock = true
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.CFrame.Position) * CFrame.new(0, 14, 0)
                    task.wait(0.2)
                    LocalPlayer.Character.HumanoidRootPart.Anchored = true
                elseif Airlock then
                    getgenv().Airlock = false
                    LocalPlayer.Character.HumanoidRootPart.Anchored = false
                end
            end
        
        elseif args[1] == Prefix .. "god" then

            if UserID ~= Host then
                Character:FindFirstChild("BodyEffects"):FindFirstChild('Attacking'):Destroy()
            end
        
        elseif args[1] == Prefix .. "advert" then

            if UserID ~= Host then
                if not Advert then
                    getgenv().Advert = true
                    while Advert do
                        SayMessageRequest:FireServer(getgenv().Settings.Advert, 'All')
                        task.wait(10)
                    end
                elseif Advert then
                    getgenv().Advert = false
                end
            end
        
        elseif args[1] == Prefix .. "fps" and args[2] ~= nil then

            if UserID ~= Host then
                pcall(setfpscap, tonumber(args[2]))
                pcall(set_fps_cap, tonumber(args[2]))
            end
        
        elseif args[1] == Prefix .. "redeem" then

            if UserID ~= Host then
                for _, v in pairs(Codes) do
                    game:GetService("ReplicatedStorage").MainEvent:FireServer("EnterPromoCode", v)
                end
            end
        
        end
    end
end)

-- // GUI
if getgenv().Settings.GUI then

    if UserID == Controller then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/socialsuicide/roblox-scripts/main/DaHood/spooky-source/resources/gui.lua", true))();
    end

end

-- // Low GFX
if UserID == Controller then

    local decalsyeeted = true
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    l.GlobalShadows = false
    l.FogEnd = 9e9
    l.Brightness = 0
    settings().Rendering.QualityLevel = "Level01"
    for i, v in pairs(g:GetDescendants()) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
            v.Enabled = false
        elseif v:IsA("MeshPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
            v.TextureID = 10385902758728957
        end
    end
    for i, e in pairs(l:GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
            e.Enabled = false
        end
    end

end

-- // Cash Counter
if UserID == Controller then

    local ScreenGui = Instance.new("ScreenGui")
    local CCHolderFrame = Instance.new("Frame")
    local CCText = Instance.new("TextLabel")
    local UICorner = Instance.new("UICorner")
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    CCHolderFrame.Name = "CCHolderFrame"
    CCHolderFrame.Parent = ScreenGui
    CCHolderFrame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    CCHolderFrame.Position = UDim2.new(0.0166840293, 0, 0.0357142836, 0)
    CCHolderFrame.Size = UDim2.new(0, 250, 0, 80)
    CCText.Name = "CCText"
    CCText.Parent = CCHolderFrame
    CCText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CCText.BackgroundTransparency = 1.000
    CCText.Size = UDim2.new(0, 250, 0, 80)
    CCText.Font = Enum.Font.GothamBlack
    CCText.Text = "$0"
    CCText.TextColor3 = Color3.fromRGB(111, 111, 111)
    CCText.TextSize = 20.000
    UICorner.Parent = CCHolderFrame
    local function NYKOTQ_fake_script()
    local script = Instance.new('LocalScript', CCText)
    local function CommaNumbers(Amount)
        local Formatted = Amount
        while wait() do
            Formatted, K = string.gsub(Formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
            if (K == 0) then
                break
            end
        end
        return Formatted
    end
    while wait() do
        local Cash = 0
        for i,v in pairs(game.Workspace.Ignored.Drop:GetChildren()) do
            if v.Name == "MoneyDrop" then
                local CashAmounts = string.gsub(v.BillboardGui.TextLabel.Text, "%D", "")
                Cash = Cash + CashAmounts
            end
        end
        script.Parent.Text = "$"..CommaNumbers(Cash)
    end
    end
    coroutine.wrap(NYKOTQ_fake_script)()
    local function UJMPMCF_fake_script()
    local script = Instance.new('LocalScript', CCHolderFrame)
    script.Parent.Active = true
    script.Parent.Draggable = true
    local Mouse = game.Players.LocalPlayer:GetMouse()
    local Toggle = true
    Mouse.KeyDown:Connect(function(Key)
        if Key == "c" and Toggle == false then
            Toggle = true
            script.Parent.Visible = false
        elseif Key == "c" and Toggle == true then
            Toggle = false
            script.Parent.Visible = true
        end
    end)
    end
    coroutine.wrap(UJMPMCF_fake_script)()

end

-- // Destroy Players
if UserID ~= Controller then

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer then
            if v.Name ~= ControllerName then
                for _, v in pairs(v.Character:GetChildren()) do
                    v:Destroy()
                end
            end
        end
    end
    game:GetService("Workspace").Players.ChildAdded:Connect(function(CharacterAdded)
        if CharacterAdded then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= Players.LocalPlayer then
                    if v.Name ~= ControllerName then
                        for _, v in pairs(v.Character:GetChildren()) do
                            v:Destroy()
                        end
                    end
                end
            end
        end
    end)

end

--// CPU Saver
if UserID ~= Controller then
    local CPUSaver = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local TextLabel = Instance.new("TextLabel")
    local TextLabel_2 = Instance.new("TextLabel")
    CPUSaver.Name = "CPUSaver"
    CPUSaver.Parent = game.CoreGui
    CPUSaver.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Frame.Parent = CPUSaver
    Frame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
    Frame.Position = UDim2.new(-0.358185619, 0, -0.832251132, 0)
    Frame.Size = UDim2.new(0, 3291, 0, 2462)
    TextLabel.Parent = Frame
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.Position = UDim2.new(0.438468546, 0, 0.479691327, 0)
    TextLabel.Size = UDim2.new(0, 404, 0, 50)
    TextLabel.Font = Enum.Font.GothamBlack
    TextLabel.Text = "Spooky Control"
    TextLabel.TextColor3 = Color3.fromRGB(77, 77, 77)
    TextLabel.TextSize = 42.000
    TextLabel.TextWrapped = true
    TextLabel_2.Parent = Frame
    TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_2.BackgroundTransparency = 1.000
    TextLabel_2.Position = UDim2.new(0.438468546, 0, 0.5, 0)
    TextLabel_2.Size = UDim2.new(0, 404, 0, 50)
    TextLabel_2.Font = Enum.Font.GothamBlack
    TextLabel_2.Text = "Welcome, halloweevn"
    TextLabel_2.TextColor3 = Color3.fromRGB(71, 71, 71)
    TextLabel_2.TextSize = 25.000
    TextLabel_2.TextWrapped = true
    local function HJUYPTD_fake_script()
        local script = Instance.new('LocalScript', TextLabel_2)
        script.Parent.Text = "Welcome, "..game.Players.LocalPlayer.Name
    end
    coroutine.wrap(HJUYPTD_fake_script)()
    UserSettings().GameSettings.MasterVolume = 0
    RunService:Set3dRenderingEnabled(false)
    settings().Rendering.QualityLevel = 1
    task.wait()
    pcall(setfpscap, tonumber(getgenv().Settings.FPS))
    pcall(set_fps_cap, tonumber(getgenv().Settings.FPS))
    task.wait()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end
    end
end

-- // Destroy Cash
if UserID ~= Controller then

    for _, v in pairs(Workspace.Ignored.Drop:GetChildren()) do
        v.Transparency = 1
        for _, v in pairs(v:GetChildren()) do
            if v:IsA("Decal") then
                v.Transparency = 1
            elseif v:IsA("BillboardGui") then
                v.Enabled = false
            end
        end
    end
    Workspace.Ignored.Drop.ChildAdded:Connect(function(Cash)
        if Cash then
            for _, v in pairs(Workspace.Ignored.Drop:GetChildren()) do
                v.Transparency = 1
                for _, v in pairs(v:GetChildren()) do
                    if v:IsA("Decal") then
                        v.Transparency = 1
                    elseif v:IsA("BillboardGui") then
                        v.Enabled = false
                    end
                end
            end
        end
    end)

end
