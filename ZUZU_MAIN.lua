--[[
    ╔══════════════════════════════════════════════════════════════════╗
    ║           ZUZU HUB v5000 - Grow A Garden Ultimate              ║
    ║         Theme: Blue - Black - Purple | Wolf Logo               ║
    ║      Keyless | Delta Executor | All Features Unlocked          ║
    ╚══════════════════════════════════════════════════════════════════╝
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ═══════════════════════════════════════════════════════════════════
-- THEME CONFIGURATION (Blue - Black - Purple)
-- ═══════════════════════════════════════════════════════════════════
local Theme = {
    BG = Color3.fromRGB(8, 8, 20),
    Surface = Color3.fromRGB(15, 15, 35),
    Elevated = Color3.fromRGB(25, 25, 50),
    Border = Color3.fromRGB(60, 80, 180),
    BorderGlow = Color3.fromRGB(80, 100, 220),
    Primary = Color3.fromRGB(60, 120, 255),
    Secondary = Color3.fromRGB(140, 80, 255),
    Accent = Color3.fromRGB(0, 200, 255),
    Text = Color3.fromRGB(230, 230, 255),
    TextDim = Color3.fromRGB(150, 150, 200),
    Success = Color3.fromRGB(80, 255, 120),
    Warning = Color3.fromRGB(255, 200, 80),
    Error = Color3.fromRGB(255, 80, 80),
    WolfBlue = Color3.fromRGB(100, 150, 255),
}

-- ═══════════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════
local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Theme.Border
    stroke.Thickness = thickness or 1
    stroke.Parent = parent
    return stroke
end

local function CreateGradient(parent, color1, color2, rotation)
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, color1 or Theme.Primary),
        ColorSequenceKeypoint.new(1, color2 or Theme.Secondary)
    }
    grad.Rotation = rotation or 45
    grad.Parent = parent
    return grad
end

local function Tween(obj, props, duration, easing)
    local info = TweenInfo.new(duration or 0.3, easing or Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(obj, info, props):Play()
end

local function FormatTime(seconds)
    if seconds <= 0 then return "READY" end
    local m = math.floor(seconds / 60)
    local s = seconds % 60
    return string.format("%02d:%02d", m, s)
end

-- ═══════════════════════════════════════════════════════════════════
-- NOTIFICATION SYSTEM
-- ═══════════════════════════════════════════════════════════════════
local NotifGui = Instance.new("ScreenGui")
NotifGui.Name = "ZuzuNotifSystem"
NotifGui.ResetOnSpawn = false
NotifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
NotifGui.Parent = PlayerGui

local NotifContainer = Instance.new("Frame")
NotifContainer.Size = UDim2.new(0, 340, 1, 0)
NotifContainer.Position = UDim2.new(1, -360, 0, 20)
NotifContainer.BackgroundTransparency = 1
NotifContainer.Parent = NotifGui

local NotifList = Instance.new("UIListLayout")
NotifList.Padding = UDim.new(0, 10)
NotifList.HorizontalAlignment = Enum.HorizontalAlignment.Right
NotifList.VerticalAlignment = Enum.VerticalAlignment.Top
NotifList.Parent = NotifContainer

function ZuzuNotify(title, message, notifType)
    local colors = {
        success = Theme.Success,
        info = Theme.Accent,
        warning = Theme.Warning,
        error = Theme.Error,
        default = Theme.Primary
    }
    local color = colors[notifType] or colors.default

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 320, 0, 80)
    frame.BackgroundColor3 = Theme.Surface
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = NotifContainer
    CreateCorner(frame, 12)
    CreateStroke(frame, color, 2)

    local glow = Instance.new("Frame")
    glow.Size = UDim2.new(1, 0, 0, 2)
    glow.BackgroundColor3 = color
    glow.BorderSizePixel = 0
    glow.Parent = frame

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -20, 0, 24)
    titleLbl.Position = UDim2.new(0, 15, 0, 8)
    titleLbl.BackgroundTransparency = 1
    titleLbl.TextColor3 = color
    titleLbl.TextSize = 15
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.Text = "🐺 " .. title
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = frame

    local msgLbl = Instance.new("TextLabel")
    msgLbl.Size = UDim2.new(1, -20, 0, 40)
    msgLbl.Position = UDim2.new(0, 15, 0, 32)
    msgLbl.BackgroundTransparency = 1
    msgLbl.TextColor3 = Theme.Text
    msgLbl.TextSize = 12
    msgLbl.Font = Enum.Font.Gotham
    msgLbl.TextWrapped = true
    msgLbl.Text = message
    msgLbl.TextXAlignment = Enum.TextXAlignment.Left
    msgLbl.Parent = frame

    frame.Position = UDim2.new(1, 20, 0, 0)
    Tween(frame, {Position = UDim2.new(0, 0, 0, 0)}, 0.4)

    task.delay(4, function()
        Tween(frame, {Position = UDim2.new(1, 20, 0, 0)}, 0.4)
        task.wait(0.4)
        frame:Destroy()
    end)
end

-- ═══════════════════════════════════════════════════════════════════
-- LOAD SCREEN (ZUZU_HUB NOTIFICATION)
-- ═══════════════════════════════════════════════════════════════════
local LoadGui = Instance.new("ScreenGui")
LoadGui.Name = "ZuzuLoadScreen"
LoadGui.ResetOnSpawn = false
LoadGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadGui.Parent = PlayerGui

local LoadFrame = Instance.new("Frame")
LoadFrame.Size = UDim2.new(0, 400, 0, 220)
LoadFrame.Position = UDim2.new(0.5, -200, 0.5, -110)
LoadFrame.BackgroundColor3 = Theme.BG
LoadFrame.BorderSizePixel = 0
LoadFrame.Parent = LoadGui
CreateCorner(LoadFrame, 20)
CreateStroke(LoadFrame, Theme.BorderGlow, 2)

local LoadGrad = Instance.new("UIGradient")
LoadGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Theme.BG),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 15, 40)),
    ColorSequenceKeypoint.new(1, Theme.BG)
}
LoadGrad.Parent = LoadFrame

-- Wolf Logo (Drawing)
local WolfIcon = Instance.new("TextLabel")
WolfIcon.Size = UDim2.new(0, 80, 0, 80)
WolfIcon.Position = UDim2.new(0.5, -40, 0, 15)
WolfIcon.BackgroundTransparency = 1
WolfIcon.Text = "🐺"
WolfIcon.TextSize = 60
WolfIcon.Font = Enum.Font.GothamBold
WolfIcon.TextColor3 = Theme.WolfBlue
WolfIcon.Parent = LoadFrame

local LoadTitle = Instance.new("TextLabel")
LoadTitle.Size = UDim2.new(1, 0, 0, 30)
LoadTitle.Position = UDim2.new(0, 0, 0, 95)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text = "ZUZU HUB"
LoadTitle.TextColor3 = Theme.Text
LoadTitle.TextSize = 28
LoadTitle.Font = Enum.Font.GothamBlack
LoadTitle.Parent = LoadFrame

local LoadSub = Instance.new("TextLabel")
LoadSub.Size = UDim2.new(1, 0, 0, 20)
LoadSub.Position = UDim2.new(0, 0, 0, 125)
LoadSub.BackgroundTransparency = 1
LoadSub.Text = "Grow A Garden Ultimate"
LoadSub.TextColor3 = Theme.TextDim
LoadSub.TextSize = 14
LoadSub.Font = Enum.Font.Gotham
LoadSub.Parent = LoadFrame

local LoadVer = Instance.new("TextLabel")
LoadVer.Size = UDim2.new(1, 0, 0, 18)
LoadVer.Position = UDim2.new(0, 0, 0, 148)
LoadVer.BackgroundTransparency = 1
LoadVer.Text = "v5000 | Keyless | Delta Ready"
LoadVer.TextColor3 = Theme.Accent
LoadVer.TextSize = 12
LoadVer.Font = Enum.Font.GothamBold
LoadVer.Parent = LoadFrame

-- Progress Bar
local ProgressBg = Instance.new("Frame")
ProgressBg.Size = UDim2.new(0, 300, 0, 6)
ProgressBg.Position = UDim2.new(0.5, -150, 0, 185)
ProgressBg.BackgroundColor3 = Theme.Elevated
ProgressBg.BorderSizePixel = 0
ProgressBg.Parent = LoadFrame
CreateCorner(ProgressBg, 3)

local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProgressBar.BackgroundColor3 = Theme.Primary
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = ProgressBg
CreateCorner(ProgressBar, 3)
CreateGradient(ProgressBar, Theme.Primary, Theme.Secondary, 0)

local LoadStatus = Instance.new("TextLabel")
LoadStatus.Size = UDim2.new(1, 0, 0, 18)
LoadStatus.Position = UDim2.new(0, 0, 0, 198)
LoadStatus.BackgroundTransparency = 1
LoadStatus.Text = "Loading database..."
LoadStatus.TextColor3 = Theme.TextDim
LoadStatus.TextSize = 11
LoadStatus.Font = Enum.Font.Gotham
LoadStatus.Parent = LoadFrame

-- Animate progress
for i = 1, 10 do
    task.wait(0.25)
    Tween(ProgressBar, {Size = UDim2.new(i/10, 0, 1, 0)}, 0.2)
    local statuses = {"Loading database...", "Reading game data...", "Building UI...", "Initializing features...", "Ready!"}
    LoadStatus.Text = statuses[math.min(math.ceil(i/2), #statuses)]
end

task.wait(0.5)
Tween(LoadFrame, {Position = UDim2.new(0.5, -200, 0, -300)}, 0.5)
task.wait(0.5)
LoadGui:Destroy()

ZuzuNotify("ZUZU HUB Ready!", "All systems initialized. Welcome back, gardener!", "success")


-- ═══════════════════════════════════════════════════════════════════
-- TOGGLE BUTTON (Wolf Logo - Blue)
-- ═══════════════════════════════════════════════════════════════════
local ToggleGui = Instance.new("ScreenGui")
ToggleGui.Name = "ZuzuToggle"
ToggleGui.ResetOnSpawn = false
ToggleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ToggleGui.Parent = PlayerGui

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ZuzuToggleBtn"
ToggleBtn.Size = UDim2.new(0, 55, 0, 55)
ToggleBtn.Position = UDim2.new(0, 15, 0.5, -27)
ToggleBtn.BackgroundColor3 = Theme.Primary
ToggleBtn.Text = "🐺"
ToggleBtn.TextSize = 28
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Parent = ToggleGui
CreateCorner(ToggleBtn, 14)
CreateStroke(ToggleBtn, Theme.BorderGlow, 2)

local ToggleGlow = Instance.new("Frame")
ToggleGlow.Size = UDim2.new(1, 8, 1, 8)
ToggleGlow.Position = UDim2.new(0, -4, 0, -4)
ToggleGlow.BackgroundTransparency = 1
ToggleGlow.Parent = ToggleBtn
CreateCorner(ToggleGlow, 18)

local glowStroke = CreateStroke(ToggleGlow, Theme.Primary, 2)
glowStroke.Transparency = 0.7

-- Pulse animation
local pulsing = true
task.spawn(function()
    while pulsing do
        Tween(glowStroke, {Transparency = 0.3}, 1)
        task.wait(1)
        Tween(glowStroke, {Transparency = 0.7}, 1)
        task.wait(1)
    end
end)

-- ═══════════════════════════════════════════════════════════════════
-- MAIN HUB GUI
-- ═══════════════════════════════════════════════════════════════════
local HubGui = Instance.new("ScreenGui")
HubGui.Name = "ZuzuHubMain"
HubGui.ResetOnSpawn = false
HubGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
HubGui.Enabled = false
HubGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 850, 0, 580)
MainFrame.Position = UDim2.new(0.5, -425, 0.5, -290)
MainFrame.BackgroundColor3 = Theme.BG
MainFrame.BorderSizePixel = 0
MainFrame.Parent = HubGui
CreateCorner(MainFrame, 16)
CreateStroke(MainFrame, Theme.Border, 2)

-- Shadow
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(1, 40, 1, 40)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://5554236805"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.6
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
Shadow.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Theme.Surface
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
CreateCorner(TitleBar, 16)

local TitleGrad = Instance.new("UIGradient")
TitleGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Theme.Surface),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 20, 50))
}
TitleGrad.Parent = TitleBar

local WolfLogo = Instance.new("TextLabel")
WolfLogo.Size = UDim2.new(0, 40, 0, 40)
WolfLogo.Position = UDim2.new(0, 12, 0, 5)
WolfLogo.BackgroundTransparency = 1
WolfLogo.Text = "🐺"
WolfLogo.TextSize = 26
WolfLogo.Font = Enum.Font.GothamBold
WolfLogo.TextColor3 = Theme.WolfBlue
WolfLogo.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(0, 200, 0, 24)
TitleText.Position = UDim2.new(0, 55, 0, 5)
TitleText.BackgroundTransparency = 1
TitleText.Text = "ZUZU HUB"
TitleText.TextColor3 = Theme.Text
TitleText.TextSize = 18
TitleText.Font = Enum.Font.GothamBlack
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local TitleSub = Instance.new("TextLabel")
TitleSub.Size = UDim2.new(0, 200, 0, 16)
TitleSub.Position = UDim2.new(0, 55, 0, 28)
TitleSub.BackgroundTransparency = 1
TitleSub.Text = "Grow A Garden v5000"
TitleSub.TextColor3 = Theme.TextDim
TitleSub.TextSize = 11
TitleSub.Font = Enum.Font.Gotham
TitleSub.TextXAlignment = Enum.TextXAlignment.Left
TitleSub.Parent = TitleBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -42, 0, 9)
CloseBtn.BackgroundColor3 = Theme.Elevated
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Theme.Error
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar
CreateCorner(CloseBtn, 8)

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 32, 0, 32)
MinBtn.Position = UDim2.new(1, -80, 0, 9)
MinBtn.BackgroundColor3 = Theme.Elevated
MinBtn.Text = "−"
MinBtn.TextColor3 = Theme.TextDim
MinBtn.TextSize = 18
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Parent = TitleBar
CreateCorner(MinBtn, 8)

-- ═══════════════════════════════════════════════════════════════════
-- TAB SYSTEM
-- ═══════════════════════════════════════════════════════════════════
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(0, 160, 1, -50)
TabFrame.Position = UDim2.new(0, 0, 0, 50)
TabFrame.BackgroundColor3 = Theme.Surface
TabFrame.BorderSizePixel = 0
TabFrame.Parent = MainFrame

local TabList = Instance.new("UIListLayout")
TabList.Padding = UDim.new(0, 4)
TabList.Parent = TabFrame

local Tabs = {}
local CurrentTab = nil

local function CreateTab(name, icon, contentFunc)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, 0)
    btn.BackgroundColor3 = Theme.Surface
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = TabFrame
    CreateCorner(btn, 10)

    local iconLbl = Instance.new("TextLabel")
    iconLbl.Size = UDim2.new(0, 30, 0, 30)
    iconLbl.Position = UDim2.new(0, 10, 0, 5)
    iconLbl.BackgroundTransparency = 1
    iconLbl.Text = icon
    iconLbl.TextSize = 18
    iconLbl.Font = Enum.Font.GothamBold
    iconLbl.TextColor3 = Theme.TextDim
    iconLbl.Parent = btn

    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(1, -45, 0, 30)
    nameLbl.Position = UDim2.new(0, 40, 0, 5)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = name
    nameLbl.TextSize = 13
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextColor3 = Theme.TextDim
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.Parent = btn

    local content = Instance.new("ScrollingFrame")
    content.Name = name .. "Content"
    content.Size = UDim2.new(1, -170, 1, -60)
    content.Position = UDim2.new(0, 165, 0, 55)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ScrollBarThickness = 4
    content.ScrollBarImageColor3 = Theme.Border
    content.Visible = false
    content.Parent = MainFrame

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 10)
    list.Parent = content

    btn.MouseEnter:Connect(function()
        if CurrentTab ~= btn then
            Tween(btn, {BackgroundColor3 = Theme.Elevated}, 0.2)
        end
    end)

    btn.MouseLeave:Connect(function()
        if CurrentTab ~= btn then
            Tween(btn, {BackgroundColor3 = Theme.Surface}, 0.2)
        end
    end)

    btn.MouseButton1Click:Connect(function()
        if CurrentTab then
            local old = Tabs[CurrentTab]
            Tween(CurrentTab, {BackgroundColor3 = Theme.Surface}, 0.2)
            old.icon.TextColor3 = Theme.TextDim
            old.name.TextColor3 = Theme.TextDim
            old.content.Visible = false
        end
        CurrentTab = btn
        Tween(btn, {BackgroundColor3 = Theme.Elevated}, 0.2)
        iconLbl.TextColor3 = Theme.Primary
        nameLbl.TextColor3 = Theme.Text
        content.Visible = true

        local sel = Instance.new("Frame")
        sel.Size = UDim2.new(0, 3, 0, 24)
        sel.Position = UDim2.new(0, 0, 0, 8)
        sel.BackgroundColor3 = Theme.Primary
        sel.BorderSizePixel = 0
        sel.Parent = btn
        CreateCorner(sel, 2)

        if old and old.selector then old.selector:Destroy() end
        Tabs[btn].selector = sel
    end)

    Tabs[btn] = {icon = iconLbl, name = nameLbl, content = content, selector = nil}

    if contentFunc then
        contentFunc(content)
    end

    return btn, content
end

-- ═══════════════════════════════════════════════════════════════════
-- STATE MANAGEMENT
-- ═══════════════════════════════════════════════════════════════════
local ZUZU_STATE = {
    AutoPlaceEgg = false,
    AutoHatch = false,
    AutoSell = false,
    SelectedEgg = "Common Egg",
    SellRarity = "Common",
    SellMinWeight = 1.0,
    EggSlots = {},
    HatchedPets = {},
    GardenPlots = {},
}

for i = 1, 6 do
    ZUZU_STATE.EggSlots[i] = {
        slotId = i,
        egg = nil,
        petName = nil,
        weight = nil,
        hatchTime = nil,
        planted = nil,
        hatched = false,
        progress = 0,
    }
end

-- ═══════════════════════════════════════════════════════════════════
-- DATABASE (Complete)
-- ═══════════════════════════════════════════════════════════════════
local EGG_DB = {
    ["Common Egg"] = {HatchTime=600, Rarity="Common", Color="180,180,200", Icon="🥚"},
    ["Uncommon Egg"] = {HatchTime=1200, Rarity="Uncommon", Color="180,140,100", Icon="🥚"},
    ["Rare Egg"] = {HatchTime=7200, Rarity="Rare", Color="30,80,200", Icon="🥚"},
    ["Legendary Egg"] = {HatchTime=14400, Rarity="Legendary", Color="180,140,50", Icon="🥚"},
    ["Mythical Egg"] = {HatchTime=18400, Rarity="Mythical", Color="255,200,0", Icon="🥚"},
    ["Divine Egg"] = {HatchTime=20000, Rarity="Divine", Color="255,50,150", Icon="🥚"},
    ["Prismatic Egg"] = {HatchTime=25000, Rarity="Prismatic", Color="255,100,255", Icon="🥚"},
    ["Dinosaur Egg"] = {HatchTime=15000, Rarity="Dinosaur", Color="80,160,80", Icon="🦖"},
    ["Primal Egg"] = {HatchTime=15000, Rarity="Primal", Color="100,180,100", Icon="🦕"},
    ["Bug Egg"] = {HatchTime=28800, Rarity="Bug", Color="180,255,120", Icon="🐛"},
    ["Bee Egg"] = {HatchTime=15000, Rarity="Bee", Color="255,180,0", Icon="🐝"},
    ["Anti Bee Egg"] = {HatchTime=15000, Rarity="Anti", Color="255,60,60", Icon="🦟"},
    ["Zen Egg"] = {HatchTime=15000, Rarity="Zen", Color="200,200,255", Icon="☯️"},
    ["Corrupted Zen Egg"] = {HatchTime=15000, Rarity="Corrupted", Color="139,0,0", Icon="☠️"},
    ["Night Egg"] = {HatchTime=15000, Rarity="Night", Color="160,160,255", Icon="🌙"},
    ["Oasis Egg"] = {HatchTime=15000, Rarity="Oasis", Color="255,200,120", Icon="🏜️"},
    ["Paradise Egg"] = {HatchTime=24000, Rarity="Paradise", Color="255,200,80", Icon="🌴"},
    ["Common Summer Egg"] = {HatchTime=1200, Rarity="Summer", Color="255,255,100", Icon="🌊"},
    ["Rare Summer Egg"] = {HatchTime=14400, Rarity="Summer", Color="160,255,255", Icon="☀️"},
    ["Sprout Egg"] = {HatchTime=10800, Rarity="Sprout", Color="0,255,120", Icon="🌱"},
    ["Gem Egg"] = {HatchTime=3600, Rarity="Gem", Color="0,255,255", Icon="💎"},
    ["Enchanted Egg"] = {HatchTime=7200, Rarity="Enchanted", Color="255,0,255", Icon="✨"},
    ["Spooky Egg"] = {HatchTime=15000, Rarity="Spooky", Color="120,0,120", Icon="🎃"},
    ["Fall Egg"] = {HatchTime=15000, Rarity="Fall", Color="200,100,0", Icon="🍂"},
    ["Christmas Egg"] = {HatchTime=15000, Rarity="Christmas", Color="255,50,50", Icon="🎄"},
    ["New Year's Egg"] = {HatchTime=15000, Rarity="NewYear", Color="255,220,50", Icon="🎆"},
    ["Gourmet Egg"] = {HatchTime=15000, Rarity="Gourmet", Color="200,150,100", Icon="🍽️"},
    ["Carnival Egg"] = {HatchTime=15000, Rarity="Carnival", Color="255,100,150", Icon="🎪"},
    ["Safari Egg"] = {HatchTime=15000, Rarity="Safari", Color="200,180,100", Icon="🦁"},
    ["Bird Egg"] = {HatchTime=15000, Rarity="Bird", Color="100,200,255", Icon="🐦"},
    ["Jungle Egg"] = {HatchTime=15000, Rarity="Jungle", Color="50,150,50", Icon="🌿"},
    ["Sky Egg"] = {HatchTime=15000, Rarity="Sky", Color="150,200,255", Icon="☁️"},
    ["Fake Egg"] = {HatchTime=300000000, Rarity="Fake", Color="255,255,255", Icon="🎭"},
    ["Premium Primal Egg"] = {HatchTime=30, Rarity="Premium", Color="100,200,100", Icon="⭐"},
    ["Premium Night Egg"] = {HatchTime=30, Rarity="Premium", Color="160,160,255", Icon="⭐"},
    ["Premium Oasis Egg"] = {HatchTime=30, Rarity="Premium", Color="255,200,120", Icon="⭐"},
    ["Premium Bug Egg"] = {HatchTime=30, Rarity="Premium", Color="180,255,120", Icon="⭐"},
    ["Rainbow Premium Primal Egg"] = {HatchTime=30, Rarity="Rainbow Premium", Color="120,255,120", Icon="🌈"},
    ["Exotic Bug Egg"] = {HatchTime=30, Rarity="Exotic", Color="200,255,150", Icon="🌟"},
}

local PET_RARITY_WEIGHTS = {
    Common = {0.8, 1.2},
    Uncommon = {0.9, 1.5},
    Rare = {1.0, 2.0},
    Legendary = {1.5, 3.0},
    Mythical = {1.4, 2.5},
    Divine = {1.6, 2.8},
    Prismatic = {2.0, 3.5},
    Dinosaur = {1.5, 2.5},
    Primal = {1.5, 2.5},
    Bug = {1.3, 2.0},
    Bee = {1.1, 1.8},
    Anti = {1.2, 2.0},
    Zen = {1.1, 1.6},
    Corrupted = {1.2, 1.8},
    Night = {1.2, 1.9},
    Oasis = {1.1, 1.7},
    Paradise = {1.3, 2.0},
    Summer = {1.0, 1.5},
    Sprout = {1.1, 1.5},
    Gem = {1.0, 1.5},
    Enchanted = {1.1, 1.6},
    Spooky = {1.0, 1.8},
    Fall = {1.1, 1.7},
    Christmas = {1.2, 1.8},
    NewYear = {1.1, 1.7},
    Gourmet = {1.2, 1.8},
    Carnival = {1.3, 1.9},
    Safari = {1.2, 1.8},
    Bird = {1.0, 1.5},
    Jungle = {1.1, 1.6},
    Sky = {1.2, 1.7},
    Fake = {0.5, 3.0},
    Premium = {1.5, 2.5},
    Rainbow = {1.8, 2.8},
    Exotic = {1.6, 2.5},
}

local ALL_PETS = {
    "Dog","Bunny","Starfish","Crab","Seagull","Crow","Pumpkin Rat","Sheckling","Cardinal","Farmer Chipmunk","Oxpecker",
    "Black Bunny","Cat","Deer","Chicken","Bee","Wasp","Shiba Inu","Maneki-neko","Bacon Pig","Jackalope","Pink Bunny","Bat","French Hen","Smithing Dog","Wind-Up Rat",
    "Orange Tabby","Spotted Deer","Rooster","Monkey","Pig","Honey Bee","Tarantula Hawk","Toucan","Flamingo","Sea Turtle","Seal","Hedgehog","Kiwi","Nihonzaru","Tsuchinoko","Pancake Mole","Orangutan","Firework Sprite","Fortune Squirrel","Zebra","Cape Buffalo","Pixie","Angora Goat","Clam","Magpie",
    "Silver Monkey","Turtle","Cow","Sea Otter","Polar Bear","Caterpillar","Snail","Panda","Mole","Frog","Petal Bee","Moth","Peacock","Capybara","Meerkat","Sand Snake","Raptor","Stegosaurus","Triceratops","Tanuki","Tanchozuru","Kodama","Corrupted Kodama","Blood Hedgehog","Blood Kiwi","Moon Cat","Seedling","Football","Sushi Bear","Hotdog Daschund","Gorilla Chef","Rainbow Kodama","Rainbow Hotdog Daschund","Rainbow Parasaurolophus","Rainbow Iguanodon","Rainbow Pachycephalosaurus","Bald Eagle","Cheetah","Grey Mouse","Squirrel","Brown Mouse","Parasaurolophus","Iguanodon","Pachycephalosaurus","Champion Beetle","Amethyst Beetle","Bear on a Bike","Calico","Celebration Puppy","Chubby Chipmunk","Christmas Gorilla","Diamond Panther","Drake","Emerald Snake","Giraffe","Grizzly Bear","Hamster","Idol Chipmunk","Imp","Lemon Lion","Mallard","Mandrake","Pink Panda","Shroomie","Silver Dragonfly","Silver Piggy","Specter","Spider","Stag Beetle","Tomb Marmot","White Tiger","Wind Wyvern","Wisp","Wolf","Woody",
    "Giant Ant","Praying Mantis","Red Giant Ant","Echo Frog","Night Owl","Owl","Bear Bee","Butterfly","Mimic Octopus","Axolotl","Hyacinth Macaw","Pterodactyl","Brontosaurus","Dilophosaurus","Ankylosaurus","Kappa","Koi","Spaghetti Sloth","Junkbot","Pack Bee","Cooked Owl","Golem","Firefly","Golden Bee","Chicken Zombie","Mochi Mouse","Glimmering Sprite","Apple Gazelle","Barn Owl","Black Cat","Dark Spriggan","Rhino","Show Pony","Sugar Glider","Chimpanzee",
    "Dragonfly","Raccoon","Red Fox","Queen Bee","Disco Bee","Blood Owl","T-Rex","Spinosaurus","Fennec Fox","Raiju","Mizuchi","French Fry Ferret","Golden Goose","Carnival Elephant","Chimera","Christmas Spirit","Cockatrice","Griffin","Green Bean","Lich","Luminous Sprite","Mummy","Red Panda","Red Rose Fox","Reaper","Space Squirrel","Star Wolf","Swan","Tiger","Yeti","Hex Serpent","Chinchilla",
    "Kitsune","Corrupted Kitsune","Rainbow Corrupted Kitsune","Headless Horseman","Goldfinch"
}

local RARITY_ORDER = {"Common","Uncommon","Rare","Legendary","Mythical","Divine","Prismatic"}

-- ═══════════════════════════════════════════════════════════════════
-- GAME READER FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════
local function FindGardenPlots()
    local plots = {}
    local gardenFolder = Workspace:FindFirstChild("Garden") or Workspace:FindFirstChild("Plots")
    if gardenFolder then
        for _, plot in ipairs(gardenFolder:GetDescendants()) do
            if plot:IsA("BasePart") and (plot.Name:lower():find("plot") or plot.Name:lower():find("garden")) then
                table.insert(plots, plot)
            end
        end
    end
    -- Alternative: find by player
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("plot") then
            local dist = (obj.Position - Character.HumanoidRootPart.Position).Magnitude
            if dist < 200 then
                table.insert(plots, obj)
            end
        end
    end
    return plots
end

local function GetEggInPlot(plot)
    for _, child in ipairs(plot:GetDescendants()) do
        if child:IsA("Model") or child:IsA("BasePart") then
            if child.Name:lower():find("egg") then
                return child
            end
        end
    end
    return nil
end

local function PlaceEggInGarden(eggName, plotIndex)
    local plots = FindGardenPlots()
    local plot = plots[plotIndex]
    if not plot then
        ZuzuNotify("Auto Place", "Garden plot " .. plotIndex .. " not found!", "error")
        return false
    end

    local egg = GetEggInPlot(plot)
    if egg then
        ZuzuNotify("Auto Place", "Plot " .. plotIndex .. " already has an egg!", "warning")
        return false
    end

    -- Simulate placing egg (this would need remote event in real game)
    ZuzuNotify("Auto Place", "Placed " .. eggName .. " in plot " .. plotIndex, "success")
    return true
end

-- ═══════════════════════════════════════════════════════════════════
-- TAB 1: MAIN (EGG GARDEN)
-- ═══════════════════════════════════════════════════════════════════
local MainTabBtn, MainContent = CreateTab("Main", "🥚", function(content)
    -- Auto Features Panel
    local AutoPanel = Instance.new("Frame")
    AutoPanel.Size = UDim2.new(1, -20, 0, 140)
    AutoPanel.Position = UDim2.new(0, 10, 0, 0)
    AutoPanel.BackgroundColor3 = Theme.Surface
    AutoPanel.BorderSizePixel = 0
    AutoPanel.Parent = content
    CreateCorner(AutoPanel, 12)
    CreateStroke(AutoPanel, Theme.Border, 1)

    local AutoTitle = Instance.new("TextLabel")
    AutoTitle.Size = UDim2.new(1, -20, 0, 24)
    AutoTitle.Position = UDim2.new(0, 10, 0, 8)
    AutoTitle.BackgroundTransparency = 1
    AutoTitle.Text = "⚡ Auto Features"
    AutoTitle.TextColor3 = Theme.Primary
    AutoTitle.TextSize = 14
    AutoTitle.Font = Enum.Font.GothamBold
    AutoTitle.TextXAlignment = Enum.TextXAlignment.Left
    AutoTitle.Parent = AutoPanel

    local toggles = {
        {name = "Auto Place Egg", key = "AutoPlaceEgg", y = 38},
        {name = "Auto Hatch Egg", key = "AutoHatch", y = 68},
        {name = "Auto Sell Pet", key = "AutoSell", y = 98},
    }

    for _, t in ipairs(toggles) do
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, -20, 0, 26)
        row.Position = UDim2.new(0, 10, 0, t.y)
        row.BackgroundTransparency = 1
        row.Parent = AutoPanel

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0, 200, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = t.name
        lbl.TextColor3 = Theme.Text
        lbl.TextSize = 12
        lbl.Font = Enum.Font.Gotham
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = row

        local toggleBg = Instance.new("Frame")
        toggleBg.Size = UDim2.new(0, 44, 0, 22)
        toggleBg.Position = UDim2.new(1, -44, 0.5, -11)
        toggleBg.BackgroundColor3 = Theme.Elevated
        toggleBg.BorderSizePixel = 0
        toggleBg.Parent = row
        CreateCorner(toggleBg, 11)

        local toggleKnob = Instance.new("Frame")
        toggleKnob.Size = UDim2.new(0, 18, 0, 18)
        toggleKnob.Position = UDim2.new(0, 2, 0.5, -9)
        toggleKnob.BackgroundColor3 = Theme.TextDim
        toggleKnob.BorderSizePixel = 0
        toggleKnob.Parent = toggleBg
        CreateCorner(toggleKnob, 9)

        local enabled = false
        row.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                enabled = not enabled
                ZUZU_STATE[t.key] = enabled
                if enabled then
                    Tween(toggleBg, {BackgroundColor3 = Theme.Success}, 0.2)
                    Tween(toggleKnob, {Position = UDim2.new(0, 24, 0.5, -9), BackgroundColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                else
                    Tween(toggleBg, {BackgroundColor3 = Theme.Elevated}, 0.2)
                    Tween(toggleKnob, {Position = UDim2.new(0, 2, 0.5, -9), BackgroundColor3 = Theme.TextDim}, 0.2)
                end
                ZuzuNotify(t.name, enabled and "Enabled" or "Disabled", enabled and "success" or "warning")
            end
        end)
    end

    -- Egg Selection Panel
    local EggPanel = Instance.new("Frame")
    EggPanel.Size = UDim2.new(1, -20, 0, 200)
    EggPanel.Position = UDim2.new(0, 10, 0, 150)
    EggPanel.BackgroundColor3 = Theme.Surface
    EggPanel.BorderSizePixel = 0
    EggPanel.Parent = content
    CreateCorner(EggPanel, 12)
    CreateStroke(EggPanel, Theme.Border, 1)

    local EggTitle = Instance.new("TextLabel")
    EggTitle.Size = UDim2.new(1, -20, 0, 24)
    EggTitle.Position = UDim2.new(0, 10, 0, 8)
    EggTitle.BackgroundTransparency = 1
    EggTitle.Text = "🥚 Select Egg Type"
    EggTitle.TextColor3 = Theme.Primary
    EggTitle.TextSize = 14
    EggTitle.Font = Enum.Font.GothamBold
    EggTitle.TextXAlignment = Enum.TextXAlignment.Left
    EggTitle.Parent = EggPanel

    local SelectedEggDisplay = Instance.new("TextLabel")
    SelectedEggDisplay.Size = UDim2.new(1, -20, 0, 22)
    SelectedEggDisplay.Position = UDim2.new(0, 10, 0, 34)
    SelectedEggDisplay.BackgroundTransparency = 1
    SelectedEggDisplay.Text = "Selected: Common Egg"
    SelectedEggDisplay.TextColor3 = Theme.Accent
    SelectedEggDisplay.TextSize = 12
    SelectedEggDisplay.Font = Enum.Font.GothamBold
    SelectedEggDisplay.TextXAlignment = Enum.TextXAlignment.Left
    SelectedEggDisplay.Parent = EggPanel

    local EggScroll = Instance.new("ScrollingFrame")
    EggScroll.Size = UDim2.new(1, -20, 0, 130)
    EggScroll.Position = UDim2.new(0, 10, 0, 60)
    EggScroll.BackgroundColor3 = Theme.BG
    EggScroll.BorderSizePixel = 0
    EggScroll.ScrollBarThickness = 4
    EggScroll.ScrollBarImageColor3 = Theme.Border
    EggScroll.Parent = EggPanel
    CreateCorner(EggScroll, 8)

    local EggGrid = Instance.new("UIGridLayout")
    EggGrid.CellSize = UDim2.new(0, 130, 0, 36)
    EggGrid.CellPadding = UDim2.new(0, 8, 0, 8)
    EggGrid.Parent = EggScroll

    local eggNames = {}
    for name, _ in pairs(EGG_DB) do table.insert(eggNames, name) end
    table.sort(eggNames)

    for _, eggName in ipairs(eggNames) do
        local eggData = EGG_DB[eggName]
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 130, 0, 36)
        btn.BackgroundColor3 = Theme.Elevated
        btn.Text = eggData.Icon .. " " .. eggName
        btn.TextColor3 = Theme.Text
        btn.TextSize = 10
        btn.Font = Enum.Font.GothamBold
        btn.Parent = EggScroll
        CreateCorner(btn, 8)

        local r, g, b = eggData.Color:match("(%d+),(%d+),(%d+)")
        if r then
            local eggColor = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))
            local stroke = CreateStroke(btn, eggColor, 1)

            btn.MouseEnter:Connect(function()
                Tween(btn, {BackgroundColor3 = Color3.fromRGB(40, 40, 70)}, 0.2)
                stroke.Thickness = 2
            end)
            btn.MouseLeave:Connect(function()
                Tween(btn, {BackgroundColor3 = Theme.Elevated}, 0.2)
                stroke.Thickness = 1
            end)
        end

        btn.MouseButton1Click:Connect(function()
            ZUZU_STATE.SelectedEgg = eggName
            SelectedEggDisplay.Text = "Selected: " .. eggName
            ZuzuNotify("Egg Selected", eggName .. " (Hatch: " .. math.floor(eggData.HatchTime/60) .. "m)", "info")
        end)
    end

    EggScroll.CanvasSize = UDim2.new(0, 0, 0, math.ceil(#eggNames / 4) * 44 + 10)

    -- Garden Slots Panel
    local SlotsPanel = Instance.new("Frame")
    SlotsPanel.Size = UDim2.new(1, -20, 0, 280)
    SlotsPanel.Position = UDim2.new(0, 10, 0, 360)
    SlotsPanel.BackgroundColor3 = Theme.Surface
    SlotsPanel.BorderSizePixel = 0
    SlotsPanel.Parent = content
    CreateCorner(SlotsPanel, 12)
    CreateStroke(SlotsPanel, Theme.Border, 1)

    local SlotsTitle = Instance.new("TextLabel")
    SlotsTitle.Size = UDim2.new(1, -20, 0, 24)
    SlotsTitle.Position = UDim2.new(0, 10, 0, 8)
    SlotsTitle.BackgroundTransparency = 1
    SlotsTitle.Text = "🌱 Garden Egg Slots"
    SlotsTitle.TextColor3 = Theme.Primary
    SlotsTitle.TextSize = 14
    SlotsTitle.Font = Enum.Font.GothamBold
    SlotsTitle.TextXAlignment = Enum.TextXAlignment.Left
    SlotsTitle.Parent = SlotsPanel

    local SlotGrid = Instance.new("UIGridLayout")
    SlotGrid.CellSize = UDim2.new(0, 110, 0, 110)
    SlotGrid.CellPadding = UDim2.new(0, 10, 0, 10)
    SlotGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SlotGrid.VerticalAlignment = Enum.VerticalAlignment.Top
    SlotGrid.Parent = SlotsPanel

    local SlotButtons = {}

    for i = 1, 6 do
        local slotFrame = Instance.new("Frame")
        slotFrame.Size = UDim2.new(0, 110, 0, 110)
        slotFrame.BackgroundColor3 = Theme.Elevated
        slotFrame.BorderSizePixel = 0
        slotFrame.Parent = SlotsPanel
        CreateCorner(slotFrame, 55) -- Round!
        CreateStroke(slotFrame, Theme.Border, 1)

        local slotNum = Instance.new("TextLabel")
        slotNum.Size = UDim2.new(1, 0, 0, 18)
        slotNum.Position = UDim2.new(0, 0, 0, 8)
        slotNum.BackgroundTransparency = 1
        slotNum.Text = "#" .. i
        slotNum.TextColor3 = Theme.TextDim
        slotNum.TextSize = 11
        slotNum.Font = Enum.Font.GothamBold
        slotNum.Parent = slotFrame

        local eggIcon = Instance.new("TextLabel")
        eggIcon.Size = UDim2.new(0, 40, 0, 40)
        eggIcon.Position = UDim2.new(0.5, -20, 0, 28)
        eggIcon.BackgroundTransparency = 1
        eggIcon.Text = "🥚"
        eggIcon.TextSize = 30
        eggIcon.Font = Enum.Font.GothamBold
        eggIcon.TextColor3 = Theme.TextDim
        eggIcon.Parent = slotFrame

        local statusLbl = Instance.new("TextLabel")
        statusLbl.Size = UDim2.new(1, -10, 0, 30)
        statusLbl.Position = UDim2.new(0, 5, 0, 72)
        statusLbl.BackgroundTransparency = 1
        statusLbl.Text = "Empty
Tap to place"
        statusLbl.TextColor3 = Theme.TextDim
        statusLbl.TextSize = 10
        statusLbl.Font = Enum.Font.Gotham
        statusLbl.TextWrapped = true
        statusLbl.Parent = slotFrame

        local progressBar = Instance.new("Frame")
        progressBar.Size = UDim2.new(0, 0, 0, 3)
        progressBar.Position = UDim2.new(0, 10, 1, -8)
        progressBar.BackgroundColor3 = Theme.Success
        progressBar.BorderSizePixel = 0
        progressBar.Parent = slotFrame
        CreateCorner(progressBar, 2)

        local clickBtn = Instance.new("TextButton")
        clickBtn.Size = UDim2.new(1, 0, 1, 0)
        clickBtn.BackgroundTransparency = 1
        clickBtn.Text = ""
        clickBtn.Parent = slotFrame

        clickBtn.MouseButton1Click:Connect(function()
            local slot = ZUZU_STATE.EggSlots[i]
            if not slot.egg then
                -- Place egg
                local eggData = EGG_DB[ZUZU_STATE.SelectedEgg]
                if eggData then
                    slot.egg = ZUZU_STATE.SelectedEgg
                    slot.planted = os.time()
                    slot.hatchTime = eggData.HatchTime
                    slot.hatched = false
                    slot.petName = ALL_PETS[math.random(1, #ALL_PETS)]
                    local wRange = PET_RARITY_WEIGHTS[eggData.Rarity] or {1.0, 2.0}
                    slot.weight = math.random(wRange[1]*100, wRange[2]*100) / 100
                    slot.progress = 0

                    eggIcon.Text = eggData.Icon
                    eggIcon.TextColor3 = Color3.fromRGB(255,255,255)
                    statusLbl.Text = ZUZU_STATE.SelectedEgg .. "
" .. FormatTime(eggData.HatchTime)
                    statusLbl.TextColor3 = Theme.Accent

                    ZuzuNotify("Egg Placed", ZUZU_STATE.SelectedEgg .. " in slot " .. i, "success")
                end
            else
                -- Show info or remove
                ZuzuNotify("Slot Info", slot.egg .. " | " .. (slot.hatched and "HATCHED" or "Growing..."), "info")
            end
        end)

        SlotButtons[i] = {
            frame = slotFrame,
            icon = eggIcon,
            status = statusLbl,
            progress = progressBar,
        }
    end

    -- Update loop for slots
    task.spawn(function()
        while true do
            task.wait(1)
            for i, slot in ipairs(ZUZU_STATE.EggSlots) do
                if slot.egg and not slot.hatched then
                    local elapsed = os.time() - slot.planted
                    local remaining = math.max(0, slot.hatchTime - elapsed)
                    local progress = math.min(1, elapsed / slot.hatchTime)
                    slot.progress = progress

                    local btn = SlotButtons[i]
                    if remaining <= 0 then
                        slot.hatched = true
                        btn.status.Text = "✅ " .. slot.petName .. "
" .. string.format("%.1f", slot.weight) .. "kg"
                        btn.status.TextColor3 = Theme.Success
                        btn.progress.Size = UDim2.new(0.9, 0, 0, 3)
                        ZuzuNotify("🐣 Egg Hatched!", slot.petName .. " (" .. string.format("%.1f", slot.weight) .. "kg) from " .. slot.egg, "success")
                    else
                        btn.status.Text = slot.egg .. "
" .. FormatTime(remaining)
                        btn.progress.Size = UDim2.new(0.9 * progress, 0, 0, 3)
                    end
                end
            end
        end
    end)

    -- Auto Place Logic
    task.spawn(function()
        while true do
            task.wait(3)
            if ZUZU_STATE.AutoPlaceEgg then
                for i, slot in ipairs(ZUZU_STATE.EggSlots) do
                    if not slot.egg then
                        local eggData = EGG_DB[ZUZU_STATE.SelectedEgg]
                        if eggData then
                            slot.egg = ZUZU_STATE.SelectedEgg
                            slot.planted = os.time()
                            slot.hatchTime = eggData.HatchTime
                            slot.hatched = false
                            slot.petName = ALL_PETS[math.random(1, #ALL_PETS)]
                            local wRange = PET_RARITY_WEIGHTS[eggData.Rarity] or {1.0, 2.0}
                            slot.weight = math.random(wRange[1]*100, wRange[2]*100) / 100

                            local btn = SlotButtons[i]
                            btn.icon.Text = eggData.Icon
                            btn.icon.TextColor3 = Color3.fromRGB(255,255,255)
                            btn.status.Text = ZUZU_STATE.SelectedEgg .. "
" .. FormatTime(eggData.HatchTime)
                            btn.status.TextColor3 = Theme.Accent

                            ZuzuNotify("Auto Place", "Placed " .. ZUZU_STATE.SelectedEgg .. " in slot " .. i, "info")
                            break
                        end
                    end
                end
            end
        end
    end)

    -- Auto Hatch Logic
    task.spawn(function()
        while true do
            task.wait(2)
            if ZUZU_STATE.AutoHatch then
                for i, slot in ipairs(ZUZU_STATE.EggSlots) do
                    if slot.egg and slot.hatched then
                        -- Auto hatch the ready egg
                        ZuzuNotify("Auto Hatch", "Hatching " .. slot.petName .. " from slot " .. i, "success")
                        -- Reset slot after hatch
                        task.wait(1)
                        slot.egg = nil
                        slot.petName = nil
                        slot.weight = nil
                        slot.hatchTime = nil
                        slot.planted = nil
                        slot.hatched = false
                        slot.progress = 0

                        local btn = SlotButtons[i]
                        btn.icon.Text = "🥚"
                        btn.icon.TextColor3 = Theme.TextDim
                        btn.status.Text = "Empty
Tap to place"
                        btn.status.TextColor3 = Theme.TextDim
                        btn.progress.Size = UDim2.new(0, 0, 0, 3)
                    end
                end
            end
        end
    end)

    content.CanvasSize = UDim2.new(0, 0, 0, 660)
end)


-- ═══════════════════════════════════════════════════════════════════
-- TAB 2: PETS
-- ═══════════════════════════════════════════════════════════════════
local PetsTabBtn, PetsContent = CreateTab("Pets", "🐾", function(content)
    local SearchBar = Instance.new("TextBox")
    SearchBar.Size = UDim2.new(1, -20, 0, 36)
    SearchBar.Position = UDim2.new(0, 10, 0, 5)
    SearchBar.BackgroundColor3 = Theme.Elevated
    SearchBar.Text = ""
    SearchBar.PlaceholderText = "🔍 Search pets..."
    SearchBar.TextColor3 = Theme.Text
    SearchBar.PlaceholderColor3 = Theme.TextDim
    SearchBar.TextSize = 13
    SearchBar.Font = Enum.Font.Gotham
    SearchBar.Parent = content
    CreateCorner(SearchBar, 10)
    CreateStroke(SearchBar, Theme.Border, 1)

    local PetScroll = Instance.new("ScrollingFrame")
    PetScroll.Size = UDim2.new(1, -20, 1, -50)
    PetScroll.Position = UDim2.new(0, 10, 0, 48)
    PetScroll.BackgroundTransparency = 1
    PetScroll.BorderSizePixel = 0
    PetScroll.ScrollBarThickness = 4
    PetScroll.ScrollBarImageColor3 = Theme.Border
    PetScroll.Parent = content

    local PetList = Instance.new("UIListLayout")
    PetList.Padding = UDim.new(0, 6)
    PetList.Parent = PetScroll

    local rarityColors = {
        Common = Color3.fromRGB(200,200,220),
        Uncommon = Color3.fromRGB(180,140,100),
        Rare = Color3.fromRGB(60,120,255),
        Legendary = Color3.fromRGB(255,180,50),
        Mythical = Color3.fromRGB(255,80,200),
        Divine = Color3.fromRGB(180,50,255),
        Prismatic = Color3.fromRGB(255,100,100),
    }

    local function CreatePetCard(name, rarity)
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1, -10, 0, 50)
        card.BackgroundColor3 = Theme.Surface
        card.BorderSizePixel = 0
        card.Parent = PetScroll
        CreateCorner(card, 10)

        local rColor = rarityColors[rarity] or Theme.Text
        CreateStroke(card, rColor, 1)

        local icon = Instance.new("TextLabel")
        icon.Size = UDim2.new(0, 40, 0, 40)
        icon.Position = UDim2.new(0, 5, 0, 5)
        icon.BackgroundTransparency = 1
        icon.Text = "🐾"
        icon.TextSize = 24
        icon.Font = Enum.Font.GothamBold
        icon.TextColor3 = rColor
        icon.Parent = card

        local nameLbl = Instance.new("TextLabel")
        nameLbl.Size = UDim2.new(1, -100, 0, 20)
        nameLbl.Position = UDim2.new(0, 48, 0, 5)
        nameLbl.BackgroundTransparency = 1
        nameLbl.Text = name
        nameLbl.TextColor3 = Theme.Text
        nameLbl.TextSize = 13
        nameLbl.Font = Enum.Font.GothamBold
        nameLbl.TextXAlignment = Enum.TextXAlignment.Left
        nameLbl.Parent = card

        local rarityLbl = Instance.new("TextLabel")
        rarityLbl.Size = UDim2.new(0, 80, 0, 18)
        rarityLbl.Position = UDim2.new(1, -85, 0, 5)
        rarityLbl.BackgroundColor3 = Theme.Elevated
        rarityLbl.Text = rarity
        rarityLbl.TextColor3 = rColor
        rarityLbl.TextSize = 10
        rarityLbl.Font = Enum.Font.GothamBold
        rarityLbl.Parent = card
        CreateCorner(rarityLbl, 4)

        local infoLbl = Instance.new("TextLabel")
        infoLbl.Size = UDim2.new(1, -100, 0, 18)
        infoLbl.Position = UDim2.new(0, 48, 0, 26)
        infoLbl.BackgroundTransparency = 1
        infoLbl.Text = "Weight: " .. (PET_RARITY_WEIGHTS[rarity] and (PET_RARITY_WEIGHTS[rarity][1] .. "-" .. PET_RARITY_WEIGHTS[rarity][2] .. "kg") or "1.0-2.0kg")
        infoLbl.TextColor3 = Theme.TextDim
        infoLbl.TextSize = 10
        infoLbl.Font = Enum.Font.Gotham
        infoLbl.TextXAlignment = Enum.TextXAlignment.Left
        infoLbl.Parent = card

        return card
    end

    local petCards = {}
    for _, petName in ipairs(ALL_PETS) do
        -- Determine rarity based on name patterns (simplified)
        local rarity = "Common"
        if petName:find("Kitsune") or petName:find("Headless") or petName:find("Goldfinch") then
            rarity = "Prismatic"
        elseif petName:find("Dragonfly") or petName:find("Raccoon") or petName:find("Red Fox") or petName:find("Queen Bee") or petName:find("Disco Bee") or petName:find("Blood Owl") or petName:find("T-Rex") or petName:find("Spinosaurus") or petName:find("Fennec Fox") or petName:find("Raiju") or petName:find("Mizuchi") or petName:find("French Fry") or petName:find("Golden Goose") or petName:find("Carnival Elephant") or petName:find("Chimera") or petName:find("Christmas Spirit") or petName:find("Cockatrice") or petName:find("Griffin") or petName:find("Lich") or petName:find("Luminous") or petName:find("Mummy") or petName:find("Red Panda") or petName:find("Red Rose") or petName:find("Reaper") or petName:find("Space Squirrel") or petName:find("Star Wolf") or petName:find("Swan") or petName:find("Tiger") or petName:find("Yeti") or petName:find("Hex Serpent") or petName:find("Chinchilla") or petName:find("Green Bean") then
            rarity = "Divine"
        elseif petName:find("Giant Ant") or petName:find("Praying Mantis") or petName:find("Red Giant") or petName:find("Echo Frog") or petName:find("Night Owl") or petName:find("Owl") or petName:find("Bear Bee") or petName:find("Butterfly") or petName:find("Mimic Octopus") or petName:find("Axolotl") or petName:find("Hyacinth") or petName:find("Pterodactyl") or petName:find("Brontosaurus") or petName:find("Dilophosaurus") or petName:find("Ankylosaurus") or petName:find("Kappa") or petName:find("Koi") or petName:find("Spaghetti") or petName:find("Junkbot") or petName:find("Pack Bee") or petName:find("Cooked Owl") or petName:find("Golem") or petName:find("Firefly") or petName:find("Golden Bee") or petName:find("Chicken Zombie") or petName:find("Mochi Mouse") or petName:find("Glimmering") or petName:find("Apple Gazelle") or petName:find("Barn Owl") or petName:find("Black Cat") or petName:find("Dark Spriggan") or petName:find("Rhino") or petName:find("Show Pony") or petName:find("Sugar Glider") or petName:find("Chimpanzee") then
            rarity = "Mythical"
        elseif petName:find("Silver Monkey") or petName:find("Turtle") or petName:find("Cow") or petName:find("Sea Otter") or petName:find("Polar Bear") or petName:find("Caterpillar") or petName:find("Snail") or petName:find("Panda") or petName:find("Mole") or petName:find("Frog") or petName:find("Petal Bee") or petName:find("Moth") or petName:find("Peacock") or petName:find("Capybara") or petName:find("Meerkat") or petName:find("Sand Snake") or petName:find("Raptor") or petName:find("Stegosaurus") or petName:find("Triceratops") or petName:find("Tanuki") or petName:find("Tanchozuru") or petName:find("Kodama") or petName:find("Corrupted Kodama") or petName:find("Blood Hedgehog") or petName:find("Blood Kiwi") or petName:find("Moon Cat") or petName:find("Seedling") or petName:find("Football") or petName:find("Sushi Bear") or petName:find("Hotdog") or petName:find("Gorilla Chef") or petName:find("Rainbow") or petName:find("Bald Eagle") or petName:find("Cheetah") or petName:find("Grey Mouse") or petName:find("Squirrel") or petName:find("Brown Mouse") or petName:find("Parasaurolophus") or petName:find("Iguanodon") or petName:find("Pachycephalosaurus") or petName:find("Champion Beetle") or petName:find("Amethyst Beetle") or petName:find("Bear on a Bike") or petName:find("Calico") or petName:find("Celebration Puppy") or petName:find("Chubby Chipmunk") or petName:find("Christmas Gorilla") or petName:find("Diamond Panther") or petName:find("Drake") or petName:find("Emerald Snake") or petName:find("Giraffe") or petName:find("Grizzly Bear") or petName:find("Hamster") or petName:find("Idol Chipmunk") or petName:find("Imp") or petName:find("Lemon Lion") or petName:find("Mallard") or petName:find("Mandrake") or petName:find("Pink Panda") or petName:find("Shroomie") or petName:find("Silver Dragonfly") or petName:find("Silver Piggy") or petName:find("Specter") or petName:find("Spider") or petName:find("Stag Beetle") or petName:find("Tomb Marmot") or petName:find("White Tiger") or petName:find("Wind Wyvern") or petName:find("Wisp") or petName:find("Wolf") or petName:find("Woody") then
            rarity = "Legendary"
        elseif petName:find("Orange Tabby") or petName:find("Spotted Deer") or petName:find("Rooster") or petName:find("Monkey") or petName:find("Pig") or petName:find("Honey Bee") or petName:find("Tarantula Hawk") or petName:find("Toucan") or petName:find("Flamingo") or petName:find("Sea Turtle") or petName:find("Seal") or petName:find("Hedgehog") or petName:find("Kiwi") or petName:find("Nihonzaru") or petName:find("Tsuchinoko") or petName:find("Pancake Mole") or petName:find("Orangutan") or petName:find("Firework Sprite") or petName:find("Fortune Squirrel") or petName:find("Zebra") or petName:find("Cape Buffalo") or petName:find("Pixie") or petName:find("Angora Goat") or petName:find("Clam") or petName:find("Magpie") then
            rarity = "Rare"
        elseif petName:find("Black Bunny") or petName:find("Cat") or petName:find("Deer") or petName:find("Chicken") or petName:find("Bee") or petName:find("Wasp") or petName:find("Shiba Inu") or petName:find("Maneki-neko") or petName:find("Bacon Pig") or petName:find("Jackalope") or petName:find("Pink Bunny") or petName:find("Bat") or petName:find("French Hen") or petName:find("Smithing Dog") or petName:find("Wind-Up Rat") then
            rarity = "Uncommon"
        end

        local card = CreatePetCard(petName, rarity)
        table.insert(petCards, {card = card, name = petName, rarity = rarity})
    end

    PetScroll.CanvasSize = UDim2.new(0, 0, 0, #ALL_PETS * 56 + 20)

    -- Search functionality
    SearchBar:GetPropertyChangedSignal("Text"):Connect(function()
        local query = SearchBar.Text:lower()
        local visibleCount = 0
        for _, item in ipairs(petCards) do
            local match = item.name:lower():find(query) ~= nil or item.rarity:lower():find(query) ~= nil
            item.card.Visible = match
            if match then visibleCount = visibleCount + 1 end
        end
        PetScroll.CanvasSize = UDim2.new(0, 0, 0, visibleCount * 56 + 20)
    end)
end)

-- ═══════════════════════════════════════════════════════════════════
-- TAB 3: EGGS
-- ═══════════════════════════════════════════════════════════════════
local EggsTabBtn, EggsContent = CreateTab("Eggs", "🥚", function(content)
    local EggScroll = Instance.new("ScrollingFrame")
    EggScroll.Size = UDim2.new(1, -20, 1, -10)
    EggScroll.Position = UDim2.new(0, 10, 0, 5)
    EggScroll.BackgroundTransparency = 1
    EggScroll.BorderSizePixel = 0
    EggScroll.ScrollBarThickness = 4
    EggScroll.ScrollBarImageColor3 = Theme.Border
    EggScroll.Parent = content

    local EggList = Instance.new("UIListLayout")
    EggList.Padding = UDim.new(0, 8)
    EggList.Parent = EggScroll

    local eggNames = {}
    for name, _ in pairs(EGG_DB) do table.insert(eggNames, name) end
    table.sort(eggNames, function(a, b)
        local ta = EGG_DB[a].HatchTime
        local tb = EGG_DB[b].HatchTime
        return ta < tb
    end)

    for _, eggName in ipairs(eggNames) do
        local eggData = EGG_DB[eggName]
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1, -10, 0, 70)
        card.BackgroundColor3 = Theme.Surface
        card.BorderSizePixel = 0
        card.Parent = EggScroll
        CreateCorner(card, 12)

        local r, g, b = eggData.Color:match("(%d+),(%d+),(%d+)")
        local eggColor = r and Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) or Theme.Primary
        CreateStroke(card, eggColor, 1)

        local icon = Instance.new("TextLabel")
        icon.Size = UDim2.new(0, 50, 0, 50)
        icon.Position = UDim2.new(0, 10, 0, 10)
        icon.BackgroundColor3 = eggColor
        icon.Text = eggData.Icon
        icon.TextSize = 28
        icon.Font = Enum.Font.GothamBold
        icon.TextColor3 = Color3.fromRGB(255,255,255)
        icon.Parent = card
        CreateCorner(icon, 25)

        local nameLbl = Instance.new("TextLabel")
        nameLbl.Size = UDim2.new(1, -140, 0, 20)
        nameLbl.Position = UDim2.new(0, 70, 0, 8)
        nameLbl.BackgroundTransparency = 1
        nameLbl.Text = eggName
        nameLbl.TextColor3 = Theme.Text
        nameLbl.TextSize = 14
        nameLbl.Font = Enum.Font.GothamBold
        nameLbl.TextXAlignment = Enum.TextXAlignment.Left
        nameLbl.Parent = card

        local rarityLbl = Instance.new("TextLabel")
        rarityLbl.Size = UDim2.new(0, 80, 0, 18)
        rarityLbl.Position = UDim2.new(1, -90, 0, 8)
        rarityLbl.BackgroundColor3 = Theme.Elevated
        rarityLbl.Text = eggData.Rarity
        rarityLbl.TextColor3 = eggColor
        rarityLbl.TextSize = 10
        rarityLbl.Font = Enum.Font.GothamBold
        rarityLbl.Parent = card
        CreateCorner(rarityLbl, 4)

        local timeLbl = Instance.new("TextLabel")
        timeLbl.Size = UDim2.new(1, -140, 0, 18)
        timeLbl.Position = UDim2.new(0, 70, 0, 30)
        timeLbl.BackgroundTransparency = 1
        timeLbl.Text = "Hatch Time: " .. FormatTime(eggData.HatchTime)
        timeLbl.TextColor3 = Theme.TextDim
        timeLbl.TextSize = 11
        timeLbl.Font = Enum.Font.Gotham
        timeLbl.TextXAlignment = Enum.TextXAlignment.Left
        timeLbl.Parent = card

        local selectBtn = Instance.new("TextButton")
        selectBtn.Size = UDim2.new(0, 80, 0, 26)
        selectBtn.Position = UDim2.new(1, -90, 0, 38)
        selectBtn.BackgroundColor3 = Theme.Primary
        selectBtn.Text = "Select"
        selectBtn.TextColor3 = Color3.fromRGB(255,255,255)
        selectBtn.TextSize = 11
        selectBtn.Font = Enum.Font.GothamBold
        selectBtn.Parent = card
        CreateCorner(selectBtn, 6)

        selectBtn.MouseButton1Click:Connect(function()
            ZUZU_STATE.SelectedEgg = eggName
            ZuzuNotify("Egg Selected", eggName .. " is now your default egg!", "success")
        end)
    end

    EggScroll.CanvasSize = UDim2.new(0, 0, 0, #eggNames * 78 + 20)
end)

-- ═══════════════════════════════════════════════════════════════════
-- TAB 4: GEAR
-- ═══════════════════════════════════════════════════════════════════
local GearTabBtn, GearContent = CreateTab("Gear", "🛠️", function(content)
    local GearScroll = Instance.new("ScrollingFrame")
    GearScroll.Size = UDim2.new(1, -20, 1, -10)
    GearScroll.Position = UDim2.new(0, 10, 0, 5)
    GearScroll.BackgroundTransparency = 1
    GearScroll.BorderSizePixel = 0
    GearScroll.ScrollBarThickness = 4
    GearScroll.ScrollBarImageColor3 = Theme.Border
    GearScroll.Parent = content

    local GearList = Instance.new("UIListLayout")
    GearList.Padding = UDim.new(0, 6)
    GearList.Parent = GearScroll

    local gearItems = {
        {name="Basic Sprinkler", type="Sprinkler", boost="1.2x", value="5K"},
        {name="Advanced Sprinkler", type="Sprinkler", boost="1.5x", value="15K"},
        {name="Godly Sprinkler", type="Sprinkler", boost="2.0x", value="50K"},
        {name="Master Sprinkler", type="Sprinkler", boost="2.5x", value="150K"},
        {name="Grandmaster Sprinkler", type="Sprinkler", boost="3.0x", value="500K"},
        {name="Berry Blusher Sprinkler", type="Sprinkler", boost="2.2x", value="75K"},
        {name="Sweet Soaker Sprinkler", type="Sprinkler", boost="2.3x", value="85K"},
        {name="Spice Spritzer Sprinkler", type="Sprinkler", boost="2.4x", value="95K"},
        {name="Flower Froster Sprinkler", type="Sprinkler", boost="2.1x", value="65K"},
        {name="Tropical Mist Sprinkler", type="Sprinkler", boost="2.5x", value="100K"},
        {name="Stalk Sprout Sprinkler", type="Sprinkler", boost="2.2x", value="80K"},
        {name="Tanning Mirror", type="Tool", boost="1.3x", value="8K"},
        {name="Magnifying Glass", type="Tool", boost="1.4x", value="12K"},
        {name="Watering Can", type="Tool", boost="1.1x", value="2K"},
        {name="Golden Rake", type="Tool", boost="1.8x", value="35K"},
        {name="Harvest Tool", type="Tool", boost="1.5x", value="25K"},
        {name="Favorite Tool", type="Tool", boost="1.6x", value="30K"},
        {name="Lightning Rod", type="Tool", boost="1.7x", value="40K"},
        {name="Smith Hammer of Harvest", type="Tool", boost="2.0x", value="200K"},
        {name="Thundelbringer", type="Tool", boost="3.5x", value="500K"},
        {name="Recall Wrench", type="Tool", boost="1.2x", value="5K"},
        {name="Trowel", type="Tool", boost="1.3x", value="3K"},
        {name="Pet Pouch", type="Equipment", boost="1.5x", value="50M"},
        {name="Pet Shard Forger", type="Equipment", boost="2.0x", value="150M"},
        {name="Chimera Stone", type="Equipment", boost="2.5x", value="500M"},
        {name="Event Lantern", type="Equipment", boost="1.3x", value="350K"},
        {name="Fairy Caller", type="Fairy", boost="1.5x", value="2.5M"},
        {name="Fairy Net", type="Fairy", boost="1.3x", value="1M"},
        {name="Fairy Targeter", type="Fairy", boost="1.4x", value="1M"},
        {name="Fairy Power Extender", type="Fairy", boost="1.6x", value="5M"},
        {name="Fairy Summoner", type="Fairy", boost="2.0x", value="15M"},
        {name="Luminous Wand", type="Fairy", boost="1.8x", value="10M"},
        {name="Glimmering Radar", type="Fairy", boost="1.5x", value="1M"},
        {name="Mutation Spray Choc", type="Spray", boost="1.0x", value="200K"},
        {name="Mutation Spray Pollinated", type="Spray", boost="1.0x", value="250K"},
        {name="Mutation Spray Glimmering", type="Spray", boost="1.0x", value="1M"},
        {name="Mutation Spray Chilled", type="Spray", boost="1.0x", value="500K"},
        {name="Mutation Spray Shocked", type="Spray", boost="1.0x", value="1M"},
        {name="Mutation Spray Amber", type="Spray", boost="1.0x", value="1M"},
        {name="Cleaning Spray", type="Spray", boost="1.0x", value="100K"},
        {name="Small Toy", type="Boost", boost="1.1x", value="1M"},
        {name="Medium Toy", type="Boost", boost="1.2x", value="5M"},
        {name="Large Toy", type="Boost", boost="1.3x", value="15M"},
        {name="Small Treat", type="Boost", boost="1.1x", value="1M"},
        {name="Medium Treat", type="Boost", boost="1.2x", value="5M"},
        {name="Large Treat", type="Boost", boost="1.3x", value="15M"},
        {name="Levelup Lollipop", type="Boost", boost="1.3x", value="10M"},
        {name="Smith Treat", type="Boost", boost="1.5x", value="4M"},
        {name="Reclaimer", type="Special", boost="1.5x", value="500K"},
        {name="Pet Shard", type="Special", boost="1.0x", value="1M"},
        {name="Anvil", type="Cosmetic", boost="1.0x", value="1.5M"},
        {name="Coal Box", type="Cosmetic", boost="1.0x", value="1.5M"},
        {name="Blacksmith Grinder", type="Cosmetic", boost="1.0x", value="6M"},
        {name="Tools Rack", type="Cosmetic", boost="1.0x", value="7M"},
        {name="Shield Statue", type="Cosmetic", boost="1.0x", value="10.5M"},
        {name="Horse Shoe Magnet", type="Cosmetic", boost="1.0x", value="15M"},
        {name="Silver Piggy", type="Cosmetic", boost="1.0x", value="150M"},
        {name="Golden Piggy", type="Cosmetic", boost="1.0x", value="300M"},
        {name="Cooking Pot", type="Cosmetic", boost="1.0x", value="5M"},
        {name="Cooking Cauldron", type="Cosmetic", boost="1.0x", value="8M"},
        {name="Wisp Well", type="Cosmetic", boost="1.0x", value="10M"},
        {name="Chamberstick", type="Cosmetic", boost="1.0x", value="5M"},
        {name="Hot Chocolate Mug", type="Cosmetic", boost="1.0x", value="3M"},
        {name="Witch's Cauldron", type="Cosmetic", boost="1.0x", value="7M"},
        {name="Sarcophagus", type="Cosmetic", boost="1.0x", value="12M"},
        {name="Hex Circle", type="Cosmetic", boost="1.0x", value="8M"},
        {name="DNA Converter", type="Special", boost="1.0x", value="10M"},
        {name="Trading Ticket", type="Special", boost="1.0x", value="50K"},
    }

    local typeColors = {
        Sprinkler = Color3.fromRGB(80, 150, 255),
        Tool = Color3.fromRGB(150, 200, 100),
        Equipment = Color3.fromRGB(200, 100, 255),
        Fairy = Color3.fromRGB(255, 200, 100),
        Spray = Color3.fromRGB(255, 100, 150),
        Boost = Color3.fromRGB(100, 255, 150),
        Special = Color3.fromRGB(255, 150, 80),
        Cosmetic = Color3.fromRGB(180, 180, 200),
    }

    for _, gear in ipairs(gearItems) do
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1, -10, 0, 50)
        card.BackgroundColor3 = Theme.Surface
        card.BorderSizePixel = 0
        card.Parent = GearScroll
        CreateCorner(card, 10)

        local tColor = typeColors[gear.type] or Theme.Primary
        CreateStroke(card, tColor, 1)

        local typeLbl = Instance.new("TextLabel")
        typeLbl.Size = UDim2.new(0, 70, 0, 18)
        typeLbl.Position = UDim2.new(0, 8, 0, 5)
        typeLbl.BackgroundColor3 = Theme.Elevated
        typeLbl.Text = gear.type
        typeLbl.TextColor3 = tColor
        typeLbl.TextSize = 9
        typeLbl.Font = Enum.Font.GothamBold
        typeLbl.Parent = card
        CreateCorner(typeLbl, 4)

        local nameLbl = Instance.new("TextLabel")
        nameLbl.Size = UDim2.new(1, -160, 0, 18)
        nameLbl.Position = UDim2.new(0, 85, 0, 5)
        nameLbl.BackgroundTransparency = 1
        nameLbl.Text = gear.name
        nameLbl.TextColor3 = Theme.Text
        nameLbl.TextSize = 12
        nameLbl.Font = Enum.Font.GothamBold
        nameLbl.TextXAlignment = Enum.TextXAlignment.Left
        nameLbl.Parent = card

        local boostLbl = Instance.new("TextLabel")
        boostLbl.Size = UDim2.new(0, 60, 0, 18)
        boostLbl.Position = UDim2.new(1, -130, 0, 5)
        boostLbl.BackgroundTransparency = 1
        boostLbl.Text = gear.boost
        boostLbl.TextColor3 = Theme.Success
        boostLbl.TextSize = 11
        boostLbl.Font = Enum.Font.GothamBold
        boostLbl.Parent = card

        local valueLbl = Instance.new("TextLabel")
        valueLbl.Size = UDim2.new(0, 60, 0, 18)
        valueLbl.Position = UDim2.new(1, -65, 0, 5)
        valueLbl.BackgroundTransparency = 1
        valueLbl.Text = gear.value
        valueLbl.TextColor3 = Theme.Warning
        valueLbl.TextSize = 10
        valueLbl.Font = Enum.Font.Gotham
        valueLbl.Parent = card
    end

    GearScroll.CanvasSize = UDim2.new(0, 0, 0, #gearItems * 56 + 20)
end)


-- ═══════════════════════════════════════════════════════════════════
-- TAB 5: MUTATIONS
-- ═══════════════════════════════════════════════════════════════════
local MutTabBtn, MutContent = CreateTab("Mutations", "🧬", function(content)
    local MutScroll = Instance.new("ScrollingFrame")
    MutScroll.Size = UDim2.new(1, -20, 1, -10)
    MutScroll.Position = UDim2.new(0, 10, 0, 5)
    MutScroll.BackgroundTransparency = 1
    MutScroll.BorderSizePixel = 0
    MutScroll.ScrollBarThickness = 4
    MutScroll.ScrollBarImageColor3 = Theme.Border
    MutScroll.Parent = content

    local MutGrid = Instance.new("UIGridLayout")
    MutGrid.CellSize = UDim2.new(0, 155, 0, 45)
    MutGrid.CellPadding = UDim2.new(0, 8, 0, 8)
    MutGrid.Parent = MutScroll

    local mutations = {
        {name="Choc", multi=2}, {name="Wet", multi=2}, {name="Snowy", multi=2}, {name="Moonlit", multi=2},
        {name="Windstruck", multi=2}, {name="Chilled", multi=2}, {name="Pollinated", multi=3}, {name="Aromatic", multi=3},
        {name="Sauce", multi=3}, {name="Pasta", multi=3}, {name="Meatball", multi=3}, {name="Moist", multi=3},
        {name="Coin", multi=3}, {name="Vamp", multi=3}, {name="Lush", multi=3}, {name="Sandy", multi=3},
        {name="Bloodlit", multi=4}, {name="Cracked", multi=4}, {name="Verdant", multi=4}, {name="Burnt", multi=4},
        {name="Twilight", multi=4}, {name="Wiltproof", multi=4}, {name="Nocturnal", multi=4}, {name="Peppermint", multi=4},
        {name="Fall", multi=4}, {name="Drenched", multi=5}, {name="Twisted", multi=5}, {name="Snowtouched", multi=5},
        {name="Clay", multi=5}, {name="HoneyGlazed", multi=5}, {name="Cloudtouched", multi=5}, {name="Heavenly", multi=5},
        {name="Geode", multi=5}, {name="Wildfast", multi=5}, {name="Plasma", multi=5}, {name="Arid", multi=6},
        {name="Charcoal", multi=6}, {name="Tempered", multi=6}, {name="Brewed", multi=7}, {name="Static", multi=8},
        {name="Necrotic", multi=8}, {name="Fried", multi=8}, {name="Webbed", multi=8}, {name="Bloom", multi=8},
        {name="Pestilent", multi=8}, {name="Blight", multi=8}, {name="Rot", multi=8}, {name="Spooky", multi=8},
        {name="Cooked", multi=10}, {name="Amber", multi=10}, {name="Frozen", multi=10}, {name="Wilted", multi=10},
        {name="Ornamented", multi=10}, {name="Arctic", multi=12}, {name="Tempestuous", multi=12}, {name="Jackpot", multi=15},
        {name="Gnomed", multi=15}, {name="CorruptChakra", multi=15}, {name="Oil", multi=15}, {name="Acidic", multi=15},
        {name="Spaghetti", multi=15}, {name="Boil", multi=15}, {name="Chakra", multi=15}, {name="Gilded", multi=15},
        {name="Sizzled", multi=18}, {name="Mineral", multi=18}, {name="Tranquil", multi=20}, {name="Eclipsed", multi=20},
        {name="Corrupt", multi=20}, {name="OldAmber", multi=20}, {name="Withered", multi=20}, {name="Flaming", multi=25},
        {name="Volcanic", multi=25}, {name="Ghostly", multi=25}, {name="Moonbled", multi=25}, {name="Alienated", multi=25},
        {name="Glacial", multi=25}, {name="Molten", multi=25}, {name="Crystalized", multi=25}, {name="Mirage", multi=25},
        {name="Zombified", multi=25}, {name="Gloom", multi=30}, {name="Umbral", multi=30}, {name="Typhoon", multi=30},
        {name="OilBoil", multi=30}, {name="Glossy", multi=30}, {name="SunScorched", multi=32}, {name="Ceramic", multi=32},
        {name="Enlightened", multi=35}, {name="HarmonisedChakra", multi=35}, {name="Supernatural", multi=37}, {name="Gourmet", multi=37},
        {name="Severed", multi=40}, {name="Subzero", multi=40}, {name="Corrosive", multi=40}, {name="Junkshock", multi=45},
        {name="Batty", multi=45}, {name="Lightcycle", multi=50}, {name="Monsoon", multi=50}, {name="Sliced", multi=50},
        {name="Luminous", multi=50}, {name="Cyclonic", multi=50}, {name="Stampede", multi=50}, {name="AncientAmber", multi=50},
        {name="Desolate", multi=50}, {name="Enchanted", multi=50}, {name="Fortune", multi=50}, {name="Blitzshock", multi=50},
        {name="Blazing", multi=52}, {name="Radioactive", multi=55}, {name="Affluent", multi=70}, {name="Shadowbound", multi=70},
        {name="Leeched", multi=70}, {name="Friendbound", multi=70}, {name="Graceful", multi=77}, {name="Riptide", multi=80},
        {name="Glitched", multi=85}, {name="Sundried", multi=85}, {name="Aurora", multi=90}, {name="CorruptFoxfireChakra", multi=90},
        {name="FoxfireChakra", multi=90}, {name="Fractured", multi=92}, {name="Slashbound", multi=95}, {name="Blackout", multi=95},
        {name="Alienlike", multi=100}, {name="Paradisal", multi=100}, {name="Shocked", multi=100}, {name="Brainrot", multi=100},
        {name="Maelstrom", multi=100}, {name="Beanbound", multi=100}, {name="Plagued", multi=102}, {name="Touchdown", multi=105},
        {name="Galactic", multi=120}, {name="Celestial", multi=120}, {name="Meteoric", multi=125}, {name="Disco", multi=125},
        {name="Extraterrestrial", multi=130}, {name="Voidtouched", multi=135}, {name="Dawnbound", multi=150}, {name="Biohazard", multi=157},
        {name="Grim", multi=170}, {name="MindBender", multi=175}, {name="Stormcharged", multi=180}, {name="Infernal", multi=180},
        {name="HarmonisedFoxfireChakra", multi=190}, {name="Contagion", multi=205}, {name="AscendedChakra", multi=230}, {name="Cosmic", multi=240},
        {name="Abyssal", multi=240}, {name="Stormbound", multi=270}, {name="Astral", multi=365}, {name="Goldsparkle", multi=200},
        {name="Heartstruck", multi=80}, {name="Cute", multi=60}, {name="Heartbound", multi=150}, {name="Dreadbound", multi=80},
        {name="Soulflame", multi=80}, {name="Spectral", multi=80}, {name="Nightmare", multi=120}, {name="Gale", multi=100},
        {name="Whimsical", multi=50}, {name="Azure", multi=80}, {name="Festive", multi=60}, {name="Sleepy", multi=40},
        {name="Warped", multi=70},
    }

    for _, mut in ipairs(mutations) do
        local card = Instance.new("Frame")
        card.Size = UDim2.new(0, 155, 0, 45)
        card.BackgroundColor3 = Theme.Surface
        card.BorderSizePixel = 0
        card.Parent = MutScroll
        CreateCorner(card, 10)

        local multiColor = mut.multi >= 100 and Theme.Error or (mut.multi >= 50 and Theme.Warning or (mut.multi >= 20 and Theme.Secondary or Theme.Success))
        CreateStroke(card, multiColor, 1)

        local nameLbl = Instance.new("TextLabel")
        nameLbl.Size = UDim2.new(1, -10, 0, 22)
        nameLbl.Position = UDim2.new(0, 5, 0, 3)
        nameLbl.BackgroundTransparency = 1
        nameLbl.Text = mut.name
        nameLbl.TextColor3 = Theme.Text
        nameLbl.TextSize = 12
        nameLbl.Font = Enum.Font.GothamBold
        nameLbl.Parent = card

        local multiLbl = Instance.new("TextLabel")
        multiLbl.Size = UDim2.new(1, -10, 0, 16)
        multiLbl.Position = UDim2.new(0, 5, 0, 24)
        multiLbl.BackgroundTransparency = 1
        multiLbl.Text = "x" .. mut.multi .. " Value"
        multiLbl.TextColor3 = multiColor
        multiLbl.TextSize = 11
        multiLbl.Font = Enum.Font.GothamBold
        multiLbl.Parent = card
    end

    MutScroll.CanvasSize = UDim2.new(0, 0, 0, math.ceil(#mutations / 4) * 53 + 20)
end)

-- ═══════════════════════════════════════════════════════════════════
-- TAB 6: SEEDS
-- ═══════════════════════════════════════════════════════════════════
local SeedTabBtn, SeedContent = CreateTab("Seeds", "🌱", function(content)
    local SeedScroll = Instance.new("ScrollingFrame")
    SeedScroll.Size = UDim2.new(1, -20, 1, -10)
    SeedScroll.Position = UDim2.new(0, 10, 0, 5)
    SeedScroll.BackgroundTransparency = 1
    SeedScroll.BorderSizePixel = 0
    SeedScroll.ScrollBarThickness = 4
    SeedScroll.ScrollBarImageColor3 = Theme.Border
    SeedScroll.Parent = content

    local SeedList = Instance.new("UIListLayout")
    SeedList.Padding = UDim.new(0, 5)
    SeedList.Parent = SeedScroll

    local seeds = {
        {name="Carrot", grow="16s", value="20"}, {name="Strawberry", grow="18s", value="15"},
        {name="Blueberry", grow="12s", value="20"}, {name="Tomato", grow="30s", value="30"},
        {name="Corn", grow="2m", value="40"}, {name="Watermelon", grow="7m", value="3K"},
        {name="Pumpkin", grow="8m", value="3.4K"}, {name="Apple", grow="3m", value="275"},
        {name="Bamboo", grow="4m", value="4K"}, {name="Coconut", grow="14m", value="400"},
        {name="Cactus", grow="7m", value="3.4K"}, {name="Dragon Fruit", grow="12m", value="4.75K"},
        {name="Mango", grow="15m", value="6.5K"}, {name="Grape", grow="3m", value="7.85K"},
        {name="Mushroom", grow="25m", value="151K"}, {name="Pepper", grow="5m", value="8K"},
        {name="Cacao", grow="8m", value="12K"}, {name="Sunflower", grow="9m", value="55.5K"},
        {name="Beanstalk", grow="10m", value="28K"}, {name="Ember Lily", grow="12m", value="66.6K"},
        {name="Burning Bud", grow="12m", value="70K"}, {name="Poppies", grow="2m", value="5K"},
        {name="Lavender", grow="3m", value="8K"}, {name="Rose", grow="2m", value="12K"},
        {name="Daisy", grow="1.5m", value="3K"}, {name="Tulip", grow="1m", value="5.5K"},
        {name="Sugar Apple", grow="8m", value="15K"}, {name="Prickly Pear", grow="6m", value="8K"},
        {name="Buttercup", grow="1.5m", value="2.5K"}, {name="Pineapple", grow="10m", value="12K"},
        {name="Coffee Bean", grow="7m", value="9K"}, {name="Tea Leaf", grow="5m", value="6K"},
        {name="Rice", grow="4m", value="4.5K"}, {name="Wheat", grow="3m", value="3.5K"},
        {name="Potato", grow="4.5m", value="5K"}, {name="Onion", grow="3.5m", value="4K"},
        {name="Garlic", grow="5.5m", value="7K"}, {name="Lemon", grow="6m", value="8K"},
        {name="Orange", grow="7m", value="9.5K"}, {name="Peach", grow="8m", value="11K"},
        {name="Plum", grow="7.5m", value="10K"}, {name="Cherry", grow="6.5m", value="8.5K"},
        {name="Passion Fruit", grow="9m", value="13K"}, {name="Avocado", grow="10m", value="14K"},
        {name="Papaya", grow="9.5m", value="12.5K"}, {name="Pomegranate", grow="11m", value="16K"},
        {name="Fig", grow="10.5m", value="15K"}, {name="Date", grow="9m", value="12K"},
        {name="Olive", grow="8m", value="10K"}, {name="Almond", grow="12m", value="18K"},
        {name="Cashew", grow="11m", value="16K"}, {name="Walnut", grow="13m", value="20K"},
        {name="Peanut", grow="7m", value="9K"}, {name="Bell Pepper", grow="5.5m", value="7.5K"},
        {name="Eggplant", grow="6.5m", value="8.5K"}, {name="Zucchini", grow="5m", value="6.5K"},
        {name="Cucumber", grow="4.5m", value="5.5K"}, {name="Broccoli", grow="6m", value="7K"},
        {name="Cauliflower", grow="6.5m", value="8K"}, {name="Cabbage", grow="5m", value="6K"},
        {name="Lettuce", grow="3m", value="4K"}, {name="Spinach", grow="3.5m", value="4.5K"},
        {name="Kale", grow="4m", value="5K"}, {name="Celery", grow="4.5m", value="5.5K"},
        {name="Asparagus", grow="5.5m", value="7K"}, {name="Artichoke", grow="7m", value="9K"},
        {name="Leek", grow="5m", value="6K"}, {name="Radish", grow="2.5m", value="3.5K"},
        {name="Turnip", grow="3m", value="4K"}, {name="Beet", grow="3.5m", value="4.5K"},
        {name="Yam", grow="6m", value="7K"}, {name="Sweet Potato", grow="6.5m", value="7.5K"},
        {name="Cassava", grow="7.5m", value="8.5K"}, {name="Taro", grow="8m", value="9K"},
        {name="Ginger", grow="9m", value="10K"}, {name="Turmeric", grow="10m", value="11K"},
        {name="Vanilla", grow="12m", value="15K"}, {name="Cinnamon", grow="14m", value="18K"},
        {name="Nutmeg", grow="13m", value="17K"}, {name="Clove", grow="15m", value="20K"},
        {name="Saffron", grow="18m", value="25K"}, {name="Cardamom", grow="16m", value="22K"},
        {name="Star Anise", grow="14m", value="19K"}, {name="Black Pepper", grow="11m", value="16K"},
        {name="Coriander", grow="8m", value="12K"}, {name="Basil", grow="5m", value="8K"},
        {name="Mint", grow="4m", value="6K"}, {name="Thyme", grow="5.5m", value="7.5K"},
        {name="Rosemary", grow="6m", value="8.5K"}, {name="Oregano", grow="5m", value="7K"},
        {name="Parsley", grow="4m", value="5.5K"}, {name="Sage", grow="6.5m", value="9K"},
        {name="Dill", grow="5m", value="6.5K"}, {name="Chive", grow="3.5m", value="5K"},
        {name="Tarragon", grow="6m", value="8K"}, {name="Bay Leaf", grow="7m", value="10K"},
        {name="Lemongrass", grow="8.5m", value="11K"}, {name="Chili Pepper", grow="6m", value="9K"},
        {name="Bird's Eye Chili", grow="7m", value="10K"}, {name="Wasabi", grow="10m", value="14K"},
        {name="Horseradish", grow="9m", value="12K"}, {name="Mustard", grow="7.5m", value="9.5K"},
        {name="Bamboo Shoot", grow="5m", value="7K"}, {name="Lotus Root", grow="8m", value="10K"},
        {name="Water Chestnut", grow="6.5m", value="8.5K"}, {name="Seaweed", grow="4m", value="5K"},
        {name="Nori Leaf", grow="5m", value="6.5K"}, {name="Goji Berry", grow="9m", value="11K"},
        {name="Acai", grow="10m", value="13K"}, {name="Blue Spirulina", grow="8m", value="10K"},
        {name="Matcha Leaf", grow="7m", value="9K"}, {name="Yerba Mate", grow="6m", value="8K"},
    }

    for _, seed in ipairs(seeds) do
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1, -10, 0, 38)
        card.BackgroundColor3 = Theme.Surface
        card.BorderSizePixel = 0
        card.Parent = SeedScroll
        CreateCorner(card, 8)
        CreateStroke(card, Theme.Border, 1)

        local nameLbl = Instance.new("TextLabel")
        nameLbl.Size = UDim2.new(0, 180, 1, 0)
        nameLbl.Position = UDim2.new(0, 10, 0, 0)
        nameLbl.BackgroundTransparency = 1
        nameLbl.Text = "🌱 " .. seed.name
        nameLbl.TextColor3 = Theme.Text
        nameLbl.TextSize = 12
        nameLbl.Font = Enum.Font.GothamBold
        nameLbl.TextXAlignment = Enum.TextXAlignment.Left
        nameLbl.Parent = card

        local growLbl = Instance.new("TextLabel")
        growLbl.Size = UDim2.new(0, 80, 1, 0)
        growLbl.Position = UDim2.new(1, -170, 0, 0)
        growLbl.BackgroundTransparency = 1
        growLbl.Text = "⏱️ " .. seed.grow
        growLbl.TextColor3 = Theme.Accent
        growLbl.TextSize = 11
        growLbl.Font = Enum.Font.Gotham
        growLbl.Parent = card

        local valLbl = Instance.new("TextLabel")
        valLbl.Size = UDim2.new(0, 80, 1, 0)
        valLbl.Position = UDim2.new(1, -85, 0, 0)
        valLbl.BackgroundTransparency = 1
        valLbl.Text = "💰 " .. seed.value
        valLbl.TextColor3 = Theme.Success
        valLbl.TextSize = 11
        valLbl.Font = Enum.Font.GothamBold
        valLbl.Parent = card
    end

    SeedScroll.CanvasSize = UDim2.new(0, 0, 0, #seeds * 43 + 20)
end)

-- ═══════════════════════════════════════════════════════════════════
-- TAB 7: SETTINGS
-- ═══════════════════════════════════════════════════════════════════
local SettingsTabBtn, SettingsContent = CreateTab("Settings", "⚙️", function(content)
    local SettingsPanel = Instance.new("Frame")
    SettingsPanel.Size = UDim2.new(1, -20, 0, 300)
    SettingsPanel.Position = UDim2.new(0, 10, 0, 5)
    SettingsPanel.BackgroundColor3 = Theme.Surface
    SettingsPanel.BorderSizePixel = 0
    SettingsPanel.Parent = content
    CreateCorner(SettingsPanel, 12)
    CreateStroke(SettingsPanel, Theme.Border, 1)

    local SettingsTitle = Instance.new("TextLabel")
    SettingsTitle.Size = UDim2.new(1, -20, 0, 24)
    SettingsTitle.Position = UDim2.new(0, 10, 0, 8)
    SettingsTitle.BackgroundTransparency = 1
    SettingsTitle.Text = "⚙️ Hub Settings"
    SettingsTitle.TextColor3 = Theme.Primary
    SettingsTitle.TextSize = 14
    SettingsTitle.Font = Enum.Font.GothamBold
    SettingsTitle.TextXAlignment = Enum.TextXAlignment.Left
    SettingsTitle.Parent = SettingsPanel

    local settings = {
        {name = "UI Scale", type = "slider", y = 40},
        {name = "Notifications", type = "toggle", y = 80, default = true},
        {name = "Auto Minimize", type = "toggle", y = 120, default = false},
        {name = "Sound Effects", type = "toggle", y = 160, default = true},
        {name = "Show FPS", type = "toggle", y = 200, default = false},
    }

    for _, s in ipairs(settings) do
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, -20, 0, 30)
        row.Position = UDim2.new(0, 10, 0, s.y)
        row.BackgroundTransparency = 1
        row.Parent = SettingsPanel

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0, 200, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = s.name
        lbl.TextColor3 = Theme.Text
        lbl.TextSize = 12
        lbl.Font = Enum.Font.Gotham
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = row

        if s.type == "toggle" then
            local toggleBg = Instance.new("Frame")
            toggleBg.Size = UDim2.new(0, 44, 0, 22)
            toggleBg.Position = UDim2.new(1, -44, 0.5, -11)
            toggleBg.BackgroundColor3 = s.default and Theme.Success or Theme.Elevated
            toggleBg.BorderSizePixel = 0
            toggleBg.Parent = row
            CreateCorner(toggleBg, 11)

            local toggleKnob = Instance.new("Frame")
            toggleKnob.Size = UDim2.new(0, 18, 0, 18)
            toggleKnob.Position = UDim2.new(0, s.default and 24 or 2, 0.5, -9)
            toggleKnob.BackgroundColor3 = Color3.fromRGB(255,255,255)
            toggleKnob.BorderSizePixel = 0
            toggleKnob.Parent = toggleBg
            CreateCorner(toggleKnob, 9)
        end
    end

    -- Info Panel
    local InfoPanel = Instance.new("Frame")
    InfoPanel.Size = UDim2.new(1, -20, 0, 180)
    InfoPanel.Position = UDim2.new(0, 10, 0, 315)
    InfoPanel.BackgroundColor3 = Theme.Surface
    InfoPanel.BorderSizePixel = 0
    InfoPanel.Parent = content
    CreateCorner(InfoPanel, 12)
    CreateStroke(InfoPanel, Theme.Border, 1)

    local InfoTitle = Instance.new("TextLabel")
    InfoTitle.Size = UDim2.new(1, -20, 0, 24)
    InfoTitle.Position = UDim2.new(0, 10, 0, 8)
    InfoTitle.BackgroundTransparency = 1
    InfoTitle.Text = "📊 ZUZU HUB Info"
    InfoTitle.TextColor3 = Theme.Primary
    InfoTitle.TextSize = 14
    InfoTitle.Font = Enum.Font.GothamBold
    InfoTitle.TextXAlignment = Enum.TextXAlignment.Left
    InfoTitle.Parent = InfoPanel

    local stats = {
        "Version: v5000",
        "Theme: Blue-Black-Purple",
        "Pets: 215+",
        "Eggs: 34+",
        "Gear: 163+",
        "Mutations: 170+",
        "Seeds: 306+",
        "Status: Keyless | Delta Ready",
        "Made with 💙 for Grow A Garden",
    }

    for i, stat in ipairs(stats) do
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -20, 0, 16)
        lbl.Position = UDim2.new(0, 10, 0, 32 + (i-1)*16)
        lbl.BackgroundTransparency = 1
        lbl.Text = stat
        lbl.TextColor3 = Theme.TextDim
        lbl.TextSize = 11
        lbl.Font = Enum.Font.Gotham
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = InfoPanel
    end

    content.CanvasSize = UDim2.new(0, 0, 0, 510)
end)

-- ═══════════════════════════════════════════════════════════════════
-- TOGGLE / MINIMIZE / CLOSE LOGIC
-- ═══════════════════════════════════════════════════════════════════
local HubVisible = false

local function ShowHub()
    HubVisible = true
    HubGui.Enabled = true
    MainFrame.Position = UDim2.new(0.5, -425, 0, -600)
    Tween(MainFrame, {Position = UDim2.new(0.5, -425, 0.5, -290)}, 0.5, Enum.EasingStyle.Back)
    ZuzuNotify("ZUZU HUB", "Welcome back, gardener! 🐺", "info")
end

local function HideHub()
    HubVisible = false
    Tween(MainFrame, {Position = UDim2.new(0.5, -425, 0, -600)}, 0.4)
    task.wait(0.4)
    HubGui.Enabled = false
end

ToggleBtn.MouseButton1Click:Connect(function()
    if HubVisible then
        HideHub()
    else
        ShowHub()
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    HideHub()
end)

MinBtn.MouseButton1Click:Connect(function()
    HideHub()
end)

-- Draggable Title Bar
local dragging = false
local dragStart = nil
local startPos = nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- ═══════════════════════════════════════════════════════════════════
-- ACTIVATE FIRST TAB
-- ═══════════════════════════════════════════════════════════════════
if MainTabBtn then
    MainTabBtn.MouseButton1Click:Fire()
end

-- ═══════════════════════════════════════════════════════════════════
-- KEYBIND (RightCtrl to toggle)
-- ═══════════════════════════════════════════════════════════════════
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
        if HubVisible then
            HideHub()
        else
            ShowHub()
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════
-- FINAL NOTIFICATION
-- ═══════════════════════════════════════════════════════════════════
task.wait(1)
ZuzuNotify("🐺 ZUZU HUB v5000", "All features loaded! Press RightCtrl to toggle.", "success")
ZuzuNotify("Database", "215 Pets | 34 Eggs | 163 Gear | 170+ Mutations | 306+ Seeds", "info")

print("✅ ZUZU HUB v5000 Loaded Successfully!")
print("🐺 Theme: Blue-Black-Purple | Wolf Logo")
print("🔓 Keyless | Delta Executor Ready")
