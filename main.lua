local part = nil
local uis = game:GetService("UserInputService")
local gyro = Instance.new("BodyGyro", part)
gyro.Name = "_____"
local plyr = game.Players.LocalPlayer.Character
local velo = Instance.new("BodyVelocity", part)
velo.Name = "_____"

task.spawn(function()
    while true do
        if getgenv().boatfly then
            for i, v in pairs(game.Workspace.Boats:GetChildren()) do
                if v:WaitForChild("Seats"):FindFirstChild("VehicleSeat") ~= nil then
                    if v.Seats.VehicleSeat:FindFirstChild("SeatWeld") ~= nil then
                        if v.Name ~= "" then
                            if v:FindFirstChild("Seats"):FindFirstChild("VehicleSeat").SeatWeld.Part1.Parent == plyr then
                                weld = v
                                part = v.CriticalComponents.TP
                                if part:FindFirstChildWhichIsA("BodyGyro") == nil then
                                    gyro = Instance.new("BodyGyro", part)
                                    gyro.Name = "_____"
                                end
                                if part:FindFirstChildWhichIsA("BodyVelocity") == nil then
                                    velo = Instance.new("BodyVelocity", part)
                                    velo.Name = "_____"
                                end
                                break
                            else
                                weld = nil
                                part = nil
                            end
                        end
                    end
                end
            end
        else
            for i, v in pairs(game.Workspace.Boats:GetChildren()) do
                if v.CriticalComponents:FindFirstChild("TP") ~= nil then
                    for i2, v2 in pairs(v.CriticalComponents.TP:GetChildren()) do
                        if v2.Name == "_____" then
                            v2:Destroy()
                        end
                    end
                end
            end
        end
        wait() 
    end
end)

task.spawn(function()
    while true do
        if getgenv().boatfly then
            game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Track
            if weld ~= nil then
                gyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                gyro.P = 9e4
                velo.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                gyro.CFrame = game.Workspace.CurrentCamera.CoordinateFrame
            end
        else
            game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        end
        wait()
    end
end)

uis.InputBegan:Connect(function(input)
    if getgenv().boatfly then
        while uis:IsKeyDown(Enum.KeyCode.W) do
            if weld ~= nil and getgenv().boatfly then
                velo.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * getgenv().boatflyspeed
            end
            wait()
        end
        velo.Velocity = Vector3.zero
    end
end)

uis.InputBegan:Connect(function(input)
    if getgenv().boatfly then
        while uis:IsKeyDown(Enum.KeyCode.S) do
            if weld ~= nil and getgenv().boatfly then
                velo.Velocity = -(game.Workspace.CurrentCamera.CFrame.LookVector * getgenv().boatflyspeed)
            end
            wait()
        end
        velo.Velocity = Vector3.zero
    end
end)

uis.InputBegan:Connect(function(input)
    if getgenv().boatfly then
        while uis:IsKeyDown(Enum.KeyCode.D) do
            if weld ~= nil and getgenv().boatfly then
                velo.Velocity = game.Workspace.CurrentCamera.CFrame.RightVector * getgenv().boatflyspeed
            end
            wait()
        end
	    velo.Velocity = Vector3.zero
    end
end)

uis.InputBegan:Connect(function(input)
    if getgenv().boatfly then
        while uis:IsKeyDown(Enum.KeyCode.A) do
            if weld ~= nil and getgenv().boatfly then
                velo.Velocity = -(game.Workspace.CurrentCamera.CFrame.RightVector * getgenv().boatflyspeed)
            end
            wait()
        end
        velo.Velocity = Vector3.zero
    end
end)
