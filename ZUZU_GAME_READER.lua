--[[
    ╔══════════════════════════════════════════════════════════════════╗
    ║           ZUZU_GAME_READER.lua - Game Scanner                   ║
    ║         Read Garden / Plots / Pets / Eggs / Player Data         ║
    ║                    v5000 - Delta Executor                       ║
    ╚══════════════════════════════════════════════════════════════════╝
]]

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

local ZUZU_READER = {}
ZUZU_READER.Version = "5000"

-- ============================================
-- GARDEN SCANNER
-- ============================================
ZUZU_READER.ScanGarden = function()
    local plots = {}
    local garden = Workspace:FindFirstChild("Garden") 
        or Workspace:FindFirstChild("Plots")
        or Workspace:FindFirstChild("PlayerGardens")
    
    if garden then
        for _, obj in ipairs(garden:GetDescendants()) do
            if obj:IsA("BasePart") and (
                obj.Name:lower():find("plot") or 
                obj.Name:lower():find("garden") or
                obj.Name:lower():find("slot")
            ) then
                table.insert(plots, {
                    Name = obj.Name,
                    Position = obj.Position,
                    Instance = obj,
                    HasEgg = false,
                    EggType = nil,
                    Progress = 0,
                })
            end
        end
    end
    
    -- Fallback: scan workspace for plot-like parts near player
    if #plots == 0 then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                local n = obj.Name:lower()
                if n:find("plot") or n:find("egg") or n:find("garden") then
                    local dist = (obj.Position - Character.HumanoidRootPart.Position).Magnitude
                    if dist < 300 then
                        table.insert(plots, {
                            Name = obj.Name,
                            Position = obj.Position,
                            Instance = obj,
                            HasEgg = false,
                            EggType = nil,
                            Progress = 0,
                        })
                    end
                end
            end
        end
    end
    
    print(string.format("📊 Scanned %d garden plots", #plots))
    return plots
end

-- ============================================
-- EGG DETECTOR
-- ============================================
ZUZU_READER.ScanEggs = function(plot)
    local eggs = {}
    for _, child in ipairs(plot.Instance:GetDescendants()) do
        if child:IsA("Model") or child:IsA("BasePart") then
            local n = child.Name:lower()
            if n:find("egg") or n:find("hatch") then
                table.insert(eggs, {
                    Name = child.Name,
                    Instance = child,
                    Type = "Unknown",
                    TimeRemaining = 0,
                })
            end
        end
    end
    return eggs
end

-- ============================================
-- PET DETECTOR
-- ============================================
ZUZU_READER.ScanPets = function()
    local pets = {}
    local petFolder = Workspace:FindFirstChild("Pets") 
        or Workspace:FindFirstChild("PlayerPets")
    
    if petFolder then
        for _, pet in ipairs(petFolder:GetDescendants()) do
            if pet:IsA("Model") and pet:FindFirstChild("Humanoid") then
                table.insert(pets, {
                    Name = pet.Name,
                    Instance = pet,
                    Position = pet:GetPivot().Position,
                })
            end
        end
    end
    return pets
end

-- ============================================
-- PLAYER DATA READER
-- ============================================
ZUZU_READER.GetPlayerData = function()
    local data = {
        Name = Player.Name,
        UserId = Player.UserId,
        Position = Character and Character:FindFirstChild("HumanoidRootPart") 
            and Character.HumanoidRootPart.Position or Vector3.new(0,0,0),
        Level = 0,
        Sheckles = 0,
        Seeds = {},
        Pets = {},
        Gear = {},
    }
    
    -- Try to read leaderstats
    local leaderstats = Player:FindFirstChild("leaderstats")
    if leaderstats then
        for _, stat in ipairs(leaderstats:GetChildren()) do
            if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                if stat.Name:lower():find("level") then data.Level = stat.Value end
                if stat.Name:lower():find("money") or stat.Name:lower():find("sheckle") 
                   or stat.Name:lower():find("coin") then
                    data.Sheckles = stat.Value
                end
            end
        end
    end
    
    return data
end

-- ============================================
-- REMOTE EVENTS SCANNER
-- ============================================
ZUZU_READER.ScanRemotes = function()
    local remotes = {
        Events = {},
        Functions = {},
    }
    
    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            table.insert(remotes.Events, obj.Name)
        elseif obj:IsA("RemoteFunction") then
            table.insert(remotes.Functions, obj.Name)
        end
    end
    
    print(string.format("📡 Found %d RemoteEvents, %d RemoteFunctions", 
        #remotes.Events, #remotes.Functions))
    return remotes
end

-- ============================================
-- NEARBY PLAYERS
-- ============================================
ZUZU_READER.GetNearbyPlayers = function(radius)
    radius = radius or 100
    local nearby = {}
    local myPos = Character and Character:FindFirstChild("HumanoidRootPart") 
        and Character.HumanoidRootPart.Position or Vector3.new(0,0,0)
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Player and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local dist = (hrp.Position - myPos).Magnitude
                if dist <= radius then
                    table.insert(nearby, {
                        Name = p.Name,
                        Distance = math.floor(dist),
                        Position = hrp.Position,
                    })
                end
            end
        end
    end
    return nearby
end

-- ============================================
-- FULL GAME DUMP
-- ============================================
ZUZU_READER.FullDump = function()
    print("\n========== ZUZU GAME READER DUMP ==========")
    
    local plots = ZUZU_READER.ScanGarden()
    print(string.format("🌱 Garden Plots: %d", #plots))
    
    local pets = ZUZU_READER.ScanPets()
    print(string.format("🐾 Pets in World: %d", #pets))
    
    local data = ZUZU_READER.GetPlayerData()
    print(string.format("👤 Player: %s | Level: %d | Sheckles: %d", 
        data.Name, data.Level, data.Sheckles))
    
    local remotes = ZUZU_READER.ScanRemotes()
    
    local nearby = ZUZU_READER.GetNearbyPlayers(200)
    print(string.format("👥 Nearby Players: %d", #nearby))
    
    print("==========================================\n")
    return {
        Plots = plots,
        Pets = pets,
        PlayerData = data,
        Remotes = remotes,
        NearbyPlayers = nearby,
    }
end

-- ============================================
-- AUTO-UPDATE LOOP
-- ============================================
ZUZU_READER.StartMonitoring = function(interval)
    interval = interval or 5
    task.spawn(function()
        while true do
            task.wait(interval)
            local plots = ZUZU_READER.ScanGarden()
            for i, plot in ipairs(plots) do
                local eggs = ZUZU_READER.ScanEggs(plot)
                if #eggs > 0 then
                    print(string.format("🥚 Plot %d has %d egg(s)", i, #eggs))
                end
            end
        end
    end)
end

print("✅ ZUZU_GAME_READER v5000 Loaded!")
print("📖 Functions: ScanGarden(), ScanEggs(), ScanPets()")
print("📖 GetPlayerData(), ScanRemotes(), GetNearbyPlayers()")
print("📖 FullDump(), StartMonitoring(interval)")

return ZUZU_READER
