local WindUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"
))()

WindUI:AddTheme({
    Name = "Crimson",

    Accent = WindUI:Gradient({
        ["0"] = {
            Color = Color3.fromHex("#ff1744"),
            Transparency = 0
        },
        ["100"] = {
            Color = Color3.fromHex("#b00020"),
            Transparency = 0
        },
    }, {
        Rotation = 45
    }),

    Background = WindUI:Gradient({
        ["0"] = {
            Color = Color3.fromHex("#120000"),
            Transparency = 0
        },
        ["100"] = {
            Color = Color3.fromHex("#2b0008"),
            Transparency = 0
        },
    }, {
        Rotation = 90
    }),

    Text = Color3.fromHex("#fff1f2"),
    Placeholder = Color3.fromHex("#c97b86"),
    Dialog = Color3.fromHex("#3a000b"),
    Button = Color3.fromHex("#dc143c"),
    Icon = Color3.fromHex("#ff4d6d"),
    Toggle = Color3.fromHex("#ff1744"),
    Slider = Color3.fromHex("#ff1744"),
    Checkbox = Color3.fromHex("#ff1744"),
})

WindUI:SetTheme("Crimson")

WindUI:Popup({
    Title = "Destine Hub",
    Icon = "info",
    Content = "Welcome to Destine Hub!",

    Buttons = {
        {
            Title = "Close",
            Variant = "Tertiary",

            Callback = function()
                return
            end,
        },

        {
            Title = "Continue",
            Icon = "arrow-right",
            Variant = "Primary",

            Callback = function()
                local Window = WindUI:CreateWindow({
                    Title = "DestineExploitzs | Official",
                    Icon = "door-open",
                    Author = "Roller For Animals",
                    Folder = "MySuperHub",

                    Size = UDim2.fromOffset(580, 460),
                    MinSize = Vector2.new(560, 350),
                    MaxSize = Vector2.new(850, 560),

                    ToggleKey = Enum.KeyCode.LeftShift,

                    Transparent = true,
                    Resizable = true,

                    SideBarWidth = 200,
                    BackgroundImageTransparency = 0.42,

                    HideSearchBar = true,
                    ScrollBarEnabled = false,

                    User = {
                        Enabled = true,
                        Anonymous = false,

                        Callback = function()
                            print("clicked")
                        end,
                    },
                })

                Window:EditOpenButton({
                    Title = "Open Destine Hub",
                    Icon = "monitor",
                    CornerRadius = UDim.new(0, 16),
                    StrokeThickness = 2,

                    Color = ColorSequence.new(
                        Color3.fromHex("#DC143C"),
                        Color3.fromHex("#8B0000")
                    ),

                    OnlyMobile = false,
                    Enabled = true,
                    Draggable = true,
                })

                Window:Tag({
                    Title = "v1.1",
                    Icon = "github",
                    Color = Color3.fromHex("#DC143C"),
                    Radius = 0,
                })

                WindUI:SetTheme("Crimson")

                
                --// Info Tab
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local StartTime = os.clock()
local LiveFPS, LivePing, MemoryUsage = 0, 0, 0
local GameTitle, GameCreator, CreatorType = game.Name, "Unknown", "Unknown"

pcall(function()
    local Info = MarketplaceService:GetProductInfo(game.PlaceId)
    if Info then
        GameTitle = Info.Name or game.Name
        if Info.Creator then
            GameCreator = Info.Creator.Name or "Unknown"
            CreatorType = tostring(Info.Creator.CreatorType or "Unknown")
        end
    end
end)

local AvatarImage = ""
pcall(function()
    AvatarImage = Players:GetUserThumbnailAsync(
        LocalPlayer.UserId,
        Enum.ThumbnailType.HeadShot,
        Enum.ThumbnailSize.Size420x420
    )
end)

local DeviceType = "Unknown"
if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
    DeviceType = "Mobile"
elseif UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled then
    DeviceType = "Console"
elseif UserInputService.KeyboardEnabled then
    DeviceType = "PC"
end

local GameThumbnail = "https://www.roblox.com/asset-thumbnail/image?assetId="
    .. game.PlaceId .. "&width=768&height=432&format=png"

--// FPS Tracker
task.spawn(function()
    while task.wait(1) do
        local Frames = 0
        local Connection = RunService.RenderStepped:Connect(function()
            Frames += 1
        end)
        task.wait(1)
        Connection:Disconnect()
        LiveFPS = Frames
    end
end)

--// Ping + Memory
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            LivePing = math.floor(
                Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
            )
        end)
        pcall(function()
            MemoryUsage = Stats:GetTotalMemoryUsageMb()
        end)
    end
end)

local InfoTab = Window:Tab({
    Title = "Info",
    Icon = "info",
    Locked = false,
})

--// Welcome
InfoTab:Section({Title = "Welcome", Opened = true})

InfoTab:Paragraph({
    Title = "Destine Hub v1.2",
    Desc = "Welcome back to Destine Hub! Live information and diagnostics are ready.",
    Icon = "hand",
    Color = "Orange",
})

local WelcomeGame = InfoTab:Paragraph({
    Title = "Current Game",
    Desc = GameTitle,
    Icon = "gamepad-2",
})

InfoTab:Paragraph({
    Title = "Player",
    Desc = LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ")",
    Icon = "user",
})

--// Game Information
InfoTab:Section({Title = "Game Information", Opened = true})

pcall(function()
    InfoTab:Image({
        Image = GameThumbnail,
        AspectRatio = "16:9",
        Radius = 10,
    })
end)

local GameName = InfoTab:Paragraph({
    Title = "Game Name",
    Desc = GameTitle,
    Icon = "gamepad-2",
})

InfoTab:Paragraph({
    Title = "Game ID / Place ID",
    Desc = tostring(game.PlaceId),
    Icon = "hash",
})

InfoTab:Paragraph({
    Title = "Universe ID",
    Desc = tostring(game.GameId),
    Icon = "globe",
})

local Creator = InfoTab:Paragraph({
    Title = "Creator / Owner",
    Desc = GameCreator,
    Icon = "user-round",
})

InfoTab:Paragraph({
    Title = "Creator Type",
    Desc = CreatorType,
    Icon = "badge",
})

InfoTab:Paragraph({
    Title = "Server Job ID",
    Desc = game.JobId ~= "" and game.JobId or "Unavailable",
    Icon = "server",
})

local GamePlayers = InfoTab:Paragraph({
    Title = "Server Players",
    Desc = "0 / " .. Players.MaxPlayers,
    Icon = "users",
})

--// Profile Information
InfoTab:Section({Title = "Profile Information", Opened = true})

if AvatarImage ~= "" then
    pcall(function()
        InfoTab:Image({
            Image = AvatarImage,
            AspectRatio = "1:1",
            Radius = 10,
        })
    end)
end

InfoTab:Paragraph({
    Title = "Username",
    Desc = "@" .. LocalPlayer.Name,
    Icon = "at-sign",
})

InfoTab:Paragraph({
    Title = "Display Name",
    Desc = LocalPlayer.DisplayName,
    Icon = "user",
})

InfoTab:Paragraph({
    Title = "User ID",
    Desc = tostring(LocalPlayer.UserId),
    Icon = "fingerprint",
})

InfoTab:Paragraph({
    Title = "Account Age",
    Desc = LocalPlayer.AccountAge .. " days",
    Icon = "calendar-days",
})

local Team = InfoTab:Paragraph({
    Title = "Current Team",
    Desc = "None",
    Icon = "shield",
})

--// Device
InfoTab:Section({Title = "Device", Opened = true})

InfoTab:Paragraph({
    Title = "Platform",
    Desc = DeviceType,
    Icon = "smartphone",
})

InfoTab:Paragraph({
    Title = "Touch",
    Desc = UserInputService.TouchEnabled and "Supported" or "Not Supported",
    Icon = "touchpad",
})

InfoTab:Paragraph({
    Title = "Keyboard",
    Desc = UserInputService.KeyboardEnabled and "Supported" or "Not Supported",
    Icon = "keyboard",
})

InfoTab:Paragraph({
    Title = "Mouse",
    Desc = UserInputService.MouseEnabled and "Supported" or "Not Supported",
    Icon = "mouse",
})

InfoTab:Paragraph({
    Title = "Gamepad",
    Desc = UserInputService.GamepadEnabled and "Supported" or "Not Supported",
    Icon = "gamepad-2",
})

local Graphics = InfoTab:Paragraph({
    Title = "Graphics Quality",
    Desc = "Unknown",
    Icon = "gauge",
})

local Resolution = InfoTab:Paragraph({
    Title = "Screen Resolution",
    Desc = "Unknown",
    Icon = "monitor",
})

--// Session
InfoTab:Section({Title = "Session", Opened = true})

InfoTab:Paragraph({
    Title = "Session Status",
    Desc = "Active",
    Color = "Green",
    Icon = "activity",
})

local Runtime = InfoTab:Paragraph({
    Title = "Runtime",
    Desc = "00:00:00",
    Icon = "timer",
})

InfoTab:Paragraph({
    Title = "Join Time",
    Desc = os.date("%I:%M:%S %p"),
    Icon = "log-in",
})

local CharacterStatus = InfoTab:Paragraph({
    Title = "Character Status",
    Desc = "Checking...",
    Icon = "user-round-check",
})

local Executor = InfoTab:Paragraph({
    Title = "Executor",
    Desc = "Unknown",
    Icon = "cpu",
})

pcall(function()
    if identifyexecutor then
        Executor:SetDesc(tostring(identifyexecutor()))
    end
end)

--// Live Diagnostics
InfoTab:Section({Title = "Live Diagnostics", Opened = true})

local FPS = InfoTab:Paragraph({
    Title = "Live FPS",
    Desc = "0 FPS",
    Icon = "activity",
})

local Ping = InfoTab:Paragraph({
    Title = "Live Ping",
    Desc = "0 ms",
    Icon = "wifi",
})

local Memory = InfoTab:Paragraph({
    Title = "Memory Usage",
    Desc = "0 MB",
    Icon = "memory-stick",
})

local FPSStatus = InfoTab:Paragraph({
    Title = "FPS Status",
    Desc = "Checking...",
    Icon = "gauge",
})

local PingStatus = InfoTab:Paragraph({
    Title = "Ping Status",
    Desc = "Checking...",
    Icon = "signal",
})

--// Live UI Update
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local Elapsed = math.floor(os.clock() - StartTime)
            Runtime:SetDesc(string.format(
                "%02d:%02d:%02d",
                math.floor(Elapsed / 3600),
                math.floor((Elapsed % 3600) / 60),
                Elapsed % 60
            ))

            local Count = #Players:GetPlayers()
            GamePlayers:SetDesc(Count .. " / " .. Players.MaxPlayers)

            FPS:SetDesc(LiveFPS .. " FPS")
            Ping:SetDesc(LivePing .. " ms")
            Memory:SetDesc(string.format("%.1f MB", MemoryUsage))

            if LiveFPS >= 55 then
                FPSStatus:SetDesc("Excellent • " .. LiveFPS .. " FPS")
            elseif LiveFPS >= 30 then
                FPSStatus:SetDesc("Good • " .. LiveFPS .. " FPS")
            else
                FPSStatus:SetDesc("Low • " .. LiveFPS .. " FPS")
            end

            if LivePing <= 60 then
                PingStatus:SetDesc("Excellent • " .. LivePing .. " ms")
            elseif LivePing <= 120 then
                PingStatus:SetDesc("Good • " .. LivePing .. " ms")
            elseif LivePing <= 200 then
                PingStatus:SetDesc("High • " .. LivePing .. " ms")
            else
                PingStatus:SetDesc("Very High • " .. LivePing .. " ms")
            end

            pcall(function()
                Graphics:SetDesc(tostring(settings().Rendering.QualityLevel))
            end)

            local Camera = workspace.CurrentCamera
            if Camera then
                Resolution:SetDesc(
                    Camera.ViewportSize.X .. " × " .. Camera.ViewportSize.Y
                )
            end

            local Character = LocalPlayer.Character
            CharacterStatus:SetDesc(Character and "Loaded" or "Not Loaded")

            Team:SetDesc(
                LocalPlayer.Team and LocalPlayer.Team.Name or "None"
            )
        end)
    end
end)
                
                
                local Tab = Window:Tab({
                Title = "Farm",
                Icon = "bird", -- optional
                Locked = false,
              })
              
 
                -- ============================================================================
-- MEADOW MODULE CONFIGURATION & VARIABLES
-- ============================================================================
local Config = {
    AutoCollect = false,
    Method = "Tweenservice",
    FarmDelay = 0.5,
    TweenSpeed = 150,
    MeadowRarities = {} 
}

local RarityList = { 
    "Common", 
    "Uncommon", 
    "Rare", 
    "Epic", 
    "Legendary", 
    "Mythic", 
    "Admin", 
    "Celestial", 
    "Eternal", 
    "Ascended", 
    "Exclusive" 
}

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ============================================================================
-- CORE ENGINE LOGIC FUNCTIONS
-- ============================================================================
local NoclipConnection
local function ToggleNoclip(state)
    if state then
        if NoclipConnection then return end
        NoclipConnection = RunService.Stepped:Connect(function()
            local character = LocalPlayer.Character
            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if NoclipConnection then
            NoclipConnection:Disconnect()
            NoclipConnection = nil
        end
    end
end

local function moveTo(targetCFrame)
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if Config.Method == "Teleports" then
        hrp.CFrame = targetCFrame
        task.wait(0.01)
    elseif Config.Method == "Tweenservice" then
        local distance = (hrp.Position - targetCFrame.Position).Magnitude
        local duration = distance / Config.TweenSpeed
        
        ToggleNoclip(true)
        local tween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
        tween:Play()
        tween.Completed:Wait()
        ToggleNoclip(false)
    end
end

local function firePrompt(prompt)
    if not prompt or not prompt:IsA("ProximityPrompt") then return end
    local oldDuration = prompt.HoldDuration
    prompt.HoldDuration = 0
    prompt:InputHoldBegin()
    task.wait()
    prompt:InputHoldEnd()
    prompt.HoldDuration = oldDuration
end

local function getSafeZoneCFrame()
    local map = workspace:FindFirstChild("Map")
    if not map then return nil end
    local safeZone = map:FindFirstChild("SafeZone")
    if not safeZone then return nil end
    
    if safeZone:IsA("Model") then
        if safeZone.PrimaryPart then return safeZone.PrimaryPart.CFrame end
        local part = safeZone:FindFirstChildWhichIsA("BasePart")
        if part then return part.CFrame end
    elseif safeZone:IsA("BasePart") then
        return safeZone.CFrame
    end
    return nil
end

local function getEggCFrame(eggModel)
    if eggModel:IsA("Model") then
        if eggModel.PrimaryPart then return eggModel.PrimaryPart.CFrame end
        local part = eggModel:FindFirstChildWhichIsA("BasePart")
        if part then return part.CFrame end
    elseif eggModel:IsA("BasePart") then
        return eggModel.CFrame
    end
    return nil
end

local function executeMeadowFarm()
    task.spawn(function()
        while Config.AutoCollect do
            local worldEggs = workspace:FindFirstChild("WorldEggs")
            
            if worldEggs then
                for _, eggInstance in ipairs(worldEggs:GetChildren()) do
                    if not Config.AutoCollect then break end
                    
                    local currentZone = eggInstance:GetAttribute("Zone")
                    local currentRarity = eggInstance:GetAttribute("Rarity")
                    
                    local zoneMatches = (currentZone == "Meadow")
                    local rarityMatches = (#Config.MeadowRarities == 0) or table.find(Config.MeadowRarities, currentRarity)
                    
                    if zoneMatches and rarityMatches then
                        local eggCFrame = getEggCFrame(eggInstance)
                        
                        if eggCFrame then
                            moveTo(eggCFrame * CFrame.new(0, 3, 0))
                            
                            local prompt = eggInstance:FindFirstChildOfClass("ProximityPrompt") or (eggInstance.PrimaryPart and eggInstance.PrimaryPart:FindFirstChildOfClass("ProximityPrompt"))
                            if not prompt and eggInstance:IsA("Model") then
                                local part = eggInstance:FindFirstChildWhichIsA("BasePart")
                                prompt = part and part:FindFirstChildOfClass("ProximityPrompt")
                            end
                            
                            if prompt then
                                firePrompt(prompt)
                                task.wait(0.05)
                            end
                            
                            local safeZoneCFrame = getSafeZoneCFrame()
                            if safeZoneCFrame then
                                moveTo(safeZoneCFrame * CFrame.new(0, 3, 0))
                            end
                            
                            task.wait(Config.FarmDelay)
                        end
                    end
                end
            end
            task.wait(0.1)
        end
        ToggleNoclip(false)
    end)
end

-- ============================================================================
-- SECTION 1: MEADOW UI COMPONENT
-- ============================================================================
local MeadowSection = Tab:Section({ Title = "Meadow" })

-- 1. Travel Methods Dropdown inside the section
local MethodDropdown = MeadowSection:Dropdown({
    Title = "Methods",
    Desc = "Choose your travel method",
    Values = { "Tweenservice", "Teleports" },
    Value = "Tweenservice",
    Callback = function(option)
        Config.Method = option
    end
})

-- 2. Delay Slider inside the section
local DelaySlider = MeadowSection:Slider({
    Title = "Auto Collect Delay",
    Desc = "0.1 = Fastest | 10 = Slowest",
    Step = 0.1,
    Value = {
        Min = 0.1,
        Max = 10,
        Default = 0.5,
    },
    Callback = function(value)
        Config.FarmDelay = value
    end
})

-- 3. Rarity Filter Multi-Dropdown
local MeadowRarity = MeadowSection:Dropdown({
    Title = "Rarity Filter", 
    Desc = "Filter Meadow eggs by Rarity attribute",
    Values = RarityList, 
    Value = {}, 
    Multi = true, 
    AllowNone = true,
    Callback = function(options) 
        Config.MeadowRarities = options 
    end
})

-- 4. Auto Collect Toggle Switch
local MeadowToggle = MeadowSection:Toggle({
    Title = "Auto Collect Meadow", 
    Desc = "Collects targeted Meadow zone eggs",
    Icon = "bird", 
    Type = "Checkbox", 
    Value = false,
    Callback = function(state)
        Config.AutoCollect = state
        if state then 
            executeMeadowFarm() 
        else 
            ToggleNoclip(false) 
        end
    end
})

                -- ============================================================================
-- SECTION 2: CORAL REEF (Paste directly below Meadow Section)
-- ============================================================================

-- 1. Configuration Storage Object
local CoralConfig = {
    AutoCollect = false,
    Method = "Tweenservice",
    FarmDelay = 0.5,
    SelectedRarities = {}
}

-- 2. Localized Farm Execution Function
local function executeCoralFarm()
    task.spawn(function()
        while CoralConfig.AutoCollect do
            local worldEggs = workspace:FindFirstChild("WorldEggs")
            
            if worldEggs then
                for _, eggInstance in ipairs(worldEggs:GetChildren()) do
                    if not CoralConfig.AutoCollect then break end
                    
                    local currentZone = eggInstance:GetAttribute("Zone")
                    local currentRarity = eggInstance:GetAttribute("Rarity")
                    
                    local zoneMatches = (currentZone == "Coral Reef")
                    local rarityMatches = (#CoralConfig.SelectedRarities == 0) or table.find(CoralConfig.SelectedRarities, currentRarity)
                    
                    if zoneMatches and rarityMatches then
                        local eggCFrame = getEggCFrame(eggInstance)
                        
                        if eggCFrame then
                            -- Uses global movement functions defined in the Meadow block
                            if CoralConfig.Method == "Teleports" then
                                local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                                local hrp = character:FindFirstChild("HumanoidRootPart")
                                if hrp then hrp.CFrame = eggCFrame * CFrame.new(0, 3, 0) task.wait(0.01) end
                            else
                                -- Uses your custom speed-scalable Tween logic from Meadow
                                moveTo(eggCFrame * CFrame.new(0, 3, 0))
                            end
                            
                            local prompt = eggInstance:FindFirstChildOfClass("ProximityPrompt") or (eggInstance.PrimaryPart and eggInstance.PrimaryPart:FindFirstChildOfClass("ProximityPrompt"))
                            if not prompt and eggInstance:IsA("Model") then
                                local part = eggInstance:FindFirstChildWhichIsA("BasePart")
                                prompt = part and part:FindFirstChildOfClass("ProximityPrompt")
                            end
                            
                            if prompt then
                                firePrompt(prompt)
                                task.wait(0.05)
                            end
                            
                            local safeZoneCFrame = getSafeZoneCFrame()
                            if safeZoneCFrame then
                                if CoralConfig.Method == "Teleports" then
                                    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                                    local hrp = character:FindFirstChild("HumanoidRootPart")
                                    if hrp then hrp.CFrame = safeZoneCFrame * CFrame.new(0, 3, 0) end
                                else
                                    moveTo(safeZoneCFrame * CFrame.new(0, 3, 0))
                                end
                            end
                            
                            task.wait(CoralConfig.FarmDelay)
                        end
                    end
                end
            end
            task.wait(0.1)
        end
        ToggleNoclip(false)
    end)
end

-- 3. UI Component Construction
local CoralSection = Tab:Section({ Title = "Coral Reef" })

local CoralMethodDropdown = CoralSection:Dropdown({
    Title = "Methods",
    Desc = "Choose your travel method",
    Values = { "Tweenservice", "Teleports" },
    Value = "Tweenservice",
    Callback = function(option)
        CoralConfig.Method = option
    end
})

local CoralDelaySlider = CoralSection:Slider({
    Title = "Auto Collect Delay",
    Desc = "0.1 = Fastest | 10 = Slowest",
    Step = 0.1,
    Value = {
        Min = 0.1,
        Max = 10,
        Default = 0.5,
    },
    Callback = function(value)
        CoralConfig.FarmDelay = value
    end
})

local CoralRarity = CoralSection:Dropdown({
    Title = "Rarity Filter", 
    Desc = "Filter Coral Reef eggs by Rarity attribute",
    Values = RarityList, 
    Value = {}, 
    Multi = true, 
    AllowNone = true,
    Callback = function(options) 
        CoralConfig.SelectedRarities = options 
    end
})

local CoralToggle = CoralSection:Toggle({
    Title = "Auto Collect Coral Reef", 
    Desc = "Collects targeted Coral Reef zone eggs",
    Icon = "bird", 
    Type = "Checkbox", 
    Value = false,
    Callback = function(state)
        CoralConfig.AutoCollect = state
        if state then 
            executeCoralFarm() 
        else 
            ToggleNoclip(false) 
        end
    end
})

                -- ============================================================================
-- SECTION 3: WINTER (Paste directly below Coral Reef Section)
-- ============================================================================

-- 1. Configuration Storage Object
local WinterConfig = {
    AutoCollect = false,
    Method = "Tweenservice",
    FarmDelay = 0.5,
    SelectedRarities = {}
}

-- 2. Localized Farm Execution Function
local function executeWinterFarm()
    task.spawn(function()
        while WinterConfig.AutoCollect do
            local worldEggs = workspace:FindFirstChild("WorldEggs")
            
            if worldEggs then
                for _, eggInstance in ipairs(worldEggs:GetChildren()) do
                    if not WinterConfig.AutoCollect then break end
                    
                    local currentZone = eggInstance:GetAttribute("Zone")
                    local currentRarity = eggInstance:GetAttribute("Rarity")
                    
                    local zoneMatches = (currentZone == "Winter")
                    local rarityMatches = (#WinterConfig.SelectedRarities == 0) or table.find(WinterConfig.SelectedRarities, currentRarity)
                    
                    if zoneMatches and rarityMatches then
                        local eggCFrame = getEggCFrame(eggInstance)
                        
                        if eggCFrame then
                            if WinterConfig.Method == "Teleports" then
                                local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                                local hrp = character:FindFirstChild("HumanoidRootPart")
                                if hrp then hrp.CFrame = eggCFrame * CFrame.new(0, 3, 0) task.wait(0.01) end
                            else
                                moveTo(eggCFrame * CFrame.new(0, 3, 0))
                            end
                            
                            local prompt = eggInstance:FindFirstChildOfClass("ProximityPrompt") or (eggInstance.PrimaryPart and eggInstance.PrimaryPart:FindFirstChildOfClass("ProximityPrompt"))
                            if not prompt and eggInstance:IsA("Model") then
                                local part = eggInstance:FindFirstChildWhichIsA("BasePart")
                                prompt = part and part:FindFirstChildOfClass("ProximityPrompt")
                            end
                            
                            if prompt then
                                firePrompt(prompt)
                                task.wait(0.05)
                            end
                            
                            local safeZoneCFrame = getSafeZoneCFrame()
                            if safeZoneCFrame then
                                if WinterConfig.Method == "Teleports" then
                                    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                                    local hrp = character:FindFirstChild("HumanoidRootPart")
                                    if hrp then hrp.CFrame = safeZoneCFrame * CFrame.new(0, 3, 0) end
                                else
                                    moveTo(safeZoneCFrame * CFrame.new(0, 3, 0))
                                end
                            end
                            
                            task.wait(WinterConfig.FarmDelay)
                        end
                    end
                end
            end
            task.wait(0.1)
        end
        ToggleNoclip(false)
    end)
end

-- 3. UI Component Construction
local WinterSection = Tab:Section({ Title = "Winter" })

local WinterMethodDropdown = WinterSection:Dropdown({
    Title = "Methods",
    Desc = "Choose your travel method",
    Values = { "Tweenservice", "Teleports" },
    Value = "Tweenservice",
    Callback = function(option)
        WinterConfig.Method = option
    end
})

local WinterDelaySlider = WinterSection:Slider({
    Title = "Auto Collect Delay",
    Desc = "0.1 = Fastest | 10 = Slowest",
    Step = 0.1,
    Value = {
        Min = 0.1,
        Max = 10,
        Default = 0.5,
    },
    Callback = function(value)
        WinterConfig.FarmDelay = value
    end
})

local WinterRarity = WinterSection:Dropdown({
    Title = "Rarity Filter", 
    Desc = "Filter Winter eggs by Rarity attribute",
    Values = RarityList, 
    Value = {}, 
    Multi = true, 
    AllowNone = true,
    Callback = function(options) 
        WinterConfig.SelectedRarities = options 
    end
})

local WinterToggle = WinterSection:Toggle({
    Title = "Auto Collect Winter", 
    Desc = "Collects targeted Winter zone eggs",
    Icon = "bird", 
    Type = "Checkbox", 
    Value = false,
    Callback = function(state)
        WinterConfig.AutoCollect = state
        if state then 
            executeWinterFarm() 
        else 
            ToggleNoclip(false) 
        end
    end
})

                -- ============================================================================
-- SECTION 4: DESERT (Paste directly below Winter Section)
-- ============================================================================

-- 1. Configuration Storage Object
local DesertConfig = {
    AutoCollect = false,
    Method = "Tweenservice",
    FarmDelay = 0.5,
    SelectedRarities = {}
}

-- 2. Localized Farm Execution Function
local function executeDesertFarm()
    task.spawn(function()
        while DesertConfig.AutoCollect do
            local worldEggs = workspace:FindFirstChild("WorldEggs")
            
            if worldEggs then
                for _, eggInstance in ipairs(worldEggs:GetChildren()) do
                    if not DesertConfig.AutoCollect then break end
                    
                    local currentZone = eggInstance:GetAttribute("Zone")
                    local currentRarity = eggInstance:GetAttribute("Rarity")
                    
                    local zoneMatches = (currentZone == "Desert")
                    local rarityMatches = (#DesertConfig.SelectedRarities == 0) or table.find(DesertConfig.SelectedRarities, currentRarity)
                    
                    if zoneMatches and rarityMatches then
                        local eggCFrame = getEggCFrame(eggInstance)
                        
                        if eggCFrame then
                            if DesertConfig.Method == "Teleports" then
                                local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                                local hrp = character:FindFirstChild("HumanoidRootPart")
                                if hrp then hrp.CFrame = eggCFrame * CFrame.new(0, 3, 0) task.wait(0.01) end
                            else
                                moveTo(eggCFrame * CFrame.new(0, 3, 0))
                            end
                            
                            local prompt = eggInstance:FindFirstChildOfClass("ProximityPrompt") or (eggInstance.PrimaryPart and eggInstance.PrimaryPart:FindFirstChildOfClass("ProximityPrompt"))
                            if not prompt and eggInstance:IsA("Model") then
                                local part = eggInstance:FindFirstChildWhichIsA("BasePart")
                                prompt = part and part:FindFirstChildOfClass("ProximityPrompt")
                            end
                            
                            if prompt then
                                firePrompt(prompt)
                                task.wait(0.05)
                            end
                            
                            local safeZoneCFrame = getSafeZoneCFrame()
                            if safeZoneCFrame then
                                if DesertConfig.Method == "Teleports" then
                                    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                                    local hrp = character:FindFirstChild("HumanoidRootPart")
                                    if hrp then hrp.CFrame = safeZoneCFrame * CFrame.new(0, 3, 0) end
                                else
                                    moveTo(safeZoneCFrame * CFrame.new(0, 3, 0))
                                end
                            end
                            
                            task.wait(DesertConfig.FarmDelay)
                        end
                    end
                end
            end
            task.wait(0.1)
        end
        ToggleNoclip(false)
    end)
end

-- 3. UI Component Construction
local DesertSection = Tab:Section({ Title = "Desert" })

local DesertMethodDropdown = DesertSection:Dropdown({
    Title = "Methods",
    Desc = "Choose your travel method",
    Values = { "Tweenservice", "Teleports" },
    Value = "Tweenservice",
    Callback = function(option)
        DesertConfig.Method = option
    end
})

local DesertDelaySlider = DesertSection:Slider({
    Title = "Auto Collect Delay",
    Desc = "0.1 = Fastest | 10 = Slowest",
    Step = 0.1,
    Value = {
        Min = 0.1,
        Max = 10,
        Default = 0.5,
    },
    Callback = function(value)
        DesertConfig.FarmDelay = value
    end
})

local DesertRarity = DesertSection:Dropdown({
    Title = "Rarity Filter", 
    Desc = "Filter Desert eggs by Rarity attribute",
    Values = RarityList, 
    Value = {}, 
    Multi = true, 
    AllowNone = true,
    Callback = function(options) 
        DesertConfig.SelectedRarities = options 
    end
})

local DesertToggle = DesertSection:Toggle({
    Title = "Auto Collect Desert", 
    Desc = "Collects targeted Desert zone eggs",
    Icon = "bird", 
    Type = "Checkbox", 
    Value = false,
    Callback = function(state)
        DesertConfig.AutoCollect = state
        if state then 
            executeDesertFarm() 
        else 
            ToggleNoclip(false) 
        end
    end
})

                -- ============================================================================
-- SECTION 5: CRYSTAL MINES (Paste directly below Desert Section)
-- ============================================================================

-- 1. Configuration Storage Object
local CrystalConfig = {
    AutoCollect = false,
    Method = "Tweenservice",
    FarmDelay = 0.5,
    SelectedRarities = {}
}

-- 2. Localized Farm Execution Function
local function executeCrystalFarm()
    task.spawn(function()
        while CrystalConfig.AutoCollect do
            local worldEggs = workspace:FindFirstChild("WorldEggs")
            
            if worldEggs then
                for _, eggInstance in ipairs(worldEggs:GetChildren()) do
                    if not CrystalConfig.AutoCollect then break end
                    
                    local currentZone = eggInstance:GetAttribute("Zone")
                    local currentRarity = eggInstance:GetAttribute("Rarity")
                    
                    local zoneMatches = (currentZone == "Crystal Mines")
                    local rarityMatches = (#CrystalConfig.SelectedRarities == 0) or table.find(CrystalConfig.SelectedRarities, currentRarity)
                    
                    if zoneMatches and rarityMatches then
                        local eggCFrame = getEggCFrame(eggInstance)
                        
                        if eggCFrame then
                            if CrystalConfig.Method == "Teleports" then
                                local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                                local hrp = character:FindFirstChild("HumanoidRootPart")
                                if hrp then hrp.CFrame = eggCFrame * CFrame.new(0, 3, 0) task.wait(0.01) end
                            else
                                moveTo(eggCFrame * CFrame.new(0, 3, 0))
                            end
                            
                            local prompt = eggInstance:FindFirstChildOfClass("ProximityPrompt") or (eggInstance.PrimaryPart and eggInstance.PrimaryPart:FindFirstChildOfClass("ProximityPrompt"))
                            if not prompt and eggInstance:IsA("Model") then
                                local part = eggInstance:FindFirstChildWhichIsA("BasePart")
                                prompt = part and part:FindFirstChildOfClass("ProximityPrompt")
                            end
                            
                            if prompt then
                                firePrompt(prompt)
                                task.wait(0.05)
                            end
                            
                            local safeZoneCFrame = getSafeZoneCFrame()
                            if safeZoneCFrame then
                                if CrystalConfig.Method == "Teleports" then
                                    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                                    local hrp = character:FindFirstChild("HumanoidRootPart")
                                    if hrp then hrp.CFrame = safeZoneCFrame * CFrame.new(0, 3, 0) end
                                else
                                    moveTo(safeZoneCFrame * CFrame.new(0, 3, 0))
                                end
                            end
                            
                            task.wait(CrystalConfig.FarmDelay)
                        end
                    end
                end
            end
            task.wait(0.1)
        end
        ToggleNoclip(false)
    end)
end

-- 3. UI Component Construction
local CrystalSection = Tab:Section({ Title = "Crystal Mines" })

local CrystalMethodDropdown = CrystalSection:Dropdown({
    Title = "Methods",
    Desc = "Choose your travel method",
    Values = { "Tweenservice", "Teleports" },
    Value = "Tweenservice",
    Callback = function(option)
        CrystalConfig.Method = option
    end
})

local CrystalDelaySlider = CrystalSection:Slider({
    Title = "Auto Collect Delay",
    Desc = "0.1 = Fastest | 10 = Slowest",
    Step = 0.1,
    Value = {
        Min = 0.1,
        Max = 10,
        Default = 0.5,
    },
    Callback = function(value)
        CrystalConfig.FarmDelay = value
    end
})

local CrystalRarity = CrystalSection:Dropdown({
    Title = "Rarity Filter", 
    Desc = "Filter Crystal Mines eggs by Rarity attribute",
    Values = RarityList, 
    Value = {}, 
    Multi = true, 
    AllowNone = true,
    Callback = function(options) 
        CrystalConfig.SelectedRarities = options 
    end
})

local CrystalToggle = CrystalSection:Toggle({
    Title = "Auto Collect Crystal Mines", 
    Desc = "Collects targeted Crystal Mines zone eggs",
    Icon = "bird", 
    Type = "Checkbox", 
    Value = false,
    Callback = function(state)
        CrystalConfig.AutoCollect = state
        if state then 
            executeCrystalFarm() 
        else 
            ToggleNoclip(false) 
        end
    end
})

                -- ============================================================================
-- SECTION 6: JUNGLE (Paste directly below Crystal Mines Section)
-- ============================================================================

-- 1. Configuration Storage Object
local JungleConfig = {
    AutoCollect = false,
    Method = "Tweenservice",
    FarmDelay = 0.5,
    SelectedRarities = {}
}

-- 2. Localized Farm Execution Function
local function executeJungleFarm()
    task.spawn(function()
        while JungleConfig.AutoCollect do
            local worldEggs = workspace:FindFirstChild("WorldEggs")
            
            if worldEggs then
                for _, eggInstance in ipairs(worldEggs:GetChildren()) do
                    if not JungleConfig.AutoCollect then break end
                    
                    local currentZone = eggInstance:GetAttribute("Zone")
                    local currentRarity = eggInstance:GetAttribute("Rarity")
                    
                    local zoneMatches = (currentZone == "Jungle")
                    local rarityMatches = (#JungleConfig.SelectedRarities == 0) or table.find(JungleConfig.SelectedRarities, currentRarity)
                    
                    if zoneMatches and rarityMatches then
                        local eggCFrame = getEggCFrame(eggInstance)
                        
                        if eggCFrame then
                            if JungleConfig.Method == "Teleports" then
                                local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                                local hrp = character:FindFirstChild("HumanoidRootPart")
                                if hrp then hrp.CFrame = eggCFrame * CFrame.new(0, 3, 0) task.wait(0.01) end
                            else
                                moveTo(eggCFrame * CFrame.new(0, 3, 0))
                            end
                            
                            local prompt = eggInstance:FindFirstChildOfClass("ProximityPrompt") or (eggInstance.PrimaryPart and eggInstance.PrimaryPart:FindFirstChildOfClass("ProximityPrompt"))
                            if not prompt and eggInstance:IsA("Model") then
                                local part = eggInstance:FindFirstChildWhichIsA("BasePart")
                                prompt = part and part:FindFirstChildOfClass("ProximityPrompt")
                            end
                            
                            if prompt then
                                firePrompt(prompt)
                                task.wait(0.05)
                            end
                            
                            local safeZoneCFrame = getSafeZoneCFrame()
                            if safeZoneCFrame then
                                if JungleConfig.Method == "Teleports" then
                                    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                                    local hrp = character:FindFirstChild("HumanoidRootPart")
                                    if hrp then hrp.CFrame = safeZoneCFrame * CFrame.new(0, 3, 0) end
                                else
                                    moveTo(safeZoneCFrame * CFrame.new(0, 3, 0))
                                end
                            end
                            
                            task.wait(JungleConfig.FarmDelay)
                        end
                    end
                end
            end
            task.wait(0.1)
        end
        ToggleNoclip(false)
    end)
end

-- 3. UI Component Construction
local JungleSection = Tab:Section({ Title = "Jungle" })

local JungleMethodDropdown = JungleSection:Dropdown({
    Title = "Methods",
    Desc = "Choose your travel method",
    Values = { "Tweenservice", "Teleports" },
    Value = "Tweenservice",
    Callback = function(option)
        JungleConfig.Method = option
    end
})

local JungleDelaySlider = JungleSection:Slider({
    Title = "Auto Collect Delay",
    Desc = "0.1 = Fastest | 10 = Slowest",
    Step = 0.1,
    Value = {
        Min = 0.1,
        Max = 10,
        Default = 0.5,
    },
    Callback = function(value)
        JungleConfig.FarmDelay = value
    end
})

local JungleRarity = JungleSection:Dropdown({
    Title = "Rarity Filter", 
    Desc = "Filter Jungle eggs by Rarity attribute",
    Values = RarityList, 
    Value = {}, 
    Multi = true, 
    AllowNone = true,
    Callback = function(options) 
        JungleConfig.SelectedRarities = options 
    end
})

local JungleToggle = JungleSection:Toggle({
    Title = "Auto Collect Jungle", 
    Desc = "Collects targeted Jungle zone eggs",
    Icon = "bird", 
    Type = "Checkbox", 
    Value = false,
    Callback = function(state)
        JungleConfig.AutoCollect = state
        if state then 
            executeJungleFarm() 
        else 
            ToggleNoclip(false) 
        end
    end
})

                -- ============================================================================
-- SECTION 7: MYSTIC ISLE (Paste directly below Jungle Section)
-- ============================================================================

-- 1. Configuration Storage Object
local MysticConfig = {
    AutoCollect = false,
    Method = "Tweenservice",
    FarmDelay = 0.5,
    SelectedRarities = {}
}

-- 2. Localized Farm Execution Function
local function executeMysticFarm()
    task.spawn(function()
        while MysticConfig.AutoCollect do
            local worldEggs = workspace:FindFirstChild("WorldEggs")
            
            if worldEggs then
                for _, eggInstance in ipairs(worldEggs:GetChildren()) do
                    if not MysticConfig.AutoCollect then break end
                    
                    local currentZone = eggInstance:GetAttribute("Zone")
                    local currentRarity = eggInstance:GetAttribute("Rarity")
                    
                    local zoneMatches = (currentZone == "Mystic Isle")
                    local rarityMatches = (#MysticConfig.SelectedRarities == 0) or table.find(MysticConfig.SelectedRarities, currentRarity)
                    
                    if zoneMatches and rarityMatches then
                        local eggCFrame = getEggCFrame(eggInstance)
                        
                        if eggCFrame then
                            if MysticConfig.Method == "Teleports" then
                                local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                                local hrp = character:FindFirstChild("HumanoidRootPart")
                                if hrp then hrp.CFrame = eggCFrame * CFrame.new(0, 3, 0) task.wait(0.01) end
                            else
                                moveTo(eggCFrame * CFrame.new(0, 3, 0))
                            end
                            
                            local prompt = eggInstance:FindFirstChildOfClass("ProximityPrompt") or (eggInstance.PrimaryPart and eggInstance.PrimaryPart:FindFirstChildOfClass("ProximityPrompt"))
                            if not prompt and eggInstance:IsA("Model") then
                                local part = eggInstance:FindFirstChildWhichIsA("BasePart")
                                prompt = part and part:FindFirstChildOfClass("ProximityPrompt")
                            end
                            
                            if prompt then
                                firePrompt(prompt)
                                task.wait(0.05)
                            end
                            
                            local safeZoneCFrame = getSafeZoneCFrame()
                            if safeZoneCFrame then
                                if MysticConfig.Method == "Teleports" then
                                    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                                    local hrp = character:FindFirstChild("HumanoidRootPart")
                                    if hrp then hrp.CFrame = safeZoneCFrame * CFrame.new(0, 3, 0) end
                                else
                                    moveTo(safeZoneCFrame * CFrame.new(0, 3, 0))
                                end
                            end
                            
                            task.wait(MysticConfig.FarmDelay)
                        end
                    end
                end
            end
            task.wait(0.1)
        end
        ToggleNoclip(false)
    end)
end

-- 3. UI Component Construction
local MysticSection = Tab:Section({ Title = "Mystic Isle" })

local MysticMethodDropdown = MysticSection:Dropdown({
    Title = "Methods",
    Desc = "Choose your travel method",
    Values = { "Tweenservice", "Teleports" },
    Value = "Tweenservice",
    Callback = function(option)
        MysticConfig.Method = option
    end
})

local MysticDelaySlider = MysticSection:Slider({
    Title = "Auto Collect Delay",
    Desc = "0.1 = Fastest | 10 = Slowest",
    Step = 0.1,
    Value = {
        Min = 0.1,
        Max = 10,
        Default = 0.5,
    },
    Callback = function(value)
        MysticConfig.FarmDelay = value
    end
})

local MysticRarity = MysticSection:Dropdown({
    Title = "Rarity Filter", 
    Desc = "Filter Mystic Isle eggs by Rarity attribute",
    Values = RarityList, 
    Value = {}, 
    Multi = true, 
    AllowNone = true,
    Callback = function(options) 
        MysticConfig.SelectedRarities = options 
    end
})

local MysticToggle = MysticSection:Toggle({
    Title = "Auto Collect Mystic Isle", 
    Desc = "Collects targeted Mystic Isle zone eggs",
    Icon = "bird", 
    Type = "Checkbox", 
    Value = false,
    Callback = function(state)
        MysticConfig.AutoCollect = state
        if state then 
            executeMysticFarm() 
        else 
            ToggleNoclip(false) 
        end
    end
})

                -- ============================================================================
-- SECTION 8: PREHISTORIC (Paste directly below Mystic Isle Section)
-- ============================================================================

-- 1. Configuration Storage Object
local PrehistoricConfig = {
    AutoCollect = false,
    Method = "Tweenservice",
    FarmDelay = 0.5,
    SelectedRarities = {}
}

-- 2. Localized Farm Execution Function
local function executePrehistoricFarm()
    task.spawn(function()
        while PrehistoricConfig.AutoCollect do
            local worldEggs = workspace:FindFirstChild("WorldEggs")
            
            if worldEggs then
                for _, eggInstance in ipairs(worldEggs:GetChildren()) do
                    if not PrehistoricConfig.AutoCollect then break end
                    
                    local currentZone = eggInstance:GetAttribute("Zone")
                    local currentRarity = eggInstance:GetAttribute("Rarity")
                    
                    local zoneMatches = (currentZone == "Prehistoric")
                    local rarityMatches = (#PrehistoricConfig.SelectedRarities == 0) or table.find(PrehistoricConfig.SelectedRarities, currentRarity)
                    
                    if zoneMatches and rarityMatches then
                        local eggCFrame = getEggCFrame(eggInstance)
                        
                        if eggCFrame then
                            if PrehistoricConfig.Method == "Teleports" then
                                local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                                local hrp = character:FindFirstChild("HumanoidRootPart")
                                if hrp then hrp.CFrame = eggCFrame * CFrame.new(0, 3, 0) task.wait(0.01) end
                            else
                                moveTo(eggCFrame * CFrame.new(0, 3, 0))
                            end
                            
                            local prompt = eggInstance:FindFirstChildOfClass("ProximityPrompt") or (eggInstance.PrimaryPart and eggInstance.PrimaryPart:FindFirstChildOfClass("ProximityPrompt"))
                            if not prompt and eggInstance:IsA("Model") then
                                local part = eggInstance:FindFirstChildWhichIsA("BasePart")
                                prompt = part and part:FindFirstChildOfClass("ProximityPrompt")
                            end
                            
                            if prompt then
                                firePrompt(prompt)
                                task.wait(0.05)
                            end
                            
                            local safeZoneCFrame = getSafeZoneCFrame()
                            if safeZoneCFrame then
                                if PrehistoricConfig.Method == "Teleports" then
                                    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                                    local hrp = character:FindFirstChild("HumanoidRootPart")
                                    if hrp then hrp.CFrame = safeZoneCFrame * CFrame.new(0, 3, 0) end
                                else
                                    moveTo(safeZoneCFrame * CFrame.new(0, 3, 0))
                                end
                            end
                            
                            task.wait(PrehistoricConfig.FarmDelay)
                        end
                    end
                end
            end
            task.wait(0.1)
        end
        ToggleNoclip(false)
    end)
end

-- 3. UI Component Construction
local PrehistoricSection = Tab:Section({ Title = "Prehistoric" })

local PrehistoricMethodDropdown = PrehistoricSection:Dropdown({
    Title = "Methods",
    Desc = "Choose your travel method",
    Values = { "Tweenservice", "Teleports" },
    Value = "Tweenservice",
    Callback = function(option)
        PrehistoricConfig.Method = option
    end
})

local PrehistoricDelaySlider = PrehistoricSection:Slider({
    Title = "Auto Collect Delay",
    Desc = "0.1 = Fastest | 10 = Slowest",
    Step = 0.1,
    Value = {
        Min = 0.1,
        Max = 10,
        Default = 0.5,
    },
    Callback = function(value)
        PrehistoricConfig.FarmDelay = value
    end
})

local PrehistoricRarity = PrehistoricSection:Dropdown({
    Title = "Rarity Filter", 
    Desc = "Filter Prehistoric eggs by Rarity attribute",
    Values = RarityList, 
    Value = {}, 
    Multi = true, 
    AllowNone = true,
    Callback = function(options) 
        PrehistoricConfig.SelectedRarities = options 
    end
})

local PrehistoricToggle = PrehistoricSection:Toggle({
    Title = "Auto Collect Prehistoric", 
    Desc = "Collects targeted Prehistoric zone eggs",
    Icon = "bird", 
    Type = "Checkbox", 
    Value = false,
    Callback = function(state)
        PrehistoricConfig.AutoCollect = state
        if state then 
            executePrehistoricFarm() 
        else 
            ToggleNoclip(false) 
        end
    end
})

                -- ============================================================================
-- SECTION 9: CELESTIAL HEIGHTS (Paste directly below Prehistoric Section)
-- ============================================================================

-- 1. Configuration Storage Object
local CelestialConfig = {
    AutoCollect = false,
    Method = "Tweenservice",
    FarmDelay = 0.5,
    SelectedRarities = {}
}

-- 2. Localized Farm Execution Function
local function executeCelestialFarm()
    task.spawn(function()
        while CelestialConfig.AutoCollect do
            local worldEggs = workspace:FindFirstChild("WorldEggs")
            
            if worldEggs then
                for _, eggInstance in ipairs(worldEggs:GetChildren()) do
                    if not CelestialConfig.AutoCollect then break end
                    
                    local currentZone = eggInstance:GetAttribute("Zone")
                    local currentRarity = eggInstance:GetAttribute("Rarity")
                    
                    local zoneMatches = (currentZone == "Celestial Heights")
                    local rarityMatches = (#CelestialConfig.SelectedRarities == 0) or table.find(CelestialConfig.SelectedRarities, currentRarity)
                    
                    if zoneMatches and rarityMatches then
                        local eggCFrame = getEggCFrame(eggInstance)
                        
                        if eggCFrame then
                            if CelestialConfig.Method == "Teleports" then
                                local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                                local hrp = character:FindFirstChild("HumanoidRootPart")
                                if hrp then hrp.CFrame = eggCFrame * CFrame.new(0, 3, 0) task.wait(0.01) end
                            else
                                moveTo(eggCFrame * CFrame.new(0, 3, 0))
                            end
                            
                            local prompt = eggInstance:FindFirstChildOfClass("ProximityPrompt") or (eggInstance.PrimaryPart and eggInstance.PrimaryPart:FindFirstChildOfClass("ProximityPrompt"))
                            if not prompt and eggInstance:IsA("Model") then
                                local part = eggInstance:FindFirstChildWhichIsA("BasePart")
                                prompt = part and part:FindFirstChildOfClass("ProximityPrompt")
                            end
                            
                            if prompt then
                                firePrompt(prompt)
                                task.wait(0.05)
                            end
                            
                            local safeZoneCFrame = getSafeZoneCFrame()
                            if safeZoneCFrame then
                                if CelestialConfig.Method == "Teleports" then
                                    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                                    local hrp = character:FindFirstChild("HumanoidRootPart")
                                    if hrp then hrp.CFrame = safeZoneCFrame * CFrame.new(0, 3, 0) end
                                else
                                    moveTo(safeZoneCFrame * CFrame.new(0, 3, 0))
                                end
                            end
                            
                            task.wait(CelestialConfig.FarmDelay)
                        end
                    end
                end
            end
            task.wait(0.1)
        end
        ToggleNoclip(false)
    end)
end

-- 3. UI Component Construction
local CelestialSection = Tab:Section({ Title = "Celestial Heights" })

local CelestialMethodDropdown = CelestialSection:Dropdown({
    Title = "Methods",
    Desc = "Choose your travel method",
    Values = { "Tweenservice", "Teleports" },
    Value = "Tweenservice",
    Callback = function(option)
        CelestialConfig.Method = option
    end
})

local CelestialDelaySlider = CelestialSection:Slider({
    Title = "Auto Collect Delay",
    Desc = "0.1 = Fastest | 10 = Slowest",
    Step = 0.1,
    Value = {
        Min = 0.1,
        Max = 10,
        Default = 0.5,
    },
    Callback = function(value)
        CelestialConfig.FarmDelay = value
    end
})

local CelestialRarity = CelestialSection:Dropdown({
    Title = "Rarity Filter", 
    Desc = "Filter Celestial Heights eggs by Rarity attribute",
    Values = RarityList, 
    Value = {}, 
    Multi = true, 
    AllowNone = true,
    Callback = function(options) 
        CelestialConfig.SelectedRarities = options 
    end
})

local CelestialToggle = CelestialSection:Toggle({
    Title = "Auto Collect Celestial Heights", 
    Desc = "Collects targeted Celestial Heights zone eggs",
    Icon = "bird", 
    Type = "Checkbox", 
    Value = false,
    Callback = function(state)
        CelestialConfig.AutoCollect = state
        if state then 
            executeCelestialFarm() 
        else 
            ToggleNoclip(false) 
        end
    end
})
                
                
                
              
              WindUI:Notify({  
                    Title = "Hub Loaded",  
                    Content = "Welcome! My Hub is ready.",  
                    Icon = "solar:bell-bold",  
                    Duration = 5,  
                })  
            end,  
        },  
    },  
})