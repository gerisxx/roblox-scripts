--[[

    Commands: /start, /stop
    Loadstring Version: https://github.com/halloweevn/roblox-scripts/blob/main/DHBountyFarmer/loadstring.lua
    
]]--

-- // IF YOU ARE USING THE SOURCE VERSION THEN REMOVE THE --[[ & ]]--

--[[

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

]]--

-- // Check if already loaded
if getgenv().BountyFarm_Loaded then
    return
else
    getgenv().BountyFarm_Loaded = true
end

-- // Check game
if game.PlaceId ~= 2788229376 then
    game:GetService("Players").LocalPlayer:Kick("ERROR: Script only works inside of Da Hood.")
    task.wait(3)
    game:Shutdown()
end

-- // Await until game is fully loaded
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game:GetService("Workspace").Players:FindFirstChild(game:GetService("Players").LocalPlayer.Name)

-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GroupService = game:GetService("GroupService")
local StarterGui = game:GetService("StarterGui")

-- // Variables
local LocalPlayer = Players.LocalPlayer
local UserID = LocalPlayer.UserId
local Name = LocalPlayer.Name
local AttackerName, HostName = Players:GetNameFromUserIdAsync(tonumber(getgenv().Settings.Attacker)), Players:GetNameFromUserIdAsync(tonumber(getgenv().Settings.Host))

-- // ANTI AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
end)

-- // Checking if the account is inside of the Settings dictionary
if UserID == getgenv().Settings.Host or UserID == getgenv().Settings.Attacker or table.find(getgenv().Settings.ALTs, UserID) then

    -- // Joining Crew
    if UserID == getgenv().Settings.Host or UserID == getgenv().Settings.Attacker then

        local Groups = {}

        for _, v in pairs(GroupService:GetGroupsAsync(UserID)) do
            table.insert(Groups, v.Id)
        end

        if table.find(Groups, tonumber(getgenv().Settings.Crew_ID)) then
            
            game:GetService("ReplicatedStorage").MainEvent:FireServer("JoinCrew", getgenv().Settings.Crew_ID)

        else
            
            StarterGui:SetCore("SendNotification", {Title = "ERROR", Text = "Please join the group you inputed inside of Crew_ID on your attacker + main account. ID: " .. getgenv().Settings.Crew_ID, Duration = tonumber(math.huge)})
            getgenv().BountyFarm_Loaded = false
            return
            
        end
    end

    -- // ANTI Cheat bypass
    local flagged_remotes = {
        "TeleportDetect",
        "CHECKER_1",
        "CHECKER_2",
        "OneMoreTime",
        "VirusCough",
        "BreathingHAMON",
        "TimerMoney",
    }
    
    local oldnamecall;
    oldnamecall = hookmetamethod(game, "__namecall", function(...)
        local args = {...}
        local namecallmethod = getnamecallmethod()
        if (namecallmethod == "FireServer" and args[1] == "MainEvent" and table.find(flagged_remotes, args[2])) then
            return
        end
        return oldnamecall(table.unpack(args))
    end)

    -- // Creating chat commands
    ReplicatedStorage.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(Command)

        local MessageData = string.lower(Command.Message)
        local args = string.split(MessageData, " ")
        if Players[Command.FromSpeaker].UserId == getgenv().Settings.Host then
            
            -- // Start command
            if args[1] == "/start" then

                -- // Setting toggle to true
                getgenv().DH_Bounty_Farm = true
                
                if UserID == getgenv().Settings.Attacker then

                    -- // Destroying LocalPlayers scripts (Fixes not being able to deal no damage when TPing)
                    if LocalPlayer.Character:FindFirstChildWhichIsA('Script').Name ~= "Health" then
                        LocalPlayer.Character:FindFirstChildWhichIsA('Script'):Destroy()
                    end

                    -- // Stopping people from unequipping fists
                    task.spawn(function()
                        while DH_Bounty_Farm do
                            task.wait()
                            if not LocalPlayer.Character:FindFirstChild("Combat") then
                                LocalPlayer.Backpack:FindFirstChild("Combat").Parent = LocalPlayer.Character
                            end
                        end
                    end)
                    
                    -- // Killing operation
                    task.spawn(function()
                        while DH_Bounty_Farm do
                            task.wait()
                            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-382.443329, 12.7501945, -689.088623, -0.998909593, 0, 0.0466874763, 0, 1, 0, -0.0466874763, 0, -0.998909593)
                            LocalPlayer.Character:FindFirstChild("Combat"):Activate()
                        end
                    end)

                end
                
                if UserID == getgenv().Settings.Host then
                    
                    -- // Stomping/Bounty-Farming operation
                    task.spawn(function()
                        while DH_Bounty_Farm do
                            task.wait()
                            for _, v in pairs(Workspace.Players:GetChildren()) do
                                local Old_Position = nil
                                if v.BodyEffects["K.O"].Value == true and v.BodyEffects["Grabbed"].Value == nil and v.BodyEffects["Dead"].Value == false then
                                    Old_Position = LocalPlayer.Character.HumanoidRootPart.CFrame.Position
                                    repeat
                                        task.wait()
                                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Players[v.Name].Character.UpperTorso.Position + Vector3.new(0, 3, 0))
                                        ReplicatedStorage.MainEvent:FireServer("Stomp")
                                    until v.BodyEffects["Dead"].Value == true
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Old_Position)
                                end
                            end
                        end
                    end)

                end

                if table.find(getgenv().Settings.ALTs, UserID) then
                    
                    -- // TPing to attacker until dead
                    repeat
                        task.wait()
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Players[AttackerName].Character.HumanoidRootPart.CFrame.Position) * CFrame.new(0, 0, 3)
                    until Workspace.Players[Name].BodyEffects["Dead"].Value == true
                    
                    -- // Restarting loop on death
                    game.Players.LocalPlayer.CharacterAdded:Connect(function()
                        repeat wait() until game.Workspace.Players:FindFirstChild(Name)
                        repeat
                            task.wait()
                            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Players[AttackerName].Character.HumanoidRootPart.CFrame.Position) * CFrame.new(0, 0, 3)
                        until Workspace.Players:FindFirstChild(Name).BodyEffects["Dead"].Value == true
                    end)

                end
            
            -- // Stop Command
            elseif args[1] == "/stop" then
                getgenv().DH_Bounty_Farm = false

                --// Reseting attacker to get the LocalPlayer scripts back
                task.wait(2) -- // Just to stop things from breaking badly
                if UserID == getgenv().Settings.Attacker then
                    LocalPlayer.Humanoid.Health = 0
                end

            end
        end
    end)
end

-- // CPU Saving
if UserID == getgenv().Settings.Attacker or table.find(getgenv().Settings.ALTs, UserID) then

    -- // Black Screen
    local _4918cab1d537edb8775f295fcb3496ea = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local TextLabel = Instance.new("TextLabel")
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    local TextLabel_2 = Instance.new("TextLabel")
    local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
    local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
    local TextLabel_3 = Instance.new("TextLabel")
    local UITextSizeConstraint_3 = Instance.new("UITextSizeConstraint")
    local UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint")
    _4918cab1d537edb8775f295fcb3496ea.Name = "4918cab1d537edb8775f295fcb3496ea"
    _4918cab1d537edb8775f295fcb3496ea.Parent = game:GetService("CoreGui")
    _4918cab1d537edb8775f295fcb3496ea.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Frame.Parent = _4918cab1d537edb8775f295fcb3496ea
    Frame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    Frame.Position = UDim2.new(-0.398196638, 0, -0.301901758, 0)
    Frame.Size = UDim2.new(0, 6274, 0, 2023)
    TextLabel.Parent = _4918cab1d537edb8775f295fcb3496ea
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.Position = UDim2.new(0.466182709, 0, 0.416190147, 0)
    TextLabel.Size = UDim2.new(0.0681818202, 0, 0.0649001524, 0)
    TextLabel.Font = Enum.Font.GothamBlack
    TextLabel.Text = "Bounty Farmer"
    TextLabel.TextColor3 = Color3.fromRGB(125, 125, 125)
    TextLabel.TextSize = 49.000
    UITextSizeConstraint.Parent = TextLabel
    UITextSizeConstraint.MaxTextSize = 49
    UIAspectRatioConstraint.Parent = TextLabel
    UIAspectRatioConstraint.AspectRatio = 2.862
    TextLabel_2.Parent = _4918cab1d537edb8775f295fcb3496ea
    TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_2.BackgroundTransparency = 1.000
    TextLabel_2.Position = UDim2.new(0.462198675, 0, 0.525099754, 0)
    TextLabel_2.Size = UDim2.new(0.0755681843, 0, 0.0583717376, 0)
    TextLabel_2.Font = Enum.Font.GothamBlack
    TextLabel_2.Text = "CPU & Memory Saver (NO YOU CAN'T REMOVE THIS)"
    TextLabel_2.TextColor3 = Color3.fromRGB(125, 125, 125)
    TextLabel_2.TextSize = 49.000
    UITextSizeConstraint_2.Parent = TextLabel_2
    UITextSizeConstraint_2.MaxTextSize = 49
    UIAspectRatioConstraint_2.Parent = TextLabel_2
    UIAspectRatioConstraint_2.AspectRatio = 1.981
    TextLabel_3.Parent = _4918cab1d537edb8775f295fcb3496ea
    TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_3.BackgroundTransparency = 1.000
    TextLabel_3.Position = UDim2.new(0.468624562, 0, 0.480885178, 0)
    TextLabel_3.Size = UDim2.new(0.0630681813, 0, 0.0443788879, 0)
    TextLabel_3.Font = Enum.Font.GothamBlack
    TextLabel_3.Text = "By Halloween#0002"
    TextLabel_3.TextColor3 = Color3.fromRGB(125, 125, 125)
    TextLabel_3.TextSize = 27.000
    UITextSizeConstraint_3.Parent = TextLabel_3
    UITextSizeConstraint_3.MaxTextSize = 27
    UIAspectRatioConstraint_3.Parent = TextLabel_3
    UIAspectRatioConstraint_3.AspectRatio = 2.869

    -- // CPU Saving
    game:GetService("RunService"):Set3dRenderingEnabled(false)
    settings().Rendering.QualityLevel = 1
    UserSettings().GameSettings.MasterVolume = 0
    
    -- // Removing Map
    for i,v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end
    end

    -- // Setting FPS Cap (Only on attacker because low fps = hard time hitting)
    if UserID == getgenv().Settings.Attacker then

        task.wait(2) -- // Once again fixxing errors with wait times
        setfpscap(60)

    end

end

-- // Destroying other accounts
if table.find(getgenv().Settings.ALTs, UserID) then

    -- // Setting FPS Cap
    setfpscap(tonumber(getgenv().Settings.FPS))

    for _, v in pairs(Workspace.Players:GetChildren()) do
        if v ~= LocalPlayer and v.Name ~= AttackerName and v.Name ~= HostName then
            for _, v in pairs(v.Character:GetChildren()) do
                v:Destroy()
            end
        end
    end

    Workspace.Players.ChildAdded:Connect(function(Character)
        if Character ~= LocalPlayer and Character.Name ~= AttackerName and Character.Name ~= HostName then
            Character:Destroy()
        end
    end)

end
