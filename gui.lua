-- ============================================================
--   gui.lua — повертає таблицю G
-- ============================================================
local _c = "abcdefghijklmnopqrstuvwxyz0123456789"
local _tag = ""
for _ = 1, 8 do _tag = _tag .. _c:sub(math.random(1, #_c), math.random(1, #_c)) end

local function n(l)
    l = l or math.random(10, 18)
    local r = ""
    for _ = 1, l do r = r .. _c:sub(math.random(1, #_c), math.random(1, #_c)) end
    return r
end

local function mk(cl, pr, p)
    local i = Instance.new(cl, pr)
    i.Name = n()
    if p then for k, v in pairs(p) do pcall(function() i[k] = v end) end end
    return i
end

local function cr(pr, r) return mk("UICorner", pr, {CornerRadius = UDim.new(0, r or 8)}) end

if hookfunction then
    pcall(function()
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local old = mt.__index.GetChildren
        mt.__index.GetChildren = function(self, ...)
            local ch = old(self, ...)
            if self == game:GetService("CoreGui") then
                local f = {}
                for _, c in ipairs(ch) do if not c:GetAttribute(_tag) then table.insert(f, c) end end
                return f
            end
            return ch
        end
        setreadonly(mt, true)
    end)
end

local CoreGui = game:GetService("CoreGui")
local sg = mk("ScreenGui", CoreGui, {ResetOnSpawn = false, DisplayOrder = math.random(1, 50), IgnoreGuiInset = true})
sg:SetAttribute(_tag, true)

local frame = mk("Frame", sg, {Size = UDim2.new(0, 180, 0, 230), Position = UDim2.new(0.5, -90, 0.3, 0), BackgroundColor3 = Color3.fromRGB(30,30,30), BorderSizePixel = 0, Active = true})
cr(frame, 12)

local aimSettingsFrame = mk("Frame", sg, {Size = UDim2.new(0, 200, 0, 220), Position = UDim2.new(0.5, 100, 0.3, 0), BackgroundColor3 = Color3.fromRGB(25,25,25), BorderSizePixel = 0, Visible = false, Active = true})
cr(aimSettingsFrame, 12)
mk("TextLabel", aimSettingsFrame, {Size = UDim2.new(1,0,0,30), BackgroundTransparency = 1, Text = "AIM Settings", Font = Enum.Font.SourceSansBold, TextSize = 16, TextColor3 = Color3.new(1,1,1)})
local aimScroll = mk("ScrollingFrame", aimSettingsFrame, {Size = UDim2.new(1,0,1,-65), Position = UDim2.new(0,0,0,30), BackgroundTransparency = 1, ScrollBarThickness = 5, CanvasSize = UDim2.new(0,0,0,550)})

local espSettingsFrame = mk("Frame", sg, {Size = UDim2.new(0, 210, 0, 260), Position = UDim2.new(0.5, 100, 0.3, 0), BackgroundColor3 = Color3.fromRGB(25,25,25), BorderSizePixel = 0, Visible = false, Active = true})
cr(espSettingsFrame, 12)
local espColorPickerFrame = mk("Frame", sg, {Size = UDim2.new(0, 200, 0, 200), Position = UDim2.new(0.5, 320, 0.3, 0), BackgroundColor3 = Color3.fromRGB(25,25,25), BorderSizePixel = 0, Visible = false, Active = true})
cr(espColorPickerFrame, 12)

local charmsSettingsFrame = mk("Frame", sg, {Size = UDim2.new(0, 210, 0, 220), Position = UDim2.new(0.5, 100, 0.3, 0), BackgroundColor3 = Color3.fromRGB(25,25,25), BorderSizePixel = 0, Visible = false, Active = true})
cr(charmsSettingsFrame, 12)
mk("TextLabel", charmsSettingsFrame, {Size = UDim2.new(1,0,0,30), BackgroundTransparency = 1, Text = "Charms Settings", Font = Enum.Font.SourceSansBold, TextSize = 16, TextColor3 = Color3.new(1,1,1)})
local charmsScroll = mk("ScrollingFrame", charmsSettingsFrame, {Size = UDim2.new(1,0,1,-60), Position = UDim2.new(0,0,0,30), BackgroundTransparency = 1, ScrollBarThickness = 5, CanvasSize = UDim2.new(0,0,0,160)})

local charmsVisBtn = mk("TextButton", charmsScroll, {Size = UDim2.new(0.75,-5,0,30), Position = UDim2.new(0.05,0,0,5), BackgroundColor3 = Color3.fromRGB(0,255,0), TextColor3 = Color3.new(0,0,0), Font = Enum.Font.SourceSansBold, TextSize = 13, Text = "Visible"})
cr(charmsVisBtn)
local charmsVisColorOpenBtn = mk("TextButton", charmsScroll, {Size = UDim2.new(0.15,-5,0,30), Position = UDim2.new(0.8,0,0,5), BackgroundColor3 = Color3.fromRGB(0,150,255), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 18, Text = "+"})
cr(charmsVisColorOpenBtn)
local charmsUnvisBtn = mk("TextButton", charmsScroll, {Size = UDim2.new(0.75,-5,0,30), Position = UDim2.new(0.05,0,0,45), BackgroundColor3 = Color3.fromRGB(255,0,0), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 13, Text = "Unvisible"})
cr(charmsUnvisBtn)
local charmsUnvisColorOpenBtn = mk("TextButton", charmsScroll, {Size = UDim2.new(0.15,-5,0,30), Position = UDim2.new(0.8,0,0,45), BackgroundColor3 = Color3.fromRGB(0,150,255), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 18, Text = "+"})
cr(charmsUnvisColorOpenBtn)
local charmsNpcButton = mk("TextButton", charmsScroll, {Size = UDim2.new(0.9,0,0,30), Position = UDim2.new(0.05,0,0,85), BackgroundColor3 = Color3.fromRGB(40,40,40), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 14, Text = "NPC: OFF"})
cr(charmsNpcButton)
local charmsEspObjButton = mk("TextButton", charmsScroll, {Size = UDim2.new(0.9,0,0,30), Position = UDim2.new(0.05,0,0,125), BackgroundColor3 = Color3.fromRGB(40,40,40), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 14, Text = "ESP Objects: OFF"})
cr(charmsEspObjButton)
local charmsSettingsCloseBtn = mk("TextButton", charmsSettingsFrame, {Size = UDim2.new(0.9,0,0,25), Position = UDim2.new(0.05,0,1,-30), BackgroundColor3 = Color3.fromRGB(60,60,60), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 14, Text = "Close"})
cr(charmsSettingsCloseBtn)

local charmsColorPickerFrame = mk("Frame", sg, {Size = UDim2.new(0, 200, 0, 200), Position = UDim2.new(0.5, 320, 0.3, 0), BackgroundColor3 = Color3.fromRGB(25,25,25), BorderSizePixel = 0, Visible = false, Active = true})
cr(charmsColorPickerFrame, 12)
mk("TextLabel", charmsColorPickerFrame, {Size = UDim2.new(1,0,0,25), BackgroundTransparency = 1, Text = "Pick Color", Font = Enum.Font.SourceSansBold, TextSize = 14, TextColor3 = Color3.new(1,1,1)})
local charmsRSlider = mk("Frame", charmsColorPickerFrame, {Size = UDim2.new(0.9,0,0,15), Position = UDim2.new(0.05,0,0,35), BackgroundColor3 = Color3.fromRGB(255,50,50), BorderSizePixel = 0})
cr(charmsRSlider)
local charmsRHandle = mk("Frame", charmsRSlider, {Size = UDim2.new(0,14,1,0), Position = UDim2.new(1,-7,0,0), ZIndex = 5, BackgroundColor3 = Color3.new(1,1,1), BorderSizePixel = 0})
cr(charmsRHandle, 100)
local charmsGSlider = mk("Frame", charmsColorPickerFrame, {Size = UDim2.new(0.9,0,0,15), Position = UDim2.new(0.05,0,0,65), BackgroundColor3 = Color3.fromRGB(50,255,50), BorderSizePixel = 0})
cr(charmsGSlider)
local charmsGHandle = mk("Frame", charmsGSlider, {Size = UDim2.new(0,14,1,0), Position = UDim2.new(0,-7,0,0), ZIndex = 5, BackgroundColor3 = Color3.new(1,1,1), BorderSizePixel = 0})
cr(charmsGHandle, 100)
local charmsBSlider = mk("Frame", charmsColorPickerFrame, {Size = UDim2.new(0.9,0,0,15), Position = UDim2.new(0.05,0,0,95), BackgroundColor3 = Color3.fromRGB(50,50,255), BorderSizePixel = 0})
cr(charmsBSlider)
local charmsBHandle = mk("Frame", charmsBSlider, {Size = UDim2.new(0,14,1,0), Position = UDim2.new(0,-7,0,0), ZIndex = 5, BackgroundColor3 = Color3.new(1,1,1), BorderSizePixel = 0})
cr(charmsBHandle, 100)
local charmsColorPreview = mk("Frame", charmsColorPickerFrame, {Size = UDim2.new(0.9,0,0,25), Position = UDim2.new(0.05,0,0,120), BackgroundColor3 = Color3.fromRGB(0,255,0), BorderSizePixel = 0})
cr(charmsColorPreview)
local charmsColorPickerClose = mk("TextButton", charmsColorPickerFrame, {Size = UDim2.new(0.9,0,0,25), Position = UDim2.new(0.05,0,1,-30), BackgroundColor3 = Color3.fromRGB(60,60,60), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 14, Text = "← Back"})
cr(charmsColorPickerClose)

mk("TextLabel", espColorPickerFrame, {Size = UDim2.new(1,0,0,25), BackgroundTransparency = 1, Text = "Pick Color", Font = Enum.Font.SourceSansBold, TextSize = 14, TextColor3 = Color3.new(1,1,1), Name = "espColorPickerTitle"})
local espRSlider = mk("Frame", espColorPickerFrame, {Size = UDim2.new(0.9,0,0,15), Position = UDim2.new(0.05,0,0,35), BackgroundColor3 = Color3.fromRGB(255,50,50), BorderSizePixel = 0})
cr(espRSlider)
local espRHandle = mk("Frame", espRSlider, {Size = UDim2.new(0,18,0,18), Position = UDim2.new(1,-9,0,-1.5), BackgroundColor3 = Color3.new(1,1,1), BorderSizePixel = 0})
cr(espRHandle, 100)
local espGSlider = mk("Frame", espColorPickerFrame, {Size = UDim2.new(0.9,0,0,15), Position = UDim2.new(0.05,0,0,65), BackgroundColor3 = Color3.fromRGB(50,255,50), BorderSizePixel = 0})
cr(espGSlider)
local espGHandle = mk("Frame", espGSlider, {Size = UDim2.new(0,18,0,18), Position = UDim2.new(0,-9,0,-1.5), BackgroundColor3 = Color3.new(1,1,1), BorderSizePixel = 0})
cr(espGHandle, 100)
local espBSlider = mk("Frame", espColorPickerFrame, {Size = UDim2.new(0.9,0,0,15), Position = UDim2.new(0.05,0,0,95), BackgroundColor3 = Color3.fromRGB(50,50,255), BorderSizePixel = 0})
cr(espBSlider)
local espBHandle = mk("Frame", espBSlider, {Size = UDim2.new(0,18,0,18), Position = UDim2.new(0,-9,0,-1.5), BackgroundColor3 = Color3.new(1,1,1), BorderSizePixel = 0})
cr(espBHandle, 100)
local espColorPreview = mk("Frame", espColorPickerFrame, {Size = UDim2.new(0.9,0,0,25), Position = UDim2.new(0.05,0,0,120), BackgroundColor3 = Color3.fromRGB(255,0,0), BorderSizePixel = 0})
cr(espColorPreview)
local espColorPickerClose = mk("TextButton", espColorPickerFrame, {Size = UDim2.new(0.9,0,0,25), Position = UDim2.new(0.05,0,1,-30), BackgroundColor3 = Color3.fromRGB(60,60,60), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 14, Text = "← Back"})
cr(espColorPickerClose)

local espValCheckFrame = mk("Frame", sg, {Size = UDim2.new(0, 180, 0, 280), Position = UDim2.new(0.5, 320, 0.3, 0), BackgroundColor3 = Color3.fromRGB(25,25,25), BorderSizePixel = 0, Visible = false, Active = true})
cr(espValCheckFrame, 12)
mk("TextLabel", espValCheckFrame, {Size = UDim2.new(1,0,0,30), BackgroundTransparency = 1, Text = "ESP Players", Font = Enum.Font.SourceSansBold, TextSize = 15, TextColor3 = Color3.new(1,1,1)})
local espValCheckScroll = mk("ScrollingFrame", espValCheckFrame, {Size = UDim2.new(1,0,1,-65), Position = UDim2.new(0,0,0,35), BackgroundTransparency = 1, ScrollBarThickness = 5, CanvasSize = UDim2.new(0,0,0,0)})
local espValCheckClose = mk("TextButton", espValCheckFrame, {Size = UDim2.new(0.9,0,0,25), Position = UDim2.new(0.05,0,1,-30), BackgroundColor3 = Color3.fromRGB(60,60,60), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 14, Text = "Close"})
cr(espValCheckClose)

mk("TextLabel", espSettingsFrame, {Size = UDim2.new(1,0,0,30), BackgroundTransparency = 1, Text = "ESP Settings", Font = Enum.Font.SourceSansBold, TextSize = 16, TextColor3 = Color3.new(1,1,1)})
local espScroll = mk("ScrollingFrame", espSettingsFrame, {Size = UDim2.new(1,0,1,-60), Position = UDim2.new(0,0,0,25), BackgroundTransparency = 1, ScrollBarThickness = 5, CanvasSize = UDim2.new(0,0,0,360)})

local espVisColorBtn = mk("TextButton", espScroll, {Size = UDim2.new(0.75,-5,0,30), Position = UDim2.new(0.05,0,0,5), BackgroundColor3 = Color3.fromRGB(0,255,0), TextColor3 = Color3.new(0,0,0), Font = Enum.Font.SourceSansBold, TextSize = 13, Text = "Visible Color"})
cr(espVisColorBtn)
local espVisColorOpenBtn = mk("TextButton", espScroll, {Size = UDim2.new(0.15,-5,0,30), Position = UDim2.new(0.8,0,0,5), BackgroundColor3 = Color3.fromRGB(0,150,255), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 18, Text = "+"})
cr(espVisColorOpenBtn)
local espUnvisColorBtn = mk("TextButton", espScroll, {Size = UDim2.new(0.75,-5,0,30), Position = UDim2.new(0.05,0,0,45), BackgroundColor3 = Color3.fromRGB(255,0,0), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 13, Text = "Unvisible Color"})
cr(espUnvisColorBtn)
local espUnvisColorOpenBtn = mk("TextButton", espScroll, {Size = UDim2.new(0.15,-5,0,30), Position = UDim2.new(0.8,0,0,45), BackgroundColor3 = Color3.fromRGB(0,150,255), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 18, Text = "+"})
cr(espUnvisColorOpenBtn)

local function mkT(t, y, pr)
    local b = mk("TextButton", pr or espScroll, {Size = UDim2.new(0.9,0,0,30), Position = UDim2.new(0.05,0,0,y), BackgroundColor3 = Color3.fromRGB(40,40,40), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 14, Text = t})
    cr(b)
    return b
end

local espTracerBtn = mkT("Tracer: ON", 85)
local espBoxBtn = mkT("Box: ON", 125)
local espNameBtn = mkT("Name: ON", 165)
local espHealthBtn = mkT("Health: ON", 205)
local espDistBtn = mkT("Distance: ON", 245)
local espTeamCheckBtn = mkT("ESP Team Check: OFF", 285)
local espValCheckBtn = mk("TextButton", espScroll, {Size = UDim2.new(0.75,-5,0,30), Position = UDim2.new(0.05,0,0,325), BackgroundColor3 = Color3.fromRGB(40,40,40), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 14, Text = "ESP ValCheck: OFF"})
cr(espValCheckBtn)
local espValCheckOpenBtn = mk("TextButton", espScroll, {Size = UDim2.new(0.15,-5,0,30), Position = UDim2.new(0.8,0,0,325), BackgroundColor3 = Color3.fromRGB(0,150,255), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 18, Text = "+"})
cr(espValCheckOpenBtn)
local espSettingsCloseBtn = mk("TextButton", espSettingsFrame, {Size = UDim2.new(0.9,0,0,25), Position = UDim2.new(0.05,0,1,-30), BackgroundColor3 = Color3.fromRGB(60,60,60), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 14, Text = "Close"})
cr(espSettingsCloseBtn)

local pcTriggerButton = mk("TextButton", aimScroll, {Size = UDim2.new(0.44,0,0,30), Position = UDim2.new(0.05,0,0,385), BackgroundColor3 = Color3.fromRGB(40,40,40), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 13, Text = "PC Trigger: OFF"})
cr(pcTriggerButton)
local mobileTriggerButton = mk("TextButton", aimScroll, {Size = UDim2.new(0.44,0,0,30), Position = UDim2.new(0.51,0,0,385), BackgroundColor3 = Color3.fromRGB(40,40,40), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 13, Text = "Mobile Trigger: OFF"})
cr(mobileTriggerButton)
local valCheckButton = mk("TextButton", aimScroll, {Size = UDim2.new(0.75,-5,0,30), Position = UDim2.new(0.05,0,0,425), BackgroundColor3 = Color3.fromRGB(40,40,40), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 14, Text = "Val Check: OFF"})
cr(valCheckButton)
local valCheckOpenButton = mk("TextButton", aimScroll, {Size = UDim2.new(0.15,-5,0,30), Position = UDim2.new(0.8,0,0,425), BackgroundColor3 = Color3.fromRGB(0,150,255), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 18, Text = "+"})
cr(valCheckOpenButton)
local triggerWallCheckButton = mkT("Trigger WallCheck: OFF", 465, aimScroll)
local triggerTeamCheckButton = mkT("Trigger Team Check: OFF", 505, aimScroll)
local aimCloseButton = mk("TextButton", aimSettingsFrame, {Size = UDim2.new(0.9,0,0,25), Position = UDim2.new(0.05,0,1,-30), BackgroundColor3 = Color3.fromRGB(60,60,60), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 14, Text = "Close Menu"})
cr(aimCloseButton)
local fovCircleButton = mkT("FOV Circle: ON", 5, aimScroll)
fovCircleButton.TextSize = 16
local wallButton = mkT("WallCheck: OFF", 45, aimScroll)
wallButton.TextSize = 16
local aimValCheckButton = mk("TextButton", aimScroll, {Size = UDim2.new(0.75,-5,0,30), Position = UDim2.new(0.05,0,0,85), BackgroundColor3 = Color3.fromRGB(40,40,40), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 14, Text = "AIM ValCheck: OFF"})
cr(aimValCheckButton)
local aimValCheckOpenButton = mk("TextButton", aimScroll, {Size = UDim2.new(0.15,-5,0,30), Position = UDim2.new(0.8,0,0,85), BackgroundColor3 = Color3.fromRGB(0,150,255), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 18, Text = "+"})
cr(aimValCheckOpenButton)

mk("TextLabel", aimScroll, {Size = UDim2.new(0.4,0,0,25), Position = UDim2.new(0.05,0,0,125), BackgroundTransparency = 1, Text = "Aim FOV:", Font = Enum.Font.SourceSansBold, TextSize = 14, TextColor3 = Color3.new(1,1,1), TextXAlignment = Enum.TextXAlignment.Left})
local aimFOVInput = mk("TextBox", aimScroll, {Size = UDim2.new(0.45,0,0,25), Position = UDim2.new(0.5,0,0,125), BackgroundColor3 = Color3.fromRGB(50,50,50), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSans, TextSize = 14, Text = "60"})
cr(aimFOVInput)
local aimFOVSliderFrame = mk("Frame", aimScroll, {Size = UDim2.new(0.9,0,0,15), Position = UDim2.new(0.05,0,0,155), BackgroundColor3 = Color3.fromRGB(20,20,20), BorderSizePixel = 0})
cr(aimFOVSliderFrame)
local aimFOVSliderButton = mk("Frame", aimFOVSliderFrame, {Size = UDim2.new(0,20,0,20), Position = UDim2.new(0.18,-10,0,-2.5), BackgroundColor3 = Color3.fromRGB(0,255,100), BorderSizePixel = 0})
cr(aimFOVSliderButton, 100)
local smoothButton = mkT("Smooth: OFF", 175, aimScroll)
mk("TextLabel", aimScroll, {Size = UDim2.new(0.4,0,0,25), Position = UDim2.new(0.05,0,0,215), BackgroundTransparency = 1, Text = "Smooth:", Font = Enum.Font.SourceSansBold, TextSize = 14, TextColor3 = Color3.new(1,1,1), TextXAlignment = Enum.TextXAlignment.Left})
local smoothInput = mk("TextBox", aimScroll, {Size = UDim2.new(0.45,0,0,25), Position = UDim2.new(0.5,0,0,215), BackgroundColor3 = Color3.fromRGB(50,50,50), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSans, TextSize = 14, Text = "1"})
cr(smoothInput)
local smoothSliderFrame = mk("Frame", aimScroll, {Size = UDim2.new(0.9,0,0,15), Position = UDim2.new(0.05,0,0,245), BackgroundColor3 = Color3.fromRGB(20,20,20), BorderSizePixel = 0})
cr(smoothSliderFrame)
local smoothSliderButton = mk("Frame", smoothSliderFrame, {Size = UDim2.new(0,20,0,20), Position = UDim2.new(0.2,-10,0,-2.5), BackgroundColor3 = Color3.fromRGB(255,200,0), BorderSizePixel = 0})
cr(smoothSliderButton, 100)
local teamCheckButton = mkT("Team Check: OFF", 275, aimScroll)
local silentAimButton = mkT("Silent Aim: OFF", 315, aimScroll)

local hitboxSettingsFrame = mk("Frame", sg, {Size = UDim2.new(0, 200, 0, 310), Position = UDim2.new(0.5, 100, 0.3, 0), BackgroundColor3 = Color3.fromRGB(25,25,25), BorderSizePixel = 0, Visible = false, Active = true})
cr(hitboxSettingsFrame, 12)
mk("TextLabel", hitboxSettingsFrame, {Size = UDim2.new(1,0,0,30), BackgroundTransparency = 1, Text = "Hitbox Settings", Font = Enum.Font.SourceSansBold, TextSize = 16, TextColor3 = Color3.new(1,1,1)})
local hitboxScroll = mk("ScrollingFrame", hitboxSettingsFrame, {Size = UDim2.new(1,0,1,-65), Position = UDim2.new(0,0,0,35), BackgroundTransparency = 1, ScrollBarThickness = 6, CanvasSize = UDim2.new(0,0,0,300)})
local hitboxHeadButton = mk("TextButton", hitboxScroll, {Size = UDim2.new(0.9,0,0,40), Position = UDim2.new(0.05,0,0,10), BackgroundColor3 = Color3.fromRGB(0,255,0), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 16, Text = "🎯 Head"})
cr(hitboxHeadButton)
local hitboxTorsoButton = mk("TextButton", hitboxScroll, {Size = UDim2.new(0.9,0,0,40), Position = UDim2.new(0.05,0,0,60), BackgroundColor3 = Color3.fromRGB(40,40,40), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 16, Text = "💪 Torso"})
cr(hitboxTorsoButton)
local hitboxArmsButton = mk("TextButton", hitboxScroll, {Size = UDim2.new(0.9,0,0,40), Position = UDim2.new(0.05,0,0,110), BackgroundColor3 = Color3.fromRGB(40,40,40), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 16, Text = "👐 Arms"})
cr(hitboxArmsButton)
local hitboxLegsButton = mk("TextButton", hitboxScroll, {Size = UDim2.new(0.9,0,0,40), Position = UDim2.new(0.05,0,0,160), BackgroundColor3 = Color3.fromRGB(40,40,40), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 16, Text = "🦵 Legs"})
cr(hitboxLegsButton)
mk("TextLabel", hitboxScroll, {Size = UDim2.new(0.4,0,0,25), Position = UDim2.new(0.05,0,0,210), BackgroundTransparency = 1, Text = "Size:", Font = Enum.Font.SourceSansBold, TextSize = 14, TextColor3 = Color3.new(1,1,1), TextXAlignment = Enum.TextXAlignment.Left})
local hitboxSizeInput = mk("TextBox", hitboxScroll, {Size = UDim2.new(0.45,0,0,25), Position = UDim2.new(0.5,0,0,210), BackgroundColor3 = Color3.fromRGB(50,50,50), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSans, TextSize = 14, Text = "20", PlaceholderText = "5-50"})
cr(hitboxSizeInput)
local hitboxCloseButton = mk("TextButton", hitboxSettingsFrame, {Size = UDim2.new(0.9,0,0,25), Position = UDim2.new(0.05,0,1,-30), BackgroundColor3 = Color3.fromRGB(60,60,60), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 14, Text = "Close Menu"})
cr(hitboxCloseButton)

local teleportFrame = mk("Frame", sg, {Size = UDim2.new(0, 200, 0, 300), Position = UDim2.new(0.5, -100, 0.5, -150), BackgroundColor3 = Color3.fromRGB(25,25,25), BorderSizePixel = 0, Visible = false, Active = true})
cr(teleportFrame, 12)
mk("TextLabel", teleportFrame, {Size = UDim2.new(1,0,0,30), BackgroundTransparency = 1, Text = "Teleport to players", Font = Enum.Font.SourceSansBold, TextSize = 16, TextColor3 = Color3.new(1,1,1)})
local backButton = mk("TextButton", teleportFrame, {Size = UDim2.new(0.9,0,0,25), Position = UDim2.new(0.05,0,1,-30), BackgroundColor3 = Color3.fromRGB(60,60,60), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 14, Text = "← Back"})
cr(backButton)
local teleportScroll = mk("ScrollingFrame", teleportFrame, {Size = UDim2.new(1,0,1,-65), Position = UDim2.new(0,0,0,35), BackgroundTransparency = 1, ScrollBarThickness = 6, CanvasSize = UDim2.new(0,0,0,0)})

local scrollFrame = mk("ScrollingFrame", frame, {Size = UDim2.new(1,0,1,-60), Position = UDim2.new(0,0,0,30), BackgroundTransparency = 1, ScrollBarThickness = 6, CanvasSize = UDim2.new(0,0,0,1000)})
local titleLabel = mk("TextLabel", frame, {Size = UDim2.new(1,0,0,30), BackgroundTransparency = 1, Text = "Smile Mod Menu", Font = Enum.Font.SourceSansBold, TextSize = 20, TextColor3 = Color3.new(1,1,1)})

local function mkBtn(t, y, pr)
    local b = mk("TextButton", pr or scrollFrame, {Size = UDim2.new(0.9,0,0,30), Position = UDim2.new(0.05,0,0,y), BackgroundColor3 = Color3.fromRGB(40,40,40), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 16, Text = t})
    cr(b, 8)
    return b
end

local teleportButton = mkBtn("Teleport", 10)
local aimButton = mkBtn("AIM: OFF", 50)
aimButton.Size = UDim2.new(0.75,-5,0,30)
local aimSettingsOpenButton = mk("TextButton", scrollFrame, {Size = UDim2.new(0.15,-5,0,30), Position = UDim2.new(0.8,0,0,50), BackgroundColor3 = Color3.fromRGB(0,150,255), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 18, Text = "+"})
cr(aimSettingsOpenButton)
local espButton = mkBtn("ESP: OFF", 90)
espButton.Size = UDim2.new(0.75,-5,0,30)
local espSettingsOpenButton = mk("TextButton", scrollFrame, {Size = UDim2.new(0.15,-5,0,30), Position = UDim2.new(0.8,0,0,90), BackgroundColor3 = Color3.fromRGB(0,150,255), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 18, Text = "+"})
cr(espSettingsOpenButton)
local charmsButton = mkBtn("Charms: OFF", 130)
charmsButton.Size = UDim2.new(0.75,-5,0,30)
local charmsSettingsOpenButton = mk("TextButton", scrollFrame, {Size = UDim2.new(0.15,-5,0,30), Position = UDim2.new(0.8,0,0,130), BackgroundColor3 = Color3.fromRGB(0,150,255), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 18, Text = "+"})
cr(charmsSettingsOpenButton)
local infiniteJumpButton = mkBtn("Infinite Jump: OFF", 170)
local noclipButton = mkBtn("Noclip: OFF", 210)
local bunnyHopButton = mkBtn("BunnyHop: OFF", 250)
local skyButton = mkBtn("Sky: Default", 290)
local chaosButton = mkBtn("Chaos: OFF", 330)
local thirdPersonButton = mkBtn("Third Person: OFF", 370)
local wallHopButton = mkBtn("Wall Hop: OFF", 410)
local hitboxButton = mkBtn("Hitbox: OFF", 450)
hitboxButton.Size = UDim2.new(0.75,-5,0,30)
local hitboxSettingsOpenButton = mk("TextButton", scrollFrame, {Size = UDim2.new(0.15,-5,0,30), Position = UDim2.new(0.8,0,0,450), BackgroundColor3 = Color3.fromRGB(0,150,255), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 18, Text = "+"})
cr(hitboxSettingsOpenButton)
local fullbrightButton = mkBtn("Fullbright: OFF", 490)
local godModeButton = mkBtn("God Mode: OFF", 530)
local fpsBoostButton = mkBtn("FPS Boost: OFF", 570)
local antiAfkButton = mkBtn("Anti AFK: OFF", 610)
local configButton = mkBtn("⚙️ Config", 650)

mk("TextLabel", scrollFrame, {Size = UDim2.new(0.4,0,0,25), Position = UDim2.new(0.05,0,0,695), BackgroundTransparency = 1, Text = "Fly Speed:", Font = Enum.Font.SourceSansBold, TextSize = 14, TextColor3 = Color3.new(1,1,1), TextXAlignment = Enum.TextXAlignment.Left})
local flyInput = mk("TextBox", scrollFrame, {Size = UDim2.new(0.45,0,0,25), Position = UDim2.new(0.5,0,0,695), BackgroundColor3 = Color3.fromRGB(50,50,50), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSans, TextSize = 14, Text = "50"})
cr(flyInput)
local flyButton = mkBtn("Fly: OFF", 725)
mk("TextLabel", scrollFrame, {Size = UDim2.new(0.4,0,0,25), Position = UDim2.new(0.05,0,0,765), BackgroundTransparency = 1, Text = "Speed:", Font = Enum.Font.SourceSansBold, TextSize = 14, TextColor3 = Color3.new(1,1,1), TextXAlignment = Enum.TextXAlignment.Left})
local speedInput = mk("TextBox", scrollFrame, {Size = UDim2.new(0.45,0,0,25), Position = UDim2.new(0.5,0,0,765), BackgroundColor3 = Color3.fromRGB(50,50,50), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSans, TextSize = 14, Text = "16"})
cr(speedInput)
local sliderFrame = mk("Frame", scrollFrame, {Size = UDim2.new(0.9,0,0,15), Position = UDim2.new(0.05,0,0,795), BackgroundColor3 = Color3.fromRGB(20,20,20), BorderSizePixel = 0})
cr(sliderFrame)
local sliderButton = mk("Frame", sliderFrame, {Size = UDim2.new(0,20,0,20), Position = UDim2.new(0,-2,0,-2.5), BackgroundColor3 = Color3.fromRGB(0,255,0), BorderSizePixel = 0})
cr(sliderButton, 100)
local speedButton = mkBtn("Speed: OFF", 820)
mk("TextLabel", scrollFrame, {Size = UDim2.new(0.4,0,0,25), Position = UDim2.new(0.05,0,0,860), BackgroundTransparency = 1, Text = "FOV:", Font = Enum.Font.SourceSansBold, TextSize = 14, TextColor3 = Color3.new(1,1,1), TextXAlignment = Enum.TextXAlignment.Left})
local fovInput = mk("TextBox", scrollFrame, {Size = UDim2.new(0.45,0,0,25), Position = UDim2.new(0.5,0,0,860), BackgroundColor3 = Color3.fromRGB(50,50,50), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSans, TextSize = 14, Text = "70"})
cr(fovInput)
local fovSliderFrame = mk("Frame", scrollFrame, {Size = UDim2.new(0.9,0,0,15), Position = UDim2.new(0.05,0,0,890), BackgroundColor3 = Color3.fromRGB(20,20,20), BorderSizePixel = 0})
cr(fovSliderFrame)
local fovSliderButton = mk("Frame", fovSliderFrame, {Size = UDim2.new(0,20,0,20), Position = UDim2.new(0.44,-10,0,-2.5), BackgroundColor3 = Color3.fromRGB(255,100,0), BorderSizePixel = 0})
cr(fovSliderButton, 100)
local fovButton = mkBtn("FOV: OFF", 915)

local minimizeButton = mk("TextButton", frame, {Size = UDim2.new(0.9,0,0,25), Position = UDim2.new(0.05,0,1,-30), Text = "Minimize menu", TextColor3 = Color3.new(1,1,1), BackgroundColor3 = Color3.fromRGB(200,50,50), BorderSizePixel = 0, Font = Enum.Font.SourceSansBold, TextSize = 14})
cr(minimizeButton)
local minimizedCircle = mk("TextButton", sg, {Size = UDim2.new(0,30,0,30), Position = UDim2.new(0,300,0,200), Text = "", BackgroundColor3 = Color3.fromRGB(255,0,0), BorderSizePixel = 0, Visible = false, AnchorPoint = Vector2.new(0.5,0.5)})
cr(minimizedCircle, 100)

local configFrame = mk("Frame", sg, {Size = UDim2.new(0, 230, 0, 370), Position = UDim2.new(0.5, -115, 0.5, -170), BackgroundColor3 = Color3.fromRGB(25,25,25), BorderSizePixel = 0, Visible = false, Active = true})
cr(configFrame, 12)

local playerSelectFrame = mk("Frame", sg, {Size = UDim2.new(0, 180, 0, 280), Position = UDim2.new(0.5, 110, 0.3, 0), BackgroundColor3 = Color3.fromRGB(25,25,25), BorderSizePixel = 0, Visible = false, Active = true})
cr(playerSelectFrame, 12)
mk("TextLabel", playerSelectFrame, {Size = UDim2.new(1,0,0,30), BackgroundTransparency = 1, Text = "Val Check Players", Font = Enum.Font.SourceSansBold, TextSize = 15, TextColor3 = Color3.new(1,1,1)})
local playerSelectScroll = mk("ScrollingFrame", playerSelectFrame, {Size = UDim2.new(1,0,1,-65), Position = UDim2.new(0,0,0,35), BackgroundTransparency = 1, ScrollBarThickness = 5, CanvasSize = UDim2.new(0,0,0,0)})
local playerSelectClose = mk("TextButton", playerSelectFrame, {Size = UDim2.new(0.9,0,0,25), Position = UDim2.new(0.05,0,1,-30), BackgroundColor3 = Color3.fromRGB(60,60,60), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 14, Text = "Close"})
cr(playerSelectClose)

local aimValCheckFrame = mk("Frame", sg, {Size = UDim2.new(0, 180, 0, 280), Position = UDim2.new(0.5, 110, 0.3, 0), BackgroundColor3 = Color3.fromRGB(25,25,25), BorderSizePixel = 0, Visible = false, Active = true})
cr(aimValCheckFrame, 12)
mk("TextLabel", aimValCheckFrame, {Size = UDim2.new(1,0,0,30), BackgroundTransparency = 1, Text = "AIM Players", Font = Enum.Font.SourceSansBold, TextSize = 15, TextColor3 = Color3.new(1,1,1)})
local aimValCheckScroll = mk("ScrollingFrame", aimValCheckFrame, {Size = UDim2.new(1,0,1,-65), Position = UDim2.new(0,0,0,35), BackgroundTransparency = 1, ScrollBarThickness = 5, CanvasSize = UDim2.new(0,0,0,0)})
local aimValCheckClose = mk("TextButton", aimValCheckFrame, {Size = UDim2.new(0.9,0,0,25), Position = UDim2.new(0.05,0,1,-30), BackgroundColor3 = Color3.fromRGB(60,60,60), TextColor3 = Color3.new(1,1,1), Font = Enum.Font.SourceSansBold, TextSize = 14, Text = "Close"})
cr(aimValCheckClose)

local mobileGui = mk("Frame", sg, {Size = UDim2.new(0, 160, 0, 95), Position = UDim2.new(0, 20, 1, -160), BackgroundColor3 = Color3.fromRGB(25,25,35), BorderSizePixel = 0, Visible = false, Active = true})
cr(mobileGui, 8)
local mobileWBtn = mk("TextButton", mobileGui, {Size = UDim2.new(0,40,0,40), Position = UDim2.new(0,60,0,5), BackgroundColor3 = Color3.fromRGB(40,40,60), Text = "W", TextColor3 = Color3.new(1,1,1), TextSize = 16, Font = Enum.Font.GothamBold})
cr(mobileWBtn)
local mobileABtn = mk("TextButton", mobileGui, {Size = UDim2.new(0,40,0,40), Position = UDim2.new(0,10,0,50), BackgroundColor3 = Color3.fromRGB(40,40,60), Text = "A", TextColor3 = Color3.new(1,1,1), TextSize = 16, Font = Enum.Font.GothamBold})
cr(mobileABtn)
local mobileSBtn = mk("TextButton", mobileGui, {Size = UDim2.new(0,40,0,40), Position = UDim2.new(0,60,0,50), BackgroundColor3 = Color3.fromRGB(40,40,60), Text = "S", TextColor3 = Color3.new(1,1,1), TextSize = 16, Font = Enum.Font.GothamBold})
cr(mobileSBtn)
local mobileDBtn = mk("TextButton", mobileGui, {Size = UDim2.new(0,40,0,40), Position = UDim2.new(0,110,0,50), BackgroundColor3 = Color3.fromRGB(40,40,60), Text = "D", TextColor3 = Color3.new(1,1,1), TextSize = 16, Font = Enum.Font.GothamBold})
cr(mobileDBtn)
local mobileSpaceFrame = mk("Frame", sg, {Size = UDim2.new(0, 70, 0, 70), Position = UDim2.new(1, -90, 1, -90), BackgroundColor3 = Color3.fromRGB(40,40,60), BorderSizePixel = 0, Visible = false})
cr(mobileSpaceFrame, 100)
mk("TextLabel", mobileSpaceFrame, {Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Text = "SPACE", TextColor3 = Color3.new(1,1,1), Font = Enum.Font.GothamBold, TextSize = 12})

-- Continuous name rotation
task.spawn(function()
    while task.wait(math.random(1,3)) do
        pcall(function() sg.Name = n() end)
    end
end)

return {
    screenGui = sg, frame = frame, teleportFrame = teleportFrame, aimSettingsFrame = aimSettingsFrame,
    hitboxSettingsFrame = hitboxSettingsFrame, configFrame = configFrame, minimizedCircle = minimizedCircle,
    teleportButton = teleportButton, aimButton = aimButton, espButton = espButton, charmsButton = charmsButton,
    infiniteJumpButton = infiniteJumpButton, noclipButton = noclipButton, bunnyHopButton = bunnyHopButton,
    skyButton = skyButton, chaosButton = chaosButton, thirdPersonButton = thirdPersonButton,
    wallHopButton = wallHopButton, hitboxButton = hitboxButton, fullbrightButton = fullbrightButton,
    godModeButton = godModeButton, fpsBoostButton = fpsBoostButton, antiAfkButton = antiAfkButton,
    configButton = configButton, flyButton = flyButton, speedButton = speedButton, fovButton = fovButton,
    minimizeButton = minimizeButton, flyInput = flyInput, speedInput = speedInput, fovInput = fovInput,
    aimFOVInput = aimFOVInput, smoothInput = smoothInput, hitboxSizeInput = hitboxSizeInput,
    sliderFrame = sliderFrame, sliderButton = sliderButton, fovSliderFrame = fovSliderFrame,
    fovSliderButton = fovSliderButton, aimFOVSliderFrame = aimFOVSliderFrame, aimFOVSliderButton = aimFOVSliderButton,
    smoothSliderFrame = smoothSliderFrame, smoothSliderButton = smoothSliderButton,
    fovCircleButton = fovCircleButton, wallButton = wallButton, teamCheckButton = teamCheckButton,
    silentAimButton = silentAimButton, smoothButton = smoothButton, aimValCheckButton = aimValCheckButton,
    pcTriggerButton = pcTriggerButton, mobileTriggerButton = mobileTriggerButton,
    valCheckButton = valCheckButton, triggerWallCheckButton = triggerWallCheckButton,
    triggerTeamCheckButton = triggerTeamCheckButton, aimCloseButton = aimCloseButton,
    espVisColorBtn = espVisColorBtn, espUnvisColorBtn = espUnvisColorBtn, espTracerBtn = espTracerBtn,
    espBoxBtn = espBoxBtn, espNameBtn = espNameBtn, espHealthBtn = espHealthBtn, espDistBtn = espDistBtn,
    espTeamCheckBtn = espTeamCheckBtn, espValCheckBtn = espValCheckBtn, espSettingsCloseBtn = espSettingsCloseBtn,
    charmsVisBtn = charmsVisBtn, charmsUnvisBtn = charmsUnvisBtn, charmsNpcButton = charmsNpcButton,
    charmsEspObjButton = charmsEspObjButton, charmsSettingsCloseBtn = charmsSettingsCloseBtn,
    hitboxHeadButton = hitboxHeadButton, hitboxTorsoButton = hitboxTorsoButton,
    hitboxArmsButton = hitboxArmsButton, hitboxLegsButton = hitboxLegsButton, hitboxCloseButton = hitboxCloseButton,
    backButton = backButton, playerSelectClose = playerSelectClose, aimValCheckClose = aimValCheckClose,
    espValCheckClose = espValCheckClose, espColorPickerClose = espColorPickerClose,
    charmsColorPickerClose = charmsColorPickerClose,
    teleportScroll = teleportScroll, aimScroll = aimScroll, espScroll = espScroll, charmsScroll = charmsScroll,
    hitboxScroll = hitboxScroll, playerSelectScroll = playerSelectScroll, aimValCheckScroll = aimValCheckScroll,
    espValCheckScroll = espValCheckScroll,
    playerSelectFrame = playerSelectFrame, aimValCheckFrame = aimValCheckFrame,
    espValCheckFrame = espValCheckFrame, espColorPickerFrame = espColorPickerFrame,
    charmsColorPickerFrame = charmsColorPickerFrame, charmsSettingsFrame = charmsSettingsFrame,
    espSettingsFrame = espSettingsFrame,
    aimSettingsOpenButton = aimSettingsOpenButton, espSettingsOpenButton = espSettingsOpenButton,
    charmsSettingsOpenButton = charmsSettingsOpenButton, hitboxSettingsOpenButton = hitboxSettingsOpenButton,
    espVisColorOpenBtn = espVisColorOpenBtn, espUnvisColorOpenBtn = espUnvisColorOpenBtn,
    charmsVisColorOpenBtn = charmsVisColorOpenBtn, charmsUnvisColorOpenBtn = charmsUnvisColorOpenBtn,
    valCheckOpenButton = valCheckOpenButton, aimValCheckOpenButton = aimValCheckOpenButton,
    espValCheckOpenBtn = espValCheckOpenBtn,
    espRSlider = espRSlider, espRHandle = espRHandle, espGSlider = espGSlider, espGHandle = espGHandle,
    espBSlider = espBSlider, espBHandle = espBHandle, espColorPreview = espColorPreview,
    charmsRSlider = charmsRSlider, charmsRHandle = charmsRHandle, charmsGSlider = charmsGSlider,
    charmsGHandle = charmsGHandle, charmsBSlider = charmsBSlider, charmsBHandle = charmsBHandle,
    charmsColorPreview = charmsColorPreview,
    titleLabel = titleLabel,
    mobileGui = mobileGui, mobileWBtn = mobileWBtn, mobileABtn = mobileABtn,
    mobileSBtn = mobileSBtn, mobileDBtn = mobileDBtn, mobileSpaceFrame = mobileSpaceFrame
}
