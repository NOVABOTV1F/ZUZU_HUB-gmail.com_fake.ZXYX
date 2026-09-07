--[[
    ╔══════════════════════════════════════════════════════════════════╗
    ║           ZUZU_LOADER.lua - Single File Entry Point              ║
    ║    Loads all 4 modules: DB + Framework + Reader + Main UI       ║
    ║              Keyless | Delta Executor | One Loadstring           ║
    ╚══════════════════════════════════════════════════════════════════╝
]]

-- ═══════════════════════════════════════════════════════════════════
-- CONFIG: Ganti link raw GitHub kamu di sini
-- ═══════════════════════════════════════════════════════════════════
local RAW_LINKS = {
    Database     = "https://raw.githubusercontent.com/NOVABOTV1F/ZUZU_HUB-gmail.com_fake.ZXYX/main/ZUZU_DATABASE.lua",
    Framework    = "https://raw.githubusercontent.com/NOVABOTV1F/ZUZU_HUB-gmail.com_fake.ZXYX/main/ZUZU_FRAMEWORK.lua",
    GameReader   = "https://raw.githubusercontent.com/NOVABOTV1F/ZUZU_HUB-gmail.com_fake.ZXYX/main/ZUZU_GAME_READER.lua",
    MainUI       = "https://raw.githubusercontent.com/NOVABOTV1F/ZUZU_HUB-gmail.com_fake.ZXYX/main/ZUZU_MAIN.lua",
}

-- ═══════════════════════════════════════════════════════════════════
-- LOADER SYSTEM
-- ═══════════════════════════════════════════════════════════════════
local function LoadModule(name, url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url, true))()
    end)

    if success then
        print("✅ [ZUZU] Loaded: " .. name)
        return result
    else
        warn("❌ [ZUZU] Failed to load: " .. name .. " | Error: " .. tostring(result))
        return nil
    end
end

print("
🐺 ZUZU HUB v5000 - Initializing...")
print("═══════════════════════════════════════")

-- Step 1: Load Database (harus pertama)
local DB = LoadModule("Database", RAW_LINKS.Database)
_G.ZUZU_DB = DB

-- Step 2: Load Framework
local FW = LoadModule("Framework", RAW_LINKS.Framework)
_G.ZUZU_FW = FW

-- Step 3: Load Game Reader
local Reader = LoadModule("GameReader", RAW_LINKS.GameReader)
_G.ZUZU_READER = Reader

-- Step 4: Load Main UI (terakhir, butuh DB & FW)
local UI = LoadModule("MainUI", RAW_LINKS.MainUI)
_G.ZUZU_UI = UI

print("═══════════════════════════════════════")
print("🐺 ZUZU HUB v5000 - All Systems Ready!")
print("🔓 Keyless | Delta Executor | Grow A Garden")
print("Press RightCtrl to toggle UI
")
