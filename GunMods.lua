--[[

    MADE BY JERRYMIAHPM ON DISCORD
    DO NOT COPY THE CODE AND 
    CLAIM YOU MADE IT

]]

local gunfuncs = {}
local GunStats = require(game:GetService("ReplicatedStorage").Projectiles.ProjectileStatsModule)

for i, v in pairs(GunStats.get()) do
    v.Mode = 1
end

gunfuncs.setFireRate = function(Rate)
    for i, v in pairs(GunStats.get()) do
        v.FireRate = Rate
    end
end

gunfuncs.NoRecoil = function()
    for i, v in pairs(GunStats.get()) do
        v.Recoil = Vector3.new(0,0,0)
    end
end

gunfuncs.NoReload = function()
    for i, v in pairs(GunStats.get()) do
        v.ReloadTime = 1e-123
    end
end

gunfuncs.NoSpread = function()
    for i, v in pairs(GunStats.get()) do
        v.Spread = 0
    end
end

gunfuncs.setAuto = function()
    for i, v in pairs(GunStats.get()) do
        v.Mode = 2
    end
end

gunfuncs.setSpeed = function(speed)
    for i, v in pairs(GunStats.get()) do
        v.ProjectileSpeed  = speed
    end
end

gunfuncs.setRange = function(Range)
    for i, v in pairs(GunStats.get()) do
        v.Range = Range
    end
end

gunfuncs.infAmmo = function()
    for i, v in pairs(GunStats.get()) do
        v.MagSize = 9e9
    end
end

return gunfuncs
