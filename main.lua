--[[

    MADE BY JERRYMIAHPM ON DISCORD
    DO NOT COPY THE CODE AND 
    CLAIM YOU MADE IT

]]

getgenv().AutoFarm = false
getgenv().Spammer = false
getgenv().option = nil
getgenv().boatConfiguration = {}
getgenv().boatConfiguration.BoatSpeed = 130
getgenv().boatConfiguration.BoatRot = 1.1
getgenv().state = "State: Nil"
getgenv().anti_afk = false
getgenv().player_esp = false
getgenv().shark_esp = false
getgenv().boatflyspeed = 250
getgenv().boatfly = false
getgenv().espConfigColor = Color3.fromRGB(6, 94, 234)
getgenv().sharkEspConfigColor = Color3.fromRGB(6, 94, 234)
getgenv().SharkOutlineEspColor = Color3.fromRGB(0,0,0)
getgenv().boatstabilizer = false
local HitScanFireModuleScript = require(game:GetService("Players").LocalPlayer.PlayerScripts.ProjectilesClient.WeaponScript.HitScanFire)
local shootRemote = getupvalue(getupvalue(getupvalue(HitScanFireModuleScript.Fire,8),4),2)
local RunService = game:GetService("RunService")
local TeamsService = game:GetService("Teams")
local HTTPService = game:GetService("HttpService")
local GunStats = require(game:GetService("ReplicatedStorage").Projectiles.ProjectileStatsModule)
local boatSelectionRemote = game:GetService("ReplicatedStorage").EventsFolder.BoatSelection.UpdateHostBoat
local LocalPlayer = game:GetService("Players").LocalPlayer
local boatsList = game:GetService("ReplicatedStorage").ClientViewportObjects.Boats
local notification = require(game:GetService("Players").LocalPlayer.PlayerScripts.Notifications.NotificationManager)

-- Loading Functions

for i, v in pairs(GunStats.get()) do
    v.Mode = 1
end

notification.showRight("Shark Ripper v4 is loading")
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Included loadstrings

local GunMods = loadstring(game:HttpGet("https://pastebin.com/raw/kRbHDtSX"))()
local PlayerEsp = loadstring(game:HttpGet("https://pastebin.com/raw/0zFEtSWD"))()
local SharkEsp = loadstring(game:HttpGet("https://pastebin.com/raw/vJBCEqkj"))()
local BoatFly = loadstring(game:HttpGet("https://pastebin.com/raw/Yid0gEwt"))

if getgenv().loaded == nil then
    task.spawn(function() PlayerEsp.Start() end)
    task.spawn(function() SharkEsp.Start() end)
    BoatFly()
end

getgenv().loaded = true

-- Util

local function getTarget(class)
    return game.Workspace.Sharks:FindFirstChildWhichIsA(class)
end

local function getBoats() 
    local boats = {}
    for i, v in pairs(boatsList:GetChildren()) do
        boats[i] = v.Name
    end
    return boats
end

local function getStatus(boolean, returnValueIfTrue, returnFalseIfFalse)
    if boolean then
        return returnValueIfTrue
    end
    return returnFalseIfFalse
end

local function notify(title, content)
    OrionLib:MakeNotification({
        Name = title,
        Content = content,
        Time = 5,
        Image = "rbxassetid://4483345998"
     })
end

-- UI COMPONENTS

local Window = OrionLib:MakeWindow({
    Name = "Shark Ripper v4",
    HidePremium = false,
    IntroEnabled = true,
    IntroText = "Loading Shark Ripper v4",
    Icon = "rbxassetid://14353238657"
 })

-- NEWS TAB

local NewsTab = Window:MakeTab({Name = "News", Icon = "rbxassetid://14353324742"})
NewsTab:AddSection({Name = "News"})
NewsTab:AddLabel("Beta v4 has been released to 5 select users")
NewsTab:AddSection({Name = "Update Log"})
NewsTab:AddLabel("Beta version 4")
NewsTab:AddParagraph("Logs", "In this new update, we have added a few new features including boatfly")
NewsTab:AddParagraph("Losses :(", "Anti-Afk has been removed indefinently.  Webhooks have been removed as well.")

-- AUTOFARM TAB

local AutoFarmTab = Window:MakeTab({Name = "AutoFarm", Icon = "rbxassetid://4483345998"})

AutoFarmTab:AddSection({Name = "AutoFarm"})

AutoFarmTab:AddToggle({Name = "AutoFarm", Default = false, Callback = function(value) getgenv().AutoFarm = value end})

AutoFarmTab:AddSection({Name = "AutoFarm Status"})

local statusLabel = AutoFarmTab:AddLabel("Status: "..getStatus(getgenv().AutoFarm, "Running", "Stopped"))
local stateLabel = AutoFarmTab:AddLabel(getgenv().state)

-- BOATS TAB

local option = getBoats()[1]

local BoatsTab = Window:MakeTab({Name = "Boats", Icon = "rbxassetid://14353386762"})

BoatsTab:AddSection({Name = "Boat Selections"})

BoatsTab:AddDropdown({Name = "Boat Selector", Options = getBoats(), Default = getBoats()[1], Callback = function(Value) option = Value end})
BoatsTab:AddButton({Name = "Select Boat", Callback = function() 
    if option ~= nil then 
        boatSelectionRemote:FireServer(option) 
        notify("Boats", tostring(option).." has been selected for next round", 6) 
    end 
end})

BoatsTab:AddSection({Name = "Boat Hax"})

BoatsTab:AddToggle({Name = "Boat Fly", Default = false, Callback = function(value) 
    if value then
        game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Track
    else
        game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    end
    getgenv().boatfly = value
end})
BoatsTab:AddSlider({Name = "Boat Fly Speed", Min = 10, Max = 2500, Default = 200, Increment = 1, Color = Color3.fromRGB(35, 156, 255),ValueName = "Fly Speed", Callback = function(Value)
    getgenv().boatflyspeed = Value
end})

BoatsTab:AddSection({Name = "Boat Modifications"})

BoatsTab:AddToggle({Name = "Boat Stabilizer", Callback = function(Value)
    getgenv().boatstabilizer = Value
end})
BoatsTab:AddSlider({Name = "Boat Fly Speed", Min = 100, Max = 10000, Default = 100, Increment = 10, Color = Color3.fromRGB(35, 156, 255),ValueName = "Speed", Callback = function(Value)
    getgenv().boatConfiguration["BoatSpeed"] = Value
end})
BoatsTab:AddSlider({Name = "Boat Fly Speed", Min = 0.25, Max = 10, Default = 1.2, Increment = 0.1, Color = Color3.fromRGB(35, 156, 255),ValueName = "Rotational Velocity", Callback = function(Value)
    getgenv().boatConfiguration["BoatRot"] = Value
end})

-- GUNS TAB

local GunsTab = Window:MakeTab({Name = "Guns", Icon = "rbxassetid://14353448712"})

GunsTab:AddSection({Name = "Gun Mods"})

GunsTab:AddSlider({Name = "Gun Fire Rate", Min = 1, Max = 1000, Increment = 1, Suffix = "Fire Rate", Default = 10, Callback = function(value) GunMods.setFireRate(value) end})
GunsTab:AddSlider({Name = "Gun Projectile Speed", Min = 500, Max = 100000, Increment = 100, Suffix = "Projectile Speed", Default = 500, Callback = function(value) GunMods.setProjectileSpeed(value) end})
GunsTab:AddSlider({Name = "Gun Projectile Range", Min = 5000, Max = 100000, Increment = 1000, Suffix = "Projectile Range", Default = 5000, Callback = function(value) GunMods.setProjectileRange(value) end})
GunsTab:AddButton({Name = "Infinite Ammo", Callback = function() GunMods.infAmmo() end})
GunsTab:AddButton({Name = "Automatic", Callback = function() GunMods.setAuto() end})
GunsTab:AddButton({Name = "No Reload", Callback = function() GunMods.NoReload() end})
GunsTab:AddButton({Name = "No Recoil", Callback = function() GunMods.NoRecoil() end})
GunsTab:AddButton({Name = "No Spread", Callback = function() GunMods.NoSpread() end})

-- VISUALS TAB

local VisualsTab = Window:MakeTab({Name = "Visuals", Icon = "rbxassetid://14353487085"})

VisualsTab:AddSection({Name = "ESP"})

VisualsTab:AddToggle({Name = "Player ESP",  Default = false, Callback = function(value) getgenv().player_esp = value end})
VisualsTab:AddColorpicker({Name = "Player ESP Color", Default = Color3.fromRGB(6, 94, 234), Callback = function(Value) getgenv().espConfigColor = Value end})
VisualsTab:AddToggle({Name = "Shark ESP",  Default = false, Callback = function(value) getgenv().shark_esp = value end})
VisualsTab:AddColorpicker({Name = "Shark ESP Color", Default = Color3.fromRGB(6, 94, 234), Callback = function(Value) getgenv().sharkEspConfigColor = Value end})
VisualsTab:AddColorpicker({Name = "Shark ESP Outline Color", Default = Color3.fromRGB(0,0,0), Callback = function(Value) getgenv().SharkOutlineEspColor = Value end})

-- OTHERS TAB

local OthersTab = Window:MakeTab({Name = "Others", Icon = "rbxassetid://4483345998"})

OthersTab:AddSection({Name = "Others"})

OthersTab:AddButton({Name = "Destroy Barriers", Callback = function()
    for i, v in pairs(game.Workspace:GetDescendants()) do
        if v.Name == "Barrier" or v.Name == "ExtraBarrier" or v.Parent.Name == "OuterMapBarriers" then
            v:Destroy()
        end
    end
    notify("Others", "Most barriers have been destroyed ;)")
end})



-- Other Funcs

RunService.Stepped:Connect(function(time, deltaTime)
    if getgenv().AutoFarm then
        local target = getTarget("Model")

        if LocalPlayer.Team ~= TeamsService["Survivor"] and LocalPlayer.Team ~= TeamsService["Shark"] then
            getgenv().status = "State: In Lobby"
        end
    
        if LocalPlayer.Team == TeamsService["Survivor"] and target == nil then
            getgenv().status = "State: In Game"
        end
    
        if LocalPlayer.Team == TeamsService["Survivor"] and target ~= nil then
            getgenv().status = "State: Killing Shark"
        end
    
        if LocalPlayer.Team == TeamsService["Shark"] then
            getgenv().status = "State: Team Shark"
        end

        if target ~= nil and LocalPlayer.Team == TeamsService["Survivor"] then
            if game.Players.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool") ~= nil then
                game.Players.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool").Parent = LocalPlayer.Character
            end
            if LocalPlayer.Character.Humanoid.Sit then
                LocalPlayer.Character.Humanoid.Sit = false
            end
            local LockedPosition = target.SharkMain.Ball
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LockedPosition.CFrame.X, LockedPosition.CFrame.Y + 50, LockedPosition.CFrame.Z)
            for i=0,100 do
                task.spawn(function()
                    shootRemote:FireServer(target)
                    wait()
                end)
                wait()
            end
        end
    end
    wait()
end)

-- Anti AFK

task.spawn(function()
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    end)
end)

task.spawn(function()
    while true do
            local button = game:GetService("Players").LocalPlayer.PlayerGui.AFK.Page.YesButton
            if game:GetService("Players").LocalPlayer.PlayerGui.AFK.Enabled == true then
                for i, v in pairs({"MouseButton1Click", "MouseButton1Down", "Activated"}) do
                    for i2, v in pairs(getconnections(button[v])) do
                        v:Fire()
                    end
                end
            end
        wait()
    end
end)

-- Boat Modifiers

task.spawn(function()
    while true do
        for i, v in pairs(game.Workspace.Boats:GetChildren()) do
            if v:GetAttributes().OwnerName == game.Players.LocalPlayer.Name then
                v:WaitForChild("Configuration"):WaitForChild("Engine"):WaitForChild("MaxSpeed").Value = getgenv().boatConfiguration["BoatSpeed"]
                v:WaitForChild("Configuration"):WaitForChild("Engine"):WaitForChild("MaxRotVel").Value = getgenv().boatConfiguration["BoatRot"]
            end
        end
        wait(1)
    end
end)

-- AutoFarm Status

task.spawn(function()
    while true do
        statusLabel:Set("Status: "..getStatus(getgenv().AutoFarm, "Active", "Inactive"))
        if getgenv().AutoFarm then
            stateLabel:Set(getgenv().status)
        else
            stateLabel:Set("State: Offline")
        end
        wait(0.2)
    end
end)

-- BOAT STABILIZER
task.spawn(function()
    while true do
        if getgenv().boatstabilizer then
            for i, v in pairs(game.Workspace.Boats:GetChildren()) do
                if v:GetAttributes().OwnerName == LocalPlayer.Name then
                    if v.CriticalComponents:FindFirstChild("TP") then
                        if v.CriticalComponents.TP:FindFirstChildWhichIsA("BodyGyro") == nil then
                            local gyro = Instance.new("BodyGyro", v.CriticalComponents.TP)
                            gyro.Name = "IGNORE"
                        end
                    end
                end
            end
        else
            for i, v in pairs(game.Workspace.Boats:GetChildren()) do
                if v:GetAttributes().OwnerName == LocalPlayer.Name then
                    if v.CriticalComponents:FindFirstChild("TP") then
                        for i, v in pairs(v.CriticalComponents.TP:GetChildren()) do
                            if v.Name == "IGNORE" then
                                v:Destroy()
                            end
                        end
                    end
                end
            end
        end
        wait()
    end
end)
