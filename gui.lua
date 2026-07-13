-- ============================================================
--   gui.lua — ПОВНЕ ВИПРАВЛЕНА ВЕРСІЯ (без pcall для критичних речей)
-- ============================================================
local _c = "abcdefghijklmnopqrstuvwxyz0123456789"
local _tag = ""
for _ = 1, 8 do _tag = _tag .. _c:sub(math.random(1, #_c), math.random(1, #_c)) end

local function n(l)
    l = l or math.random(10, 18)
    local r = ""
    for _ = 1, l do r = r .. _c:sub(math.random(1, #_c), math.random(1, #c)) end
    return r
end

-- Створюємо елемент БЕЗ pcall - щоб бачити помилки
local function mk(cl, pr, props)
    local i = Instance.new(cl, pr)
    i.Name = n()
    if props then
        for k, v in pairs(props) do
            i[k] = v
        end
    end
    return i
end

local function cr(pr, r)
    return mk("UICorner", pr, {CornerRadius = UDim.new(0, r or 8)})
end

-- CoreGui hook
if hookfunction then
    local ok, err = pcall(function()
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local old = mt.__index.GetChildren
        mt.__index.GetChildren = function(self, ...)
            local ch = old(self, ...)
            if self == game:GetService("CoreGui") then
                local f = {}
                for _, c in ipairs(ch) do
                    if not c:GetAttribute(_tag) then
                        table.insert(f, c)
                    end
                end
                return f
            end
            return ch
        end
        setreadonly(mt, true)
    end)
    if not ok then
        warn("[GUI] hookfunction failed: " .. tostring(err))
    end
end

-- Створюємо ScreenGui
local sg = Instance.new("ScreenGui")
sg.Name = n()
sg.ResetOnSpawn = false
sg.DisplayOrder = math.random(1, 50)
sg.IgnoreGuiInset = true
sg.Parent = game:GetService("CoreGui")
sg:SetAttribute(_tag, true)

print("[GUI] ScreenGui created: " .. sg.Name)

-- Створюємо Frame
local frame = Instance.new("Frame")
frame.Name = n()
frame.Size = UDim2.new(0, 180, 0, 230)
frame.Position = UDim2.new(0.5, -90, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = sg
cr(frame, 12)
print("[GUI] Main frame created: " .. frame.Name)

-- AIM Settings
local aimSettingsFrame = Instance.new("Frame")
aimSettingsFrame.Name = n()
aimSettingsFrame.Size = UDim2.new(0, 200, 0, 220)
aimSettingsFrame.Position = UDim2.new(0.5, 100, 0.3, 0)
aimSettingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
aimSettingsFrame.BorderSizePixel = 0
aimSettingsFrame.Visible = false
aimSettingsFrame.Active = true
aimSettingsFrame.Parent = sg
cr(aimSettingsFrame, 12)

local title1 = Instance.new("TextLabel")
title1.Size = UDim2.new(1, 0, 0, 30)
title1.BackgroundTransparency = 1
title1.Text = "AIM Settings"
title1.Font = Enum.Font.SourceSansBold
title1.TextSize = 16
title1.TextColor3 = Color3.new(1, 1, 1)
title1.Parent = aimSettingsFrame

local aimScroll = Instance.new("ScrollingFrame")
aimScroll.Name = n()
aimScroll.Size = UDim2.new(1, 0, 1, -65)
aimScroll.Position = UDim2.new(0, 0, 0, 30)
aimScroll.BackgroundTransparency = 1
aimScroll.ScrollBarThickness = 5
aimScroll.CanvasSize = UDim2.new(0, 0, 0, 550)
aimScroll.Parent = aimSettingsFrame

-- ESP Settings
local espSettingsFrame = Instance.new("Frame")
espSettingsFrame.Name = n()
espSettingsFrame.Size = UDim2.new(0, 210, 0, 260)
espSettingsFrame.Position = UDim2.new(0.5, 100, 0.3, 0)
espSettingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
espSettingsFrame.BorderSizePixel = 0
espSettingsFrame.Visible = false
espSettingsFrame.Active = true
espSettingsFrame.Parent = sg
cr(espSettingsFrame, 12)

local espColorPickerFrame = Instance.new("Frame")
espColorPickerFrame.Name = n()
espColorPickerFrame.Size = UDim2.new(0, 200, 0, 200)
espColorPickerFrame.Position = UDim2.new(0.5, 320, 0.3, 0)
espColorPickerFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
espColorPickerFrame.BorderSizePixel = 0
espColorPickerFrame.Visible = false
espColorPickerFrame.Active = true
espColorPickerFrame.Parent = sg
cr(espColorPickerFrame, 12)

local espColorPickerTitle = Instance.new("TextLabel")
espColorPickerTitle.Size = UDim2.new(1, 0, 0, 25)
espColorPickerTitle.BackgroundTransparency = 1
espColorPickerTitle.Text = "Pick Color"
espColorPickerTitle.Font = Enum.Font.SourceSansBold
espColorPickerTitle.TextSize = 14
espColorPickerTitle.TextColor3 = Color3.new(1, 1, 1)
espColorPickerTitle.Name = "espColorPickerTitle"
espColorPickerTitle.Parent = espColorPickerFrame

-- Charms Settings
local charmsSettingsFrame = Instance.new("Frame")
charmsSettingsFrame.Name = n()
charmsSettingsFrame.Size = UDim2.new(0, 210, 0, 220)
charmsSettingsFrame.Position = UDim2.new(0.5, 100, 0.3, 0)
charmsSettingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
charmsSettingsFrame.BorderSizePixel = 0
charmsSettingsFrame.Visible = false
charmsSettingsFrame.Active = true
charmsSettingsFrame.Parent = sg
cr(charmsSettingsFrame, 12)

local charmsTitle = Instance.new("TextLabel")
charmsTitle.Size = UDim2.new(1, 0, 0, 30)
charmsTitle.BackgroundTransparency = 1
charmsTitle.Text = "Charms Settings"
charmsTitle.Font = Enum.Font.SourceSansBold
charmsTitle.TextSize = 16
charmsTitle.TextColor3 = Color3.new(1, 1, 1)
charmsTitle.Parent = charmsSettingsFrame

local charmsScroll = Instance.new("ScrollingFrame")
charmsScroll.Name = n()
charmsScroll.Size = UDim2.new(1, 0, 1, -60)
charmsScroll.Position = UDim2.new(0, 0, 0, 30)
charmsScroll.BackgroundTransparency = 1
charmsScroll.ScrollBarThickness = 5
charmsScroll.CanvasSize = UDim2.new(0, 0, 0, 160)
charmsScroll.Parent = charmsSettingsFrame

-- Charms buttons
local charmsVisBtn = Instance.new("TextButton")
charmsVisBtn.Size = UDim2.new(0.75, -5, 0, 30)
charmsVisBtn.Position = UDim2.new(0.05, 0, 0, 5)
charmsVisBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
charmsVisBtn.TextColor3 = Color3.new(0, 0, 0)
charmsVisBtn.Font = Enum.Font.SourceSansBold
charmsVisBtn.TextSize = 13
charmsVisBtn.Text = "Visible"
charmsVisBtn.Parent = charmsScroll
cr(charmsVisBtn)

local charmsVisColorOpenBtn = Instance.new("TextButton")
charmsVisColorOpenBtn.Size = UDim2.new(0.15, -5, 0, 30)
charmsVisColorOpenBtn.Position = UDim2.new(0.8, 0, 0, 5)
charmsVisColorOpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
charmsVisColorOpenBtn.TextColor3 = Color3.new(1, 1, 1)
charmsVisColorOpenBtn.Font = Enum.Font.SourceSansBold
charmsVisColorOpenBtn.TextSize = 18
charmsVisColorOpenBtn.Text = "+"
charmsVisColorOpenBtn.Parent = charmsScroll
cr(charmsVisColorOpenBtn)

local charmsUnvisBtn = Instance.new("TextButton")
charmsUnvisBtn.Size = UDim2.new(0.75, -5, 0, 30)
charmsUnvisBtn.Position = UDim2.new(0.05, 0, 0, 45)
charmsUnvisBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
charmsUnvisBtn.TextColor3 = Color3.new(1, 1, 1)
charmsUnvisBtn.Font = Enum.Font.SourceSansBold
charmsUnvisBtn.TextSize = 13
charmsUnvisBtn.Text = "Unvisible"
charmsUnvisBtn.Parent = charmsScroll
cr(charmsUnvisBtn)

local charmsUnvisColorOpenBtn = Instance.new("TextButton")
charmsUnvisColorOpenBtn.Size = UDim2.new(0.15, -5, 0, 30)
charmsUnvisColorOpenBtn.Position = UDim2.new(0.8, 0, 0, 45)
charmsUnvisColorOpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
charmsUnvisColorOpenBtn.TextColor3 = Color3.new(1, 1, 1)
charmsUnvisColorOpenBtn.Font = Enum.Font.SourceSansBold
charmsUnvisColorOpenBtn.TextSize = 18
charmsUnvisColorOpenBtn.Text = "+"
charmsUnvisColorOpenBtn.Parent = charmsScroll
cr(charmsUnvisColorOpenBtn)

local charmsNpcButton = Instance.new("TextButton")
charmsNpcButton.Size = UDim2.new(0.9, 0, 0, 30)
charmsNpcButton.Position = UDim2.new(0.05, 0, 0, 85)
charmsNpcButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
charmsNpcButton.TextColor3 = Color3.new(1, 1, 1)
charmsNpcButton.Font = Enum.Font.SourceSansBold
charmsNpcButton.TextSize = 14
charmsNpcButton.Text = "NPC: OFF"
charmsNpcButton.Parent = charmsScroll
cr(charmsNpcButton)

local charmsEspObjButton = Instance.new("TextButton")
charmsEspObjButton.Size = UDim2.new(0.9, 0, 0, 30)
charmsEspObjButton.Position = UDim2.new(0.05, 0, 0, 125)
charmsEspObjButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
charmsEspObjButton.TextColor3 = Color3.new(1, 1, 1)
charmsEspObjButton.Font = Enum.Font.SourceSansBold
charmsEspObjButton.TextSize = 14
charmsEspObjButton.Text = "ESP Objects: OFF"
charmsEspObjButton.Parent = charmsScroll
cr(charmsEspObjButton)

local charmsSettingsCloseBtn = Instance.new("TextButton")
charmsSettingsCloseBtn.Size = UDim2.new(0.9, 0, 0, 25)
charmsSettingsCloseBtn.Position = UDim2.new(0.05, 0, 1, -30)
charmsSettingsCloseBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
charmsSettingsCloseBtn.TextColor3 = Color3.new(1, 1, 1)
charmsSettingsCloseBtn.Font = Enum.Font.SourceSansBold
charmsSettingsCloseBtn.TextSize = 14
charmsSettingsCloseBtn.Text = "Close"
charmsSettingsCloseBtn.Parent = charmsSettingsFrame
cr(charmsSettingsCloseBtn)

-- Charms Color Picker
local charmsColorPickerFrame = Instance.new("Frame")
charmsColorPickerFrame.Name = n()
charmsColorPickerFrame.Size = UDim2.new(0, 200, 0, 200)
charmsColorPickerFrame.Position = UDim2.new(0.5, 320, 0.3, 0)
charmsColorPickerFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
charmsColorPickerFrame.BorderSizePixel = 0
charmsColorPickerFrame.Visible = false
charmsColorPickerFrame.Active = true
charmsColorPickerFrame.Parent = sg
cr(charmsColorPickerFrame, 12)

local charmsColorPickerTitle = Instance.new("TextLabel")
charmsColorPickerTitle.Size = UDim2.new(1, 0, 0, 25)
charmsColorPickerTitle.BackgroundTransparency = 1
charmsColorPickerTitle.Text = "Pick Color"
charmsColorPickerTitle.Font = Enum.Font.SourceSansBold
charmsColorPickerTitle.TextSize = 14
charmsColorPickerTitle.TextColor3 = Color3.new(1, 1, 1)
charmsColorPickerTitle.Parent = charmsColorPickerFrame

-- Charms sliders
local charsRSlider = Instance.new("Frame")
charmsRSlider.Name = n()
charmsRSlider.Size = UDim2.new(0.9, 0, 0, 15)
charmsRSlider.Position = UDim2.new(0.05, 0, 0, 35)
charmsRSlider.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
charmsRSlider.BorderSizePixel = 0
charmsRSlider.Parent = charmsColorPickerFrame
cr(charmsRSlider)

local charmsRHandle = Instance.new("Frame")
charmsRHandle.Size = UDim2.new(0, 14, 1, 0)
charmsRHandle.Position = UDim2.new(1, -7, 0, 0)
charmsRHandle.ZIndex = 5
charmsRHandle.BackgroundColor3 = Color3.new(1, 1, 1)
charmsRHandle.BorderSizePixel = 0
charmsRHandle.Parent = charmsRSlider
cr(charmsRHandle, 100)

local charmsGSlider = Instance.new("Frame")
charmsGSlider.Name = n()
charmsGSlider.Size = UDim2.new(0.9, 0, 0, 15)
charmsGSlider.Position = UDim2.new(0.05, 0, 0, 65)
charmsGSlider.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
charmsGSlider.BorderSizePixel = 0
charmsGSlider.Parent = charmsColorPickerFrame
cr(charmsGSlider)

local charmsGHandle = Instance.new("Frame")
charmsGHandle.Size = UDim2.new(0, 14, 1, 0)
charmsGHandle.Position = UDim2.new(0, -7, 0, 0)
charmsGHandle.ZIndex = 5
charmsGHandle.BackgroundColor3 = Color3.new(1, 1, 1)
charmsGHandle.BorderSizePixel = 0
charmsGHandle.Parent = charmsGSlider
cr(charmsGHandle, 100)

local charmsBSlider = Instance.new("Frame")
charmsBSlider.Name = n()
charmsBSlider.Size = UDim2.new(0.9, 0, 0, 15)
charmsBSlider.Position = UDim2.new(0.05, 0, 0, 95)
charmsBSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
charmsBSlider.BorderSizePixel = 0
charmsBSlider.Parent = charmsColorPickerFrame
cr(charmsBSlider)

local charmsBHandle = Instance.new("Frame")
charmsBHandle.Size = UDim2.new(0, 14, 1, 0)
charmsBHandle.Position = UDim2.new(0, -7, 0, 0)
charmsBHandle.ZIndex = 5
charmsBHandle.BackgroundColor3 = Color3.new(1, 1, 1)
charmsBHandle.BorderSizePixel = 0
charmsBHandle.Parent = charmsBSlider
cr(charmsBHandle, 100)

local charmsColorPreview = Instance.new("Frame")
charmsColorPreview.Name = n()
charmsColorPreview.Size = UDim2.new(0.9, 0, 0, 25)
charmsColorPreview.Position = UDim2.new(0.05, 0, 0, 120)
charmsColorPreview.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
charmsColorPreview.BorderSizePixel = 0
charmsColorPreview.Parent = charmsColorPickerFrame
cr(charmsColorPreview)

local charmsColorPickerClose = Instance.new("TextButton")
charmsColorPickerClose.Size = UDim2.new(0.9, 0, 0, 25)
charmsColorPickerClose.Position = UDim2.new(0.05, 0, 1, -30)
charmsColorPickerClose.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
charmsColorPickerClose.TextColor3 = Color3.new(1, 1, 1)
charmsColorPickerClose.Font = Enum.Font.SourceSansBold
charmsColorPickerClose.TextSize = 14
charmsColorPickerClose.Text = "← Back"
charmsColorPickerClose.Parent = charmsColorPickerFrame
cr(charmsColorPickerClose)

-- ESP Color Picker sliders
local espRSlider = Instance.new("Frame")
espRSlider.Name = n()
espRSlider.Size = UDim2.new(0.9, 0, 0, 15)
espRSlider.Position = UDim2.new(0.05, 0, 0, 35)
espRSlider.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
espRSlider.BorderSizePixel = 0
espRSlider.Parent = espColorPickerFrame
cr(espRSlider)

local espRHandle = Instance.new("Frame")
espRHandle.Size = UDim2.new(0, 18, 0, 18)
espRHandle.Position = UDim2.new(1, -9, 0, -1.5)
espRHandle.BackgroundColor3 = Color3.new(1, 1, 1)
espRHandle.BorderSizePixel = 0
espRHandle.Parent = espRSlider
cr(espRHandle, 100)

local espGSlider = Instance.new("Frame")
espGSlider.Name = n()
espGSlider.Size = UDim2.new(0.9, 0, 0, 15)
espGSlider.Position = UDim2.new(0.05, 0, 0, 65)
espGSlider.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
espGSlider.BorderSizePixel = 0
espGSlider.Parent = espColorPickerFrame
cr(espGSlider)

local espGHandle = Instance.new("Frame")
espGHandle.Size = UDim2.new(0, 18, 0, 18)
espGHandle.Position = UDim2.new(0, -9, 0, -1.5)
espGHandle.BackgroundColor3 = Color3.new(1, 1, 1)
espGHandle.BorderSizePixel = 0
espGHandle.Parent = espGSlider
cr(espGHandle, 100)

local espBSlider = Instance.new("Frame")
espBSlider.Name = n()
espBSlider.Size = UDim2.new(0.9, 0, 0, 15)
espBSlider.Position = UDim2.new(0.05, 0, 0, 95)
espBSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
espBSlider.BorderSizePixel = 0
espBSlider.Parent = espColorPickerFrame
cr(espBSlider)

local espBHandle = Instance.new("Frame")
espBHandle.Size = UDim2.new(0, 18, 0, 18)
espBHandle.Position = UDim2.new(0, -9, 0, -1.5)
espBHandle.BackgroundColor3 = Color3.new(1, 1, 1)
espBHandle.BorderSizePixel = 0
espBHandle.Parent = espBSlider
cr(espBHandle, 100)

local espColorPreview = Instance.new("Frame")
espColorPreview.Name = n()
espColorPreview.Size = UDim2.new(0.9, 0, 0, 25)
espColorPreview.Position = UDim2.new(0.05, 0, 0, 120)
espColorPreview.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
espColorPreview.BorderSizePixel = 0
espColorPreview.Parent = espColorPickerFrame
cr(espColorPreview)

local espColorPickerClose = Instance.new("TextButton")
espColorPickerClose.Name = n()
espColorPickerClose.Size = UDim2.new(0.9, 0, 0, 25)
espColorPickerClose.Position = UDim2.new(0.05, 0, 1, -30)
espColorPickerClose.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espColorPickerClose.TextColor3 = Color3.new(1, 1, 1)
espColorPickerClose.Font = Enum.Font.SourceSansBold
espColorPickerClose.TextSize = 14
espColorPickerClose.Text = "← Back"
espColorPickerClose.Parent = espColorPickerFrame
cr(espColorPickerClose)

-- ESP Val Check Frame
local espValCheckFrame = Instance.new("Frame")
espValCheckFrame.Name = n()
espValCheckFrame.Size = UDim2.new(0, 180, 0, 280)
espValCheckFrame.Position = UDim2.new(0.5, 320, 0.3, 0)
espValCheckFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
espValCheckFrame.BorderSizePixel = 0
espValCheckFrame.Visible = false
espValCheckFrame.Active = true
espValCheckFrame.Parent = sg
cr(espValCheckFrame, 12)

local espValCheckTitle = Instance.new("TextLabel")
espValCheckTitle.Size = UDim2.new(1, 0, 0, 30)
espValCheckTitle.BackgroundTransparency = 1
espValCheckTitle.Text = "ESP Players"
espValCheckTitle.Font = Enum.Font.SourceSansBold
espValCheckTitle.TextSize = 15
espValCheckTitle.TextColor3 = Color3.new(1, 1, 1)
espValCheckTitle.Parent = espValCheckFrame

local espValCheckScroll = Instance.new("ScrollingFrame")
espValCheckScroll.Name = n()
espValCheckScroll.Size = UDim2.new(1, 0, 1, -65)
espValCheckScroll.Position = UDim2.new(0, 0, 0, 35)
espValCheckScroll.BackgroundTransparency = 1
espValCheckScroll.ScrollBarThickness = 5
espValCheckScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
espValCheckScroll.Parent = espValCheckFrame

local espValCheckClose = Instance.new("TextButton")
espValCheckClose.Name = n()
espValCheckClose.Size = UDim2.new(0.9, 0, 0, 25)
espValCheckClose.Position = UDim2.new(0.05, 0, 1, -30)
espValCheckClose.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espValCheckClose.TextColor3 = Color3.new(1, 1, 1)
espValCheckClose.Font = Enum.Font.SourceSansBold
espValCheckClose.TextSize = 14
espValCheckClose.Text = "Close"
espValCheckClose.Parent = espValCheckFrame
cr(espValCheckClose)

-- ESP Settings Title
local espSettingsTitle = Instance.new("TextLabel")
espSettingsTitle.Size = UDim2.new(1, 0, 0, 30)
espSettingsTitle.BackgroundTransparency = 1
espSettingsTitle.Text = "ESP Settings"
espSettingsTitle.Font = Enum.Font.SourceSansBold
espSettingsTitle.TextSize = 16
espSettingsTitle.TextColor3 = Color3.new(1, 1, 1)
espSettingsTitle.Parent = espSettingsFrame

local espScroll = Instance.new("ScrollingFrame")
espScroll.Name = n()
espScroll.Size = UDim2.new(1, 0, 1, -60)
espScroll.Position = UDim2.new(0, 0, 0, 25)
espScroll.BackgroundTransparency = 1
espScroll.ScrollBarThickness = 5
espScroll.CanvasSize = UDim2.new(0, 0, 0, 360)
espScroll.Parent = espSettingsFrame

-- ESP buttons
local espVisColorBtn = Instance.new("TextButton")
espVisColorBtn.Name = n()
espVisColorBtn.Size = UDim2.new(0.75, -5, 0, 30)
espVisColorBtn.Position = UDim2.new(0.05, 0, 0, 5)
espVisColorBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
espVisColorBtn.TextColor3 = Color3.new(0, 0, 0)
espVisColorBtn.Font = Enum.Font.SourceSansBold
espVisColorBtn.TextSize = 13
espVisColorBtn.Text = "Visible Color"
espVisColorBtn.Parent = espScroll
cr(espVisColorBtn)

local espVisColorOpenBtn = Instance.new("TextButton")
espVisColorOpenBtn.Name = n()
espVisColorOpenBtn.Size = UDim2.new(0.15, -5, 0, 30)
espVisColorOpenBtn.Position = UDim2.new(0.8, 0, 0, 5)
espVisColorOpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
espVisColorOpenBtn.TextColor3 = Color3.new(1, 1, 1)
espVisColorOpenBtn.Font = Enum.Font.SourceSansBold
espVisColorOpenBtn.TextSize = 18
espVisColorOpenBtn.Text = "+"
espVisColorOpenBtn.Parent = espScroll
cr(espVisColorOpenBtn)

local espUnvisColorBtn = Instance.new("TextButton")
espUnvisColorBtn.Name = n()
espUnvisColorBtn.Size = UDim2.new(0.75, -5, 0, 30)
espUnvisColorBtn.Position = UDim2.new(0.05, 0, 0, 45)
espUnvisColorBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
espUnvisColorBtn.TextColor3 = Color3.new(1, 1, 1)
espUnvisColorBtn.Font = Enum.Font.SourceSansBold
espUnvisColorBtn.TextSize = 13
espUnvisColorBtn.Text = "Unvisible Color"
espUnvisColorBtn.Parent = espScroll
cr(espUnvisColorBtn)

local espUnvisColorOpenBtn = Instance.new("TextButton")
espUnvisColorOpenBtn.Name = n()
espUnvisColorOpenBtn.Size = UDim2.new(0.15, -5, 0, 30)
espUnvisColorOpenBtn.Position = UDim2.new(0.8, 0, 0, 45)
espUnvisColorOpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
espUnvisColorOpenBtn.TextColor3 = Color3.new(1, 1, 1)
espUnvisColorOpenBtn.Font = Enum.Font.SourceSansBold
espUnvisColorOpenBtn.TextSize = 18
espUnvisColorOpenBtn.Text = "+"
espUnvisColorOpenBtn.Parent = espScroll
cr(espUnvisColorOpenBtn)

-- Helper for toggle buttons
local function mkT(t, y, pr)
    local b = Instance.new("TextButton", pr or espScroll)
    b.Size = UDim2.new(0.9, 0, 0, 30)
    b.Position = UDim2.new(0.05, 0, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 14
    b.Text = t
    b.Parent = espScroll
    cr(b)
    return b
end

local espTracerBtn = mkT("Tracer: ON", 85)
local espBoxBtn = mkT("Box: ON", 125)
local espNameBtn = mkT("Name: ON", 165)
local espHealthBtn = mkT("Health: ON", 205)
local espDistBtn = mkT("Distance: ON", 245)
local espTeamCheckBtn = mkT("ESP Team Check: OFF", 285)

-- ESP ValCheck button (special size)
local espValCheckBtn = Instance.new("TextButton")
espValCheckBtn.Name = n()
espValCheckBtn.Size = UDim2.new(0.75, -5, 0, 30)
espValCheckBtn.Position = UDim2.new(0.05, 0, 0, 325)
espValCheckBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
espValCheckBtn.TextColor3 = Color3.new(1, 1, 1)
espValCheckBtn.Font = Enum.Font.SourceSansBold
espValCheckBtn.TextSize = 14
espValCheckBtn.Text = "ESP ValCheck: OFF"
espValCheckBtn.Parent = espScroll
cr(espValCheckBtn)

local espValCheckOpenBtn = Instance.new("TextButton")
espValCheckOpenBtn.Name = n()
espValCheckOpenBtn.Size = UDim2.new(0.15, -5, 0, 30)
espValCheckOpenBtn.Position = UDim2.new(0.8, 0, 0, 325)
espValCheckOpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
espValCheckOpenBtn.TextColor3 = Color3.new(1, 1, 1)
espValCheckOpenBtn.Font = Enum.Font.SourceSansBold
espValCheckOpenBtn.TextSize = 18
espValCheckOpenBtn.Text = "+"
espValCheckOpenBtn.Parent = espScroll
cr(espValCheckOpenBtn)

local espSettingsCloseBtn = Instance.new("TextButton")
espSettingsCloseBtn.Name = n()
espSettingsCloseBtn.Size = UDim2.new(0.9, 0, 0, 25)
espSettingsCloseBtn.Position = UDim2.new(0.05, 0, 1, -30)
espSettingsCloseBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espSettingsCloseBtn.TextColor3 = Color3.new(1, 1, 1)
espSettingsCloseBtn.Font = Enum.Font.SourceSansBold
espSettingsCloseBtn.TextSize = 14
espSettingsCloseBtn.Text = "Close"
espSettingsCloseBtn.Parent = espSettingsFrame
cr(espSettingsCloseBtn)

-- AIM buttons
local pcTriggerButton = Instance.new("TextButton")
pcTriggerButton.Name = n()
pcTriggerButton.Size = UDim2.new(0.44, 0, 0, 30)
pcTriggerButton.Position = UDim2.new(0.05, 0, 0, 385)
pcTriggerButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
pcTriggerButton.TextColor3 = Color3.new(1, 1, 1)
pcTriggerButton.Font = Enum.Font.SourceSansBold
pcTriggerButton.TextSize = 13
pcTriggerButton.Text = "PC Trigger: OFF"
pcTriggerButton.Parent = aimScroll
cr(pcTriggerButton)

local mobileTriggerButton = Instance.new("TextButton")
mobileTriggerButton.Name = n()
mobileTriggerButton.Size = UDim2.new(0.44, 0, 0, 30)
mobileTriggerButton.Position = UDim2.new(0.51, 0, 0, 385)
mobileTriggerButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mobileTriggerButton.TextColor3 = Color3.new(1, 1, 1)
mobileTriggerButton.Font = Enum.Font.SourceSansBold
mobileTriggerButton.TextSize = 13
mobileTriggerButton.Text = "Mobile Trigger: OFF"
mobileTriggerButton.Parent = aimScroll
cr(mobileTriggerButton)

local valCheckButton = Instance.new("TextButton")
valCheckButton.Name = n()
valCheckButton.Size = UDim2.new(0.75, -5, 0, 30)
valCheckButton.Position = UDim2.new(0.05, 0, 0, 425)
valCheckButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
valCheckButton.TextColor3 = Color3.new(1, 1, 1)
valCheckButton.Font = Enum.Font.SourceSansBold
valCheckButton.TextSize = 14
valCheckButton.Text = "Val Check: OFF"
valCheckButton.Parent = aimScroll
cr(valCheckButton)

local valCheckOpenButton = Instance.new("TextButton")
valCheckOpenButton.Name = n()
valCheckOpenButton.Size = UDim2.new(0.15, -5, 0, 30)
valCheckOpenButton.Position = UDim2.new(0.8, 0, 0, 425)
valCheckOpenButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
valCheckOpenButton.TextColor3 = Color3.new(1, 1, 1)
valCheckOpenButton.Font = Enum.Font.SourceSansBold
valCheckOpenButton.TextSize = 18
valCheckOpenButton.Text = "+"
valCheckOpenButton.Parent = aimScroll
cr(valCheckOpenButton)

local triggerWallCheckButton = mkT("Trigger WallCheck: OFF", 465, aimScroll)
local triggerTeamCheckButton = mkT("Trigger Team Check: OFF", 505, aimScroll)

local aimCloseButton = Instance.new("TextButton")
aimCloseButton.Name = n()
aimCloseButton.Size = UDim2.new(0.9, 0, 0, 25)
aimCloseButton.Position = UDim2.new(0.05, 0, 1, -30)
aimCloseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
aimCloseButton.TextColor3 = Color3.new(1, 1, 1)
aimCloseButton.Font = Enum.Font.SourceSansBold
aimCloseButton.TextSize = 14
aimCloseButton.Text = "Close Menu"
aimCloseButton.Parent = aimSettingsFrame
cr(aimCloseButton)

local fovCircleButton = mkT("FOV Circle: ON", 5, aimScroll)
fovCircleButton.TextSize = 16
local wallButton = mkT("WallCheck: OFF", 45, aimScroll)
wallButton.TextSize = 16

-- AIM ValCheck buttons (special size)
local aimValCheckButton = Instance.new("TextButton")
aimValCheckButton.Name = n()
aimValCheckButton.Size = UDim2.new(0.75, -5, 0, 30)
aimValCheckButton.Position = UDim2.new(0.05, 0, 0, 85)
aimValCheckButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
aimValCheckButton.TextColor3 = Color3.new(1, 1, 1)
aimValCheckButton.Font = Enum.Font.SourceSansBold
aimValCheckButton.TextSize = 14
aimValCheckButton.Text = "AIM ValCheck: OFF"
aimValCheckButton.Parent = aimScroll
cr(aimValCheckButton)

local aimValCheckOpenButton = Instance.new("TextButton")
aimValCheckOpenButton.Name = n()
aimValCheckOpenButton.Size = UDim2.new(0.15, -5, 0, 30)
aimValCheckOpenButton.Position = UDim2.new(0.8, 0, 0, 85)
aimValCheckOpenButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
aimValCheckOpenButton.TextColor3 = Color3.new(1, 1, 1)
aimValCheckOpenButton.Font = Enum.Font.SourceSansBold
aimValCheckOpenButton.TextSize = 18
aimValCheckOpenButton.Text = "+"
aimValCheckOpenButton.Parent = aimScroll
cr(aimValCheckOpenButton)

-- Aim FOV label + input + slider
local aimFOVLabel = Instance.new("TextLabel")
aimFOVLabel.Name = n()
aimFOVLabel.Size = UDim2.new(0.4, 0, 0, 25)
aimFOVLabel.Position = UDim2.new(0.05, 0, 0, 125)
aimFOVLabel.BackgroundTransparency = 1
aimFOVLabel.Text = "Aim FOV:"
aimFOVLabel.Font = Enum.Font.SourceSansBold
aimFOVLabel.TextSize = 14
aimFOVLabel.TextColor3 = Color3.new(1, 1, 1)
aimFOVLabel.TextXAlignment = Enum.TextXAlignment.Left
aimFOVLabel.Parent = aimScroll

local aimFOVInput = Instance.new("TextBox")
aimFOVInput.Name = n()
aimFOVInput.Size = UDim2.new(0.45, 0, 0, 25)
aimFOVInput.Position = UDim2.new(0.5, 0, 0, 125)
aimFOVInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
aimFOVInput.TextColor3 = Color3.new(1, 1, 1)
aimFOVInput.Font = Enum.Font.SourceSans
aimFOVInput.TextSize = 14
aimFOVInput.Text = "60"
aimFOVInput.Parent = aimScroll
cr(aimFOVInput)

local aimFOVSliderFrame = Instance.new("Frame")
aimFOVSliderFrame.Name = n()
aimFOVSliderFrame.Size = UDim2.new(0.9, 0, 0, 15)
aimFOVSliderFrame.Position = UDim2.new(0.05, 0, 0, 155)
aimFOVSliderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
aimFOVSliderFrame.BorderSizePixel = 0
aimFOVSliderFrame.Parent = aimScroll
cr(aimFOVSliderFrame)

local aimFOVSliderButton = Instance.new("Frame")
aimFOVSliderButton.Name = n()
aimFOVSliderButton.Size = UDim2.new(0, 20, 0, 20)
aimFOVSliderButton.Position = UDim2.new(0.18, -10, 0, -2.5)
aimFOVSliderButton.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
aimFOVSliderButton.BorderSizePixel = 0
aimFOVSliderButton.Parent = aimFOVSliderFrame
cr(aimFOVSliderButton, 100)

-- Smooth label + input + slider
local smoothLabel = Instance.new("TextLabel")
smoothLabel.Name = n()
smoothLabel.Size = UDim2.new(0.4, 0, 0, 25)
smoothLabel.Position = UDim2.new(0.05, 0, 0, 215)
smoothLabel.BackgroundTransparency = 1
smoothLabel.Text = "Smooth:"
smoothLabel.Font = Enum.Font.SourceSansBold
smoothLabel.TextSize = 14
smoothLabel.TextColor3 = Color3.new(1, 1, 1)
smoothLabel.TextXAlignment = Enum.TextXAlignment.Left
smoothLabel.Parent = aimScroll

local smoothInput = Instance.new("TextBox")
smoothInput.Name = n()
smoothInput.Size = UDim2.new(0.45, 0, 0, 25)
smoothInput.Position = UDim2.new(0.5, 0, 0, 215)
smoothInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
smoothInput.TextColor3 = Color3.new(1, 1, 1)
smoothInput.Font = Enum.Font.SourceSans
smoothInput.TextSize = 14
smoothInput.Text = "1"
smoothInput.Parent = aimScroll
cr(smoothInput)

local smoothSliderFrame = Instance.new("Frame")
smoothSliderFrame.Name = n()
smoothSliderFrame.Size = UDim2.new(0.9, 0, 0, 15)
smoothSliderFrame.Position = UDim2.new(0.05, 0, 0, 245)
smoothSliderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
smoothSliderFrame.BorderSizePixel = 0
smoothSliderFrame.Parent = aimScroll
cr(smoothSliderFrame)

local smoothSliderButton = Instance.new("Frame")
smoothSliderButton.Name = n()
smoothSliderButton.Size = UDim2.new(0, 20, 0, 20)
smoothSliderButton.Position = UDim2.new(0.2, -10, 0, -2.5)
smoothSliderButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
smoothSliderButton.BorderSizePixel = 0
smoothSliderButton.Parent = smoothSliderFrame
cr(smoothSliderButton, 100)

-- Team Check + Silent Aim
local teamCheckButton = mkT("Team Check: OFF", 275, aimScroll)
local silentAimButton = mkT("Silent Aim: OFF", 315, aimScroll)

-- Hitbox Settings
local hitboxSettingsFrame = Instance.new("Frame")
hitboxSettingsFrame.Name = n()
hitboxSettingsFrame.Size = UDim2.new(0, 200, 0, 310)
hitboxSettingsFrame.Position = UDim2.new(0.5, 100, 0.3, 0)
hitboxSettingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
hitboxSettingsFrame.BorderSizePixel = 0
hitboxSettingsFrame.Visible = false
hitboxSettingsFrame.Active = true
hitboxSettingsFrame.Parent = sg
cr(hitboxSettingsFrame, 12)

local hitboxSettingsTitle = Instance.new("TextLabel")
hitboxSettingsTitle.Size = UDim2.new(1, 0, 0, 30)
hitboxSettingsTitle.BackgroundTransparency = 1
hitboxSettingsTitle.Text = "Hitbox Settings"
hitboxSettingsTitle.Font = Enum.Font.SourceSansBold
hitboxSettingsTitle.TextSize = 16
hitboxSettingsTitle.TextColor3 = Color3.new(1, 1, 1)
hitboxSettingsTitle.Parent = hitboxSettingsFrame

local hitboxScroll = Instance.new("ScrollingFrame")
hitboxScroll.Name = n()
hitboxScroll.Size = UDim2.new(1, 0, 1, -65)
hitboxScroll.Position = UDim2.new(0, 0, 0, 35)
hitboxScroll.BackgroundTransparency = 1
hitboxScroll.ScrollBarThickness = 6
hitboxScroll.CanvasSize = UDim2.new(0, 0, 0, 300)
hitboxScroll.Parent = hitboxSettingsFrame

local hitboxHeadButton = Instance.new("TextButton")
hitboxHeadButton.Name = n()
hitboxHeadButton.Size = UDim2.new(0.9, 0, 0, 40)
hitboxHeadButton.Position = UDim2.new(0.05, 0, 0, 10)
hitboxHeadButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
hitboxHeadButton.TextColor3 = Color3.new(1, 1, 1)
hitboxHeadButton.Font = Enum.Font.SourceSansBold
hitboxHeadButton.TextSize = 16
hitboxHeadButton.Text = "🎯 Head"
hitboxHeadButton.Parent = hitboxScroll
cr(hitboxHeadButton)

local hitboxTorsoButton = Instance.new("TextButton")
hitboxTorsoButton.Name = n()
hitboxTorsoButton.Size = UDim2.new(0.9, 0, 0, 40)
hitboxTorsoButton.Position = UDim2.new(0.05, 0, 0, 60)
hitboxTorsoButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
hitboxTorsoButton.TextColor3 = Color3.new(1, 1, 1)
hitboxTorsoButton.Font = Enum.Font.SourceSansBold
hitboxTorsoButton.TextSize = 16
hitboxTorsoButton.Text = "💪 Torso"
hitboxTorsoButton.Parent = hitboxScroll
cr(hitboxTorsoButton)

local hitboxArmsButton = Instance.new("TextButton")
hitboxArmsButton.Name = n()
hitboxArmsButton.Size = UDim2.new(0.9, 0, 0, 40)
hitboxArmsButton.Position = UDim2.new(0.05, 0, 0, 110)
hitboxArmsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
hitboxArmsButton.TextColor3 = Color3.new(1, 1, 1)
hitboxArmsButton.Font = Enum.Font.SourceSansBold
hitboxArmsButton.TextSize = 16
hitboxArmsButton.Text = "👐 Arms"
hitboxArmsButton.Parent = hitboxScroll
cr(hitboxArmsButton)

local hitboxLegsButton = Instance.new("TextButton")
hitboxLegsButton.Name = n()
hitboxLegsButton.Size = UDim2.new(0.9, 0, 0, 40)
hitboxLegsButton.Position = UDim2.new(0.05, 0, 0, 160)
hitboxLegsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
hitboxLegsButton.TextColor3 = Color3.new(1, 1, 1)
hitboxLegsButton.Font = Enum.Font.SourceSansBold
hitboxLegsButton.TextSize = 16
hitboxLegsButton.Text = "🦵 Legs"
hitboxLegsButton.Parent = hitboxScroll
cr(hitboxLegsButton)

-- Hitbox Size
local hitboxSizeLabel = Instance.new("TextLabel")
hitboxSizeLabel.Name = n()
hitboxSizeLabel.Size = UDim2.new(0.4, 0, 0, 25)
hitboxSizeLabel.Position = UDim2.new(0.05, 0, 0, 210)
hitboxSizeLabel.BackgroundTransparency = 1
hitboxSizeLabel.Text = "Size:"
hitboxSizeLabel.Font = Enum.Font.SourceSansBold
hitboxSizeLabel.TextSize = 14
hitboxSizeLabel.TextColor3 = Color3.new(1, 1, 1)
hitboxSizeLabel.TextXAlignment = Enum.TextXAlignment.Left
hitboxSizeLabel.Parent = hitboxScroll

local hitboxSizeInput = Instance.new("TextBox")
hitboxSizeInput.Name = n()
hitboxSizeInput.Size = UDim2.new(0.45, 0, 0, 25)
hitboxSizeInput.Position = UDim2.new(0.5, 0, 0, 210)
hitboxSizeInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
hitboxSizeInput.TextColor3 = Color3.new(1, 1, 1)
hitboxSizeInput.Font = Enum.Font.SourceSans
hitboxSizeInput.TextSize = 14
hitboxSizeInput.Text = "20"
hitboxSizeInput.PlaceholderText = "5-50"
hitboxSizeInput.Parent = hitboxScroll
cr(hitboxSizeInput)

local hitboxCloseButton = Instance.new("TextButton")
hitboxCloseButton.Name = n()
hitboxCloseButton.Size = UDim2.new(0.9, 0, 0, 25)
hitboxCloseButton.Position = UDim2.new(0.05, 0, 1, -30)
hitboxCloseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
hitboxCloseButton.TextColor3 = Color3.new(1, 1, 1)
hitboxCloseButton.Font = Enum.Font.SourceSansBold
hitboxCloseButton.TextSize = 14
hitboxCloseButton.Text = "Close Menu"
hitboxCloseButton.Parent = hitboxSettingsFrame
cr(hitboxCloseButton)

-- Teleport Frame
local teleportFrame = Instance.new("Frame")
teleportFrame.Name = n()
teleportFrame.Size = UDim2.new(0, 200, 0, 300)
teleportFrame.Position = UDim2.new(0.5, -100, 0.5, -150)
teleportFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
teleportFrame.BorderSizePixel = 0
teleportFrame.Visible = false
teleportFrame.Active = true
teleportFrame.Parent = sg
cr(teleportFrame, 12)

local teleportTitle = Instance.new("TextLabel")
teleportTitle.Name = n()
teleportTitle.Size = UDim2.new(1, 0, 0, 30)
teleportTitle.BackgroundTransparency = 1
teleportTitle.Text = "Teleport to players"
teleportTitle.Font = Enum.Font.SourceSansBold
teleportTitle.TextSize = 16
teleportTitle.TextColor3 = Color3.new(1, 1, 1)
teleportTitle.Parent = teleportFrame

local backButton = Instance.new("TextButton")
backButton.Name = n()
backButton.Size = UDim2.new(0.9, 0, 0, 25)
backButton.Position = UDim2.new(0.05, 0, 1, -30)
backButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
backButton.TextColor3 = Color3.new(1, 1, 1)
backButton.Font = Enum.Font.SourceSansBold
backButton.TextSize = 14
backButton.Text = "← Back"
backButton.Parent = teleportFrame
cr(backButton)

local teleportScroll = Instance.new("ScrollingFrame")
teleportScroll.Name = n()
teleportScroll.Size = UDim2.new(1, 0, 1, -65)
teleportScroll.Position = UDim2.new(0, 0, 0, 35)
teleportScroll.BackgroundTransparency = 1
teleportScroll.ScrollBarThickness = 6
teleportScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
teleportScroll.Parent = teleportFrame

-- Main scroll
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = n()
scrollFrame.Size = UDim2.new(1, 0, 1, -60)
scrollFrame.Position = UDim2.new(0, 0, 0, 30)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 6
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 1000)
scrollFrame.Parent = frame

-- Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = n()
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Smile Mod Menu"
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 20
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Parent = frame

-- Main buttons helper
local function mkBtn(t, y, pr)
    local b = Instance.new("TextButton", pr or scrollFrame)
    b.Size = UDim2.new(0.9, 0, 0, 30)
    b.Position = UDim2.new(0.05, 0, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 16
    b.Text = t
    b.Parent = scrollFrame
    cr(b, 8)
    return b
end

local teleportButton = mkBtn("Teleport", 10)
local aimButton = mkBtn("AIM: OFF", 50)
aimButton.Size = UDim2.new(0.75, -5, 0, 30)

local aimSettingsOpenButton = Instance.new("TextButton")
aimSettingsOpenButton.Name = n()
aimSettingsOpenButton.Size = UDim2.new(0.15, -5, 0, 30)
aimSettingsOpenButton.Position = UDim2.new(0.8, 0, 0, 50)
aimSettingsOpenButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
aimSettingsOpenButton.TextColor3 = Color3.new(1, 1, 1)
aimSettingsOpenButton.Font = Enum.Font.SourceSansBold
aimSettingsOpenButton.TextSize = 18
aimSettingsOpenButton.Text = "+"
aimSettingsOpenButton.Parent = scrollFrame
cr(aimSettingsOpenButton)

local espButton = mkBtn("ESP: OFF", 90)
espButton.Size = UDim2.new(0.75, -5, 0, 30)

local espSettingsOpenButton = Instance.new("TextButton")
espSettingsOpenButton.Name = n()
espSettingsOpenButton.Size = UDim2.new(0.15, -5, 0, 30)
espSettingsOpenButton.Position = UDim2.new(0.8, 0, 0, 90)
espSettingsOpenButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
espSettingsOpenButton.TextColor3 = Color3.new(1, 1, 1)
espSettingsOpenButton.Font = Enum.Font.SourceSansBold
espSettingsOpenButton.TextSize = 18
espSettingsOpenButton.Text = "+"
espSettingsOpenButton.Parent = scrollFrame
cr(espSettingsOpenButton)

local charmsButton = mkBtn("Charms: OFF", 130)
charmsButton.Size = UDim2.new(0.75, -5, 0, 30)

local charmsSettingsOpenButton = Instance.new("TextButton")
charmsSettingsOpenButton.Name = n()
charmsSettingsOpenButton.Size = UDim2.new(0.15, -5, 0, 30)
charmsSettingsOpenButton.Position = UDim2.new(0.8, 0, 0, 130)
charmsSettingsOpenButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
charmsSettingsOpenButton.TextColor3 = Color3.new(1, 1, 1)
charmsSettingsOpenButton.Font = Enum.Font.SourceSansBold
charmsSettingsOpenButton.TextSize = 18
charmsSettingsOpenButton.Text = "+"
charmsSettingsOpenButton.Parent = scrollFrame
cr(charmsSettingsOpenButton)

local infiniteJumpButton = mkBtn("Infinite Jump: OFF", 170)
local noclipButton = mkBtn("Noclip: OFF", 210)
local bunnyHopButton = mkBtn("BunnyHop: OFF", 250)
local skyButton = mkBtn("Sky: Default", 290)
local chaosButton = mkBtn("Chaos: OFF", 330)
local thirdPersonButton = mkBtn("Third Person: OFF", 370)
local wallHopButton = mkBtn("Wall Hop: OFF", 410)
local hitboxButton = mkBtn("Hitbox: OFF", 450)
hitboxButton.Size = UDim2.new(0.75, -5, 0, 30)

local hitboxSettingsOpenButton = Instance.new("TextButton")
hitboxSettingsOpenButton.Name = n()
hitboxSettingsOpenButton.Size = UDim2.new(0.15, -5, 0, 30)
hitboxSettingsOpenButton.Position = UDim2.new(0.8, 0, 0, 450)
hitboxSettingsOpenButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
hitboxSettingsOpenButton.TextColor3 = Color3.new(1, 1, 1)
hitboxSettingsOpenButton.Font = Enum.Font.SourceSansBold
hitboxSettingsOpenButton.TextSize = 18
hitboxSettingsOpenButton.Text = "+"
hitboxSettingsOpenButton.Parent = scrollFrame
cr(hitboxSettingsOpenButton)

local fullbrightButton = mkBtn("Fullbright: OFF", 490)
local godModeButton = mkBtn("God Mode: OFF", 530)
local fpsBoostButton = mkBtn("FPS Boost: OFF", 570)
local antiAfkButton = mkBtn("Anti AFK: OFF", 610)
local configButton = mkBtn("⚙️ Config", 650)

-- Fly section
mk("TextLabel", scrollFrame, {Size = UDim2.new(0.4, 0, 0, 25), Position = UDim2.new(0.05, 0, 0, 695), BackgroundTransparency = 1, Text = "Fly Speed:", Font = Enum.Font.SourceSansBold, TextSize = 14, TextColor3 = Color3.new(1,1,1), TextXAlignment = Enum.TextXAlignment.Left, Name = n(), Parent = scrollFrame})

local flyInput = Instance.new("TextBox")
flyInput.Name = n()
flyInput.Size = UDim2.new(0.45, 0, 0, 25)
flyInput.Position = UDim2.new(0.5, 0, 0, 695)
flyInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
flyInput.TextColor3 = Color3.new(1,1,1)
flyInput.Font = Enum.Font.SourceSans
flyInput.TextSize = 14
flyInput.Text = "50"
flyInput.Parent = scrollFrame
cr(flyInput)

local flyButton = mkBtn("Fly: OFF", 725)

mk("TextLabel", scrollFrame, {Size = UDim2.new(0.4, 0, 0, 25), Position = UDim2.new(0.05, 0, 0, 765), BackgroundTransparency = 1, Text = "Speed:", Font = Enum.Font.SourceSansBold, TextSize = 14, TextColor3 = Color3.new(1,1,1), TextXAlignment = Enum.TextXAlignment.Left, Name = n(), Parent = scrollFrame})

local speedInput = Instance.new("TextBox")
speedInput.Name = n()
speedInput.Size = UDim2.new(0.45, 0, 0, 25)
speedInput.Position = UDim2.new(0.5, 0, 0, 765)
speedInput.BackgroundColor3 = Color3.fromRGB(50,50,50)
speedInput.TextColor3 = Color3.new(1,1,1)
speedInput.Font = Enum.Font.SourceSans
speedInput.TextSize = 14
speedInput.Text = "16"
speedInput.Parent = scrollFrame
cr(speedInput)

local sliderFrame = Instance.new("Frame")
sliderFrame.Name = n()
sliderFrame.Size = UDim2.new(0.9, 0, 0, 15)
sliderFrame.Position = UDim2.new(0.05, 0, 0, 795)
sliderFrame.BackgroundColor3 = Color3.fromRGB(20, 20,20)
sliderFrame.BorderSizePixel = 0
sliderFrame.Parent = scrollFrame
cr(sliderFrame)

local sliderButton = Instance.new("Frame")
sliderButton.Name = n()
sliderButton.Size = UDim2.new(0, 20, 0, 20)
sliderButton.Position = UDim2.new(0, -2, 0, -2.5)
sliderButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
sliderButton.BorderSizePixel = 0
sliderButton.Parent = sliderFrame
cr(sliderButton, 100)

local speedButton = mkBtn("Speed: OFF", 820)

mk("TextLabel", scrollFrame, {Size = UDim2.new(0.4, 0, 0, 25), Position = UDim2.new(0.05, 0, 0, 860), BackgroundTransparency = 1, Text = "FOV:", Font = Enum.Font.SourceSansBold, TextSize = 14, TextColor3 = Color3.new(1,1,1), TextXAlignment = Enum.TextXAlignment.Left, Name = n(), Parent = scrollFrame})

local fovInput = Instance.new("TextBox")
fovInput.Name = n()
fovInput.Size = UDim2.new(0.45, 0, 0, 25)
fovInput.Position = UDim2.new(0.5, 0, 0, 860)
fovInput.BackgroundColor3 = Color3.fromRGB(50,50,50)
fovInput.TextColor3 = Color3.new(1,1,1)
fovInput.Font = Enum.Font.SourceSans
fovInput.TextSize = 14
fovInput.Text = "70"
fovInput.Parent = scrollFrame
cr(fovInput)

local fovSliderFrame = Instance.new("Frame")
fovSliderFrame.Name = n()
fovSliderFrame.Size = UDim2.new(0.9, 0, 0, 15)
fovSliderFrame.Position = UDim2.new(0.05, 0, 0, 890)
fovSliderFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
fovSliderFrame.BorderSizePixel = 0
fovSliderFrame.Parent = scrollFrame
cr(fovSliderFrame)

local fovSliderButton = Instance.new("Frame")
fovSliderButton.Name = n()
fovSliderButton.Size = UDim2.new(0, 20, 0, 20)
fovSliderButton.Position = UDim2.new(0.44, -10, 0, -2.5)
fovSliderButton.BackgroundColor3 = Color3.fromRGB(255,100,0)
fovSliderButton.BorderSizePixel = 0
fovSliderButton.Parent = fovSliderFrame
cr(fovSliderButton, 100)

local fovButton = mkBtn("FOV: OFF", 915)

-- Minimize
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = n()
minimizeButton.Size = UDim2.new(0.9, 0, 0, 25)
minimizeButton.Position = UDim2.new(0.05, 0, 1, -30)
minimizeButton.Text = "Minimize menu"
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
minimizeButton.BorderSizePixel = 0
minimizeButton.Font = Enum.Font.SourceSansBold
minimizeButton.TextSize = 14
minimizeButton.Parent = frame
cr(minimizeButton)

local minimizedCircle = Instance.new("TextButton")
minimizedCircle.Name = n()
minimizedCircle.Size = UDim2.new(0, 30, 0, 30)
minimizedCircle.Position = UDim2.new(0, 300, 0, 200)
minimizedCircle.Text = ""
minimizedCircle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
minimizedCircle.BorderSizePixel = 0
minimizedCircle.Visible = false
minimizedCircle.AnchorPoint = Vector2.new(0.5, 0.5)
minimizedCircle.Parent = sg
cr(minimizedCircle, 100)

-- Config Frame
local configFrame = Instance.new("Frame")
configFrame.Name = n()
configFrame.Size = UDim2.new(0, 230, 0, 370)
configFrame.Position = UDim2.new(0.5, -115, 0.5, -170)
configFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
configFrame.BorderSizePixel = 0
configFrame.Visible = false
configFrame.Active = true
configFrame.Parent = sg
cr(configFrame, 12)

-- Player Select Frame (Val Check)
local playerSelectFrame = Instance.new("Frame")
playerSelectFrame.Name = n()
playerSelectFrame.Size = UDim2.new(0, 180, 0, 280)
playerSelectFrame.Position = UDim2.new(0.5, 110, 0.3, 0)
playerSelectFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
playerSelectFrame.BorderSizePixel = 0
playerSelectFrame.Visible = false
playerSelectFrame.Active = true
playerSelectFrame.Parent = sg
cr(playerSelectFrame, 12)

local playerSelectTitle = Instance.new("TextLabel")
playerSelectTitle.Name = n()
playerSelectTitle.Size = UDim2.new(1, 0, 0, 30)
playerSelectTitle.BackgroundTransparency = 1
playerSelectTitle.Text = "Val Check Players"
playerSelectTitle.Font = Enum.Font.SourceSansBold
playerSelectTitle.TextSize = 15
playerSelectTitle.TextColor3 = Color3.new(1, 1, 1)
playerSelectTitle.Parent = playerSelectFrame

local playerSelectScroll = Instance.new("ScrollingFrame")
playerSelectScroll.Name = n()
playerSelectScroll.Size = UDim2.new(1, 0, 1, -65)
playerSelectScroll.Position = UDim2.new(0, 0, 0, 35)
playerSelectScroll.BackgroundTransparency = 1
playerSelectScroll.ScrollBarThickness = 5
playerSelectScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
playerSelectScroll.Parent = playerSelectFrame

local playerSelectClose = Instance.new("TextButton")
playerSelectClose.Name = n()
playerSelectClose.Size = UDim2.new(0.9, 0, 0, 25)
playerSelectClose.Position = UDim2.new(0.05, 0, 1, -30)
playerSelectClose.BackgroundColor3 = Color3.fromRGB(60,60,60)
playerSelectClose.TextColor3 = Color3.new(1,1,1)
playerSelectClose.Font = Enum.Font.SourceSansBold
playerSelectClose.TextSize = 14
playerSelectClose.Text = "Close"
playerSelectClose.Parent = playerSelectFrame
cr(playerSelectClose)

-- AIM Val Check Frame
local aimValCheckFrame = Instance.new("Frame")
aimValCheckFrame.Name = n()
aimValCheckFrame.Size = UDim2.new(0, 180, 0, 280)
aimValCheckFrame.Position = UDim2.new(0.5, 110, 0.3, 0)
aimValCheckFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
aimValCheckFrame.BorderSizePixel = 0
aimValCheckFrame.Visible = false
aimValCheckFrame.Active = true
aimValCheckFrame.Parent = sg
cr(aimValCheckFrame, 12)

local aimValCheckTitle = Instance.new("TextLabel")
aimValCheckTitle.Name = n()
aimValCheckTitle.Size = UDim2.new(1, 0, 0, 30)
aimValCheckTitle.BackgroundTransparency = 1
aimValCheckTitle.Text = "AIM Players"
aimValCheckTitle.Font = Enum.Font.SourceSansBold
aimValCheckTitle.TextSize = 15
aimValCheckTitle.TextColor3 = Color3.new(1, 1, 1)
aimValCheckTitle.Parent = aimValCheckFrame

local aimValCheckScroll = Instance.new("ScrollingFrame")
aimValCheckScroll.Name = n()
aimValCheckScroll.Size = UDim2.new(1, 0, 1, -65)
aimValCheckScroll.Position = UDim2.new(0, 0, 0, 35)
aimValCheckScroll.BackgroundTransparency = 1
aimValCheckScroll.ScrollBarThickness = 5
aimValCheckScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
aimValCheckScroll.Parent = aimValCheckFrame

local aimValCheckClose = Instance.new("TextButton")
aimValCheckClose.Name = n()
aimValCheckClose.Size = UDim2.new(0.9, 0, 0, 25)
aimValCheckClose.Position = UDim2.new(0.05, 0, 1, -30)
aimValCheckClose.BackgroundColor3 = Color3.fromRGB(60,60,60)
aimValCheckClose.TextColor3 = Color3.new(1, 1, 1)
aimValCheckClose.Font = Enum.Font.SourceSansBold
aimValCheckClose.TextSize = 14
aimValCheckClose.Text = "Close"
aimValCheckClose.Parent = aimValCheckFrame
cr(aimValCheckClose)

-- Mobile GUI
local mobileGui = Instance.new("Frame")
mobileGui.Name = n()
mobileGui.Size = UDim2.new(0, 160, 0, 95)
mobileGui.Position = UDim2.new(0, 20, 1, -160)
mobileGui.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mobileGui.BorderSizePixel = 0
mobileGui.Visible = false
mobileGui.Active = true
mobileGui.Parent = sg
cr(mobileGui, 8)

local mobileWBtn = Instance.new("TextButton")
mobileWBtn.Name = n()
mobileWBtn.Size = UDim2.new(0, 40, 0,40)
mobileWBtn.Position = UDim2.new(0,60,0,5)
mobileWBtn.BackgroundColor3 = Color3.fromRGB(40,40,60)
mobileWBtn.Text = "W"
mobileWBtn.TextColor3 = Color3.new(1,1,1)
mobileWBtn.TextSize = 16
mobileWBtn.Font = Enum.Font.GothamBold
mobileWBtn.Parent = mobileGui
cr(mobileWBtn)

local mobileABtn = Instance.new("TextButton")
mobileABtn.Name = n()
mobileABtn.Size = UDim2.new(0,40,0,40)
mobileABtn.Position = UDim2.new(0,10,0,50)
mobileABtn.BackgroundColor3 = Color3.fromRGB(40,40,60)
mobileABtn.Text = "A"
mobileABtn.TextColor3 = Color3.new(1,1,1)
mobileABtn.TextSize = 16
mobileABtn.Font = Enum.Font.GothamBold
mobileABtn.Parent = mobileGui
cr(mobileABtn)

local mobileSBtn = Instance.new("TextButton")
mobileSBtn.Name = n()
mobileSBtn.Size = UDim2.new(0,40,0,40)
mobileSBtn.Position = UDim2.new(0,60,0,50)
mobileSBtn.BackgroundColor3 = Color3.fromRGB(40,40,60)
mobileSBtn.Text = "S"
mobileSBtn.TextColor3 = Color3.new(1,1,1)
mobileSBtn.TextSize = 16
mobileSBtn.Font = Enum.Font.GothamBold
mobileSBtn.Parent = mobileGui
cr(mobileSBtn)

local mobileDBtn = Instance.new("TextButton")
mobileDBtn.Name = n()
mobileDBtn.Size = UDim2.new(0,40,0,40)
mobileDBtn.Position = UDim2.new(0,110,0,50)
mobileDBtn.BackgroundColor3 = Color3.fromRGB(40,40,60)
mobileDBtn.Text = "D"
mobileDBtn.TextColor3 = Color3.new(1,1,1)
mobileDBtn.TextSize = 16
mobileDBtn.Font = Enum.Font.GothamBold
mobileDBtn.Parent = mobileGui
cr(mobileDBtn)

local mobileSpaceFrame = Instance.new("Frame")
mobileSpaceFrame.Name = n()
mobileSpaceFrame.Size = UDim2.new(0, 70,0,70)
mobileSpaceFrame.Position = UDim2.new(1, -90, 1, -90)
mobileSpaceFrame.BackgroundColor3 = Color3.fromRGB(40,40,60)
mobileSpaceFrame.BorderSizePixel = 0
mobileSpaceFrame.Visible = false
mobileSpaceFrame.Parent = sg
cr(mobileSpaceFrame, 100)

mk("TextLabel", mobileSpaceFrame, {Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Text = "SPACE", TextColor3 = Color3.new(1,1,1), Font = Enum.Font.GothamBold, TextSize = 12, Name = n()})

-- Continuous name rotation
task.spawn(function()
    while task.wait(math.random(1,3)) do
        pcall(function() sg.Name = n() end)
    end
end)

-- ============================================================
--   RETURN TABLE
-- ============================================================
print("[GUI] Building return table...")

local G = {
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
    espValCheckFrame = espValCheckFrame, espColorPickerFrame = espColorPickerFrame, charmsSettingsFrame = charmsSettingsFrame,
    espSettingsFrame = espSettingsFrame,
    aimSettingsOpenButton = aimSettingsOpenButton, espSettingsOpenButton = espSettingsOpenButton,
    charmsSettingsOpenButton = charmsSettingsOpenButton, hitboxSettingsOpenButton = hitboxSettingsOpenButton,
    espVisColorOpenBtn = espVisColorOpenBtn, espUnvisColorOpenBtn = espUnvisColorOpenBtn,
    charmsVisColorOpenBtn = charmsVisColorOpenBtn, charmsUnvisColorOpenBtn = charmsUnvisColorOpenBtn,
    valCheckOpenButton = valCheckOpenButton, aimValCheckOpenButton = aimValCheckOpenButton,
    espValCheckOpenBtn = espValCheckOpenBtn,
    espRSlider = espRSlider, espRHandle = espRHandle, espGSlider = espGSlider, espGHandle = espGHandle,
    espBSlider = espBSlider, espBHandle = espBHandle, espColorPreview = espColorPreview,
    charmsRSlider = charmsRSlider, charmsRHandle = charmsRHandle, charmsGSlider = charmsGSlider, charmsGHandle = charmsGHandle, 
    charmsBSlider = charmsBSlider, charmsBHandle = charmsBHandle, charmsColorPreview = charmsColorPreview,
    titleLabel = titleLabel,
    mobileGui = mobileGui, mobileWBtn = mobileWBtn, mobileABtn = mobileABtn,
    mobileSBtn = mobileSBtn, mobileDBtn = mobileDBtn, mobileSpaceFrame = mobileSpaceFrame
}

print("[GUI] Return table built with " .. #G .. " elements")

return G
