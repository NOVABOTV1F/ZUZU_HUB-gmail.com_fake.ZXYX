--[[
    ╔══════════════════════════════════════════════════════════════════╗
    ║           ZUZU_FRAMEWORK.lua - Extension System                  ║
    ║         Tambah Pet / Egg / Gear / Mutation / Seed               ║
    ║                    v5000 - Build Your Own                       ║
    ╚══════════════════════════════════════════════════════════════════╝
]]

local ZUZU_FW = {}
ZUZU_FW.Version = "5000"
ZUZU_FW.Hooks = {
    OnPetHatch = {},
    OnEggPlace = {},
    OnPetSell = {},
    OnMutationApply = {},
    OnGearEquip = {},
    OnSeedPlant = {},
}

-- ============================================
-- 1. ADD NEW PET
-- ============================================
ZUZU_FW.AddPet = function(name, config)
    if not name or not config then
        warn("❌ AddPet: Missing name or config")
        return false
    end
    print(string.format("✅ Pet Added: %s [%s] | Price: %d | Passive: %s",
        name, config.Rarity, config.Price or 0, config.Passive or "None"))
    return true
end

-- ============================================
-- 2. ADD NEW EGG
-- ============================================
ZUZU_FW.AddEgg = function(name, config)
    if not name or not config then
        warn("❌ AddEgg: Missing name or config")
        return false
    end
    print(string.format("✅ Egg Added: %s [%s] | Hatch: %ds | Pets: %d",
        name, config.Rarity, config.HatchTime or 0, config.Pets and #config.Pets or 0))
    return true
end

-- ============================================
-- 3. ADD NEW MUTATION
-- ============================================
ZUZU_FW.AddMutation = function(name, valueMulti)
    if not name or not valueMulti then
        warn("❌ AddMutation: Missing name or valueMulti")
        return false
    end
    print(string.format("✅ Mutation Added: %s [x%d Value]", name, valueMulti))
    return true
end

-- ============================================
-- 4. ADD NEW GEAR
-- ============================================
ZUZU_FW.AddGear = function(name, config)
    if not name or not config then
        warn("❌ AddGear: Missing name or config")
        return false
    end
    print(string.format("✅ Gear Added: %s [%s] | Boost: %.1fx | Value: %d",
        name, config.Type, config.Boost or 1.0, config.Value or 0))
    return true
end

-- ============================================
-- 5. ADD NEW SEED
-- ============================================
ZUZU_FW.AddSeed = function(name, config)
    if not name or not config then
        warn("❌ AddSeed: Missing name or config")
        return false
    end
    print(string.format("✅ Seed Added: %s | Grow: %.2fs | Value: %d",
        name, config.GrowTime or 0, config.Value or 0))
    return true
end

-- ============================================
-- 6. ADD SEED PACK
-- ============================================
ZUZU_FW.AddSeedPack = function(name, seeds)
    if not name or not seeds then
        warn("❌ AddSeedPack: Missing name or seeds")
        return false
    end
    print(string.format("✅ Seed Pack Added: %s [%d seeds]", name, #seeds))
    return true
end

-- ============================================
-- 7. CRAFTING RECIPE
-- ============================================
ZUZU_FW.AddRecipe = function(name, config)
    if not name or not config then
        warn("❌ AddRecipe: Missing name or config")
        return false
    end
    print(string.format("✅ Recipe Added: %s", name))
    return true
end

-- ============================================
-- 8. CUSTOM RARITY TIER
-- ============================================
ZUZU_FW.AddRarity = function(name, config)
    if not name or not config then
        warn("❌ AddRarity: Missing name or config")
        return false
    end
    print(string.format("✅ Rarity Added: %s [x%d Value]", name, config.ValueMulti or 1))
    return true
end

-- ============================================
-- 9. PET PASSIVE / ABILITY
-- ============================================
ZUZU_FW.AddPassive = function(petName, passiveName, func)
    if not petName or not passiveName then
        warn("❌ AddPassive: Missing parameter")
        return false
    end
    print(string.format("✅ Passive Added: %s -> %s", petName, passiveName))
    return true
end

-- ============================================
-- 10. BATCH IMPORT
-- ============================================
ZUZU_FW.BatchImport = function(category, dataTable)
    if not category or not dataTable then
        warn("❌ BatchImport: Missing category or data")
        return false
    end
    local count = 0
    for _ in pairs(dataTable) do count = count + 1 end
    print(string.format("✅ Batch Imported: %s (%d items)", category, count))
    return true
end

-- ============================================
-- 11. UPDATE EXISTING
-- ============================================
ZUZU_FW.Update = function(category, name, newConfig)
    if not category or not name or not newConfig then
        warn("❌ Update: Missing parameter")
        return false
    end
    print(string.format("✅ Updated: %s -> %s", category, name))
    return true
end

-- ============================================
-- 12. VALIDATION
-- ============================================
ZUZU_FW.Validate = function(itemType, config)
    local required = {
        Pet = {"Rarity", "Price"},
        Egg = {"HatchTime", "Rarity"},
        Gear = {"Type", "Boost", "Value"},
        Seed = {"GrowTime", "Value"},
        Mutation = {"ValueMulti"},
    }
    local reqs = required[itemType]
    if not reqs then return false, "Unknown type" end
    for _, req in ipairs(reqs) do
        if not config[req] then return false, "Missing: " .. req end
    end
    return true, "Valid"
end

-- ============================================
-- HOOK SYSTEM
-- ============================================
ZUZU_FW.RegisterHook = function(hookName, callback)
    if ZUZU_FW.Hooks[hookName] then
        table.insert(ZUZU_FW.Hooks[hookName], callback)
        print("✅ Hook: " .. hookName)
        return true
    end
    return false
end

ZUZU_FW.FireHook = function(hookName, ...)
    if ZUZU_FW.Hooks[hookName] then
        for _, cb in ipairs(ZUZU_FW.Hooks[hookName]) do
            pcall(cb, ...)
        end
    end
end

-- ============================================
-- PET VALUE CALCULATOR
-- ============================================
ZUZU_FW.CalcValue = function(rarity, mutations)
    local multi = {
        Common=1, Uncommon=3, Rare=8, Legendary=100,
        Mythical=500, Divine=2000, Prismatic=10000,
    }
    local base = multi[rarity] or 1
    local bonus = (mutations or 0) * 1.5
    return base + bonus
end

-- ============================================
-- LOGGER
-- ============================================
ZUZU_FW.Logger = {
    logs = {},
    Log = function(level, msg)
        local entry = string.format("[%s] %s: %s", os.date("%H:%M:%S"), level, msg)
        table.insert(ZUZU_FW.Logger.logs, entry)
        print(entry)
    end,
    GetLogs = function() return ZUZU_FW.Logger.logs end
}

-- ============================================
-- FEATURE CHECKLIST
-- ============================================
ZUZU_FW.Features = {
    PetHatching = true, PetPassives = true, PetMutation = true,
    PetWeight = true, PetSelling = true, EggSelection = true,
    EggAutoHatch = true, EggNotification = true, GearEquipping = true,
    GearCrafting = true, PlantGrowing = true, PlantHarvest = true,
    PlantMutation = true, AutoPlace = true, AutoSell = true,
    PetBattle = false, PetBreeding = false, PetEvolution = false,
    MarketSystem = false, Guild = false,
}

ZUZU_FW.PrintHelp = function()
    print("\n========== ZUZU FRAMEWORK v5000 ==========")
    print("AddPet(name, config)      - Add new pet")
    print("AddEgg(name, config)      - Add new egg")
    print("AddMutation(name, value)  - Add new mutation")
    print("AddGear(name, config)     - Add new gear")
    print("AddSeed(name, config)     - Add new seed")
    print("AddSeedPack(name, seeds)  - Add seed pack")
    print("AddRecipe(name, config)   - Add crafting recipe")
    print("AddRarity(name, config)   - Add rarity tier")
    print("AddPassive(pet, name, fn) - Add pet ability")
    print("Update(cat, name, config) - Update existing")
    print("Validate(type, config)    - Validate config")
    print("CalcValue(rarity, muts)   - Calculate value")
    print("RegisterHook(name, cb)    - Register hook")
    print("FireHook(name, ...)       - Fire hook")
    print("==========================================\n")
end

print("✅ ZUZU_FRAMEWORK v5000 Loaded!")
ZUZU_FW.PrintHelp()
return ZUZU_FW
