-- GUI частина
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function createProtectedScreenGui()
    local sg = Instance.new("ScreenGui")
    sg.Name = string.char(math.random(97, 122)) .. string.char(math.random(97, 122)) .. string.char(math.random(97, 122))
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 99999
    sg.IgnoreGuiInset = true
    
    if gethui then
        sg.Parent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(sg)
        sg.Parent = game:GetService("CoreGui")
    else
        sg.Parent = game:GetService("CoreGui")
    end
    
    return sg
end

local screenGui = createProtectedScreenGui()
local CoreGui = game:GetService("CoreGui")

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 180, 0, 230)
frame.Position = UDim2.new(0.5, -90, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = false
local frameCorner = Instance.new("UICorner", frame)
frameCorner.CornerRadius = UDim.new(0, 12)

local aimSettingsFrame = Instance.new("Frame", screenGui)
aimSettingsFrame.Size = UDim2.new(0, 200, 0, 220)
aimSettingsFrame.Position = UDim2.new(0.5, 100, 0.3, 0)
aimSettingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
aimSettingsFrame.BorderSizePixel = 0
aimSettingsFrame.Visible = false
aimSettingsFrame.Active = true
local aimSettingsCorner = Instance.new("UICorner", aimSettingsFrame)
aimSettingsCorner.CornerRadius = UDim.new(0, 12)

local aimSettingsTitle = Instance.new("TextLabel", aimSettingsFrame)
aimSettingsTitle.Size = UDim2.new(1, 0, 0, 30)
aimSettingsTitle.BackgroundTransparency = 1
aimSettingsTitle.Text = "AIM Settings"
aimSettingsTitle.Font = Enum.Font.SourceSansBold
aimSettingsTitle.TextSize = 16
aimSettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)

local aimScroll = Instance.new("ScrollingFrame", aimSettingsFrame)
aimScroll.Size = UDim2.new(1, 0, 1, -65)
aimScroll.Position = UDim2.new(0, 0, 0, 30)
aimScroll.BackgroundTransparency = 1
aimScroll.ScrollBarThickness = 5
aimScroll.CanvasSize = UDim2.new(0, 0, 0, 550)

local espSettingsFrame = Instance.new("Frame", screenGui)
espSettingsFrame.Size = UDim2.new(0, 210, 0, 260)
espSettingsFrame.Position = UDim2.new(0.5, 100, 0.3, 0)
espSettingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
espSettingsFrame.BorderSizePixel = 0
espSettingsFrame.Visible = false
espSettingsFrame.Active = true
Instance.new("UICorner", espSettingsFrame)

local espColorPickerFrame = Instance.new("Frame", screenGui)
espColorPickerFrame.Size = UDim2.new(0, 200, 0, 200)
espColorPickerFrame.Position = UDim2.new(0.5, 320, 0.3, 0)
espColorPickerFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
espColorPickerFrame.BorderSizePixel = 0
espColorPickerFrame.Visible = false
espColorPickerFrame.Active = true
Instance.new("UICorner", espColorPickerFrame)

-- ===== CHARMS SETTINGS FRAME =====
local charmsSettingsFrame = Instance.new("Frame", screenGui)
charmsSettingsFrame.Size = UDim2.new(0, 210, 0, 220)
charmsSettingsFrame.Position = UDim2.new(0.5, 100, 0.3, 0)
charmsSettingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
charmsSettingsFrame.BorderSizePixel = 0
charmsSettingsFrame.Visible = false
charmsSettingsFrame.Active = true
Instance.new("UICorner", charmsSettingsFrame)

local charmsSettingsTitle = Instance.new("TextLabel", charmsSettingsFrame)
charmsSettingsTitle.Size = UDim2.new(1, 0, 0, 30)
charmsSettingsTitle.BackgroundTransparency = 1
charmsSettingsTitle.Text = "Charms Settings"
charmsSettingsTitle.Font = Enum.Font.SourceSansBold
charmsSettingsTitle.TextSize = 16
charmsSettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)

local charmsScroll = Instance.new("ScrollingFrame", charmsSettingsFrame)
charmsScroll.Size = UDim2.new(1, 0, 1, -60)
charmsScroll.Position = UDim2.new(0, 0, 0, 30)
charmsScroll.BackgroundTransparency = 1
charmsScroll.ScrollBarThickness = 5
charmsScroll.CanvasSize = UDim2.new(0, 0, 0, 160)

-- Visible кнопка + +
local charmsVisBtn = Instance.new("TextButton", charmsScroll)
charmsVisBtn.Size = UDim2.new(0.75, -5, 0, 30)
charmsVisBtn.Position = UDim2.new(0.05, 0, 0, 5)
charmsVisBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
charmsVisBtn.TextColor3 = Color3.new(0,0,0)
charmsVisBtn.Font = Enum.Font.SourceSansBold
charmsVisBtn.TextSize = 13
charmsVisBtn.Text = "Visible"
Instance.new("UICorner", charmsVisBtn)

local charmsVisColorOpenBtn = Instance.new("TextButton", charmsScroll)
charmsVisColorOpenBtn.Size = UDim2.new(0.15, -5, 0, 30)
charmsVisColorOpenBtn.Position = UDim2.new(0.8, 0, 0, 5)
charmsVisColorOpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
charmsVisColorOpenBtn.TextColor3 = Color3.new(1,1,1)
charmsVisColorOpenBtn.Font = Enum.Font.SourceSansBold
charmsVisColorOpenBtn.TextSize = 18
charmsVisColorOpenBtn.Text = "+"
Instance.new("UICorner", charmsVisColorOpenBtn)

-- Unvisible кнопка + +
local charmsUnvisBtn = Instance.new("TextButton", charmsScroll)
charmsUnvisBtn.Size = UDim2.new(0.75, -5, 0, 30)
charmsUnvisBtn.Position = UDim2.new(0.05, 0, 0, 45)
charmsUnvisBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
charmsUnvisBtn.TextColor3 = Color3.new(1,1,1)
charmsUnvisBtn.Font = Enum.Font.SourceSansBold
charmsUnvisBtn.TextSize = 13
charmsUnvisBtn.Text = "Unvisible"
Instance.new("UICorner", charmsUnvisBtn)

local charmsUnvisColorOpenBtn = Instance.new("TextButton", charmsScroll)
charmsUnvisColorOpenBtn.Size = UDim2.new(0.15, -5, 0, 30)
charmsUnvisColorOpenBtn.Position = UDim2.new(0.8, 0, 0, 45)
charmsUnvisColorOpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
charmsUnvisColorOpenBtn.TextColor3 = Color3.new(1,1,1)
charmsUnvisColorOpenBtn.Font = Enum.Font.SourceSansBold
charmsUnvisColorOpenBtn.TextSize = 18
charmsUnvisColorOpenBtn.Text = "+"
Instance.new("UICorner", charmsUnvisColorOpenBtn)

local charmsNpcButton = Instance.new("TextButton", charmsScroll)
charmsNpcButton.Size = UDim2.new(0.9, 0, 0, 30)
charmsNpcButton.Position = UDim2.new(0.05, 0, 0, 85)
charmsNpcButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
charmsNpcButton.TextColor3 = Color3.new(1,1,1)
charmsNpcButton.Font = Enum.Font.SourceSansBold
charmsNpcButton.TextSize = 14
charmsNpcButton.Text = "NPC: OFF"
Instance.new("UICorner", charmsNpcButton)

local charmsEspObjButton = Instance.new("TextButton", charmsScroll)
charmsEspObjButton.Size = UDim2.new(0.9, 0, 0, 30)
charmsEspObjButton.Position = UDim2.new(0.05, 0, 0, 125)
charmsEspObjButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
charmsEspObjButton.TextColor3 = Color3.new(1,1,1)
charmsEspObjButton.Font = Enum.Font.SourceSansBold
charmsEspObjButton.TextSize = 14
charmsEspObjButton.Text = "ESP Objects: OFF"
Instance.new("UICorner", charmsEspObjButton)

local charmsSettingsCloseBtn = Instance.new("TextButton", charmsSettingsFrame)
charmsSettingsCloseBtn.Size = UDim2.new(0.9, 0, 0, 25)
charmsSettingsCloseBtn.Position = UDim2.new(0.05, 0, 1, -30)
charmsSettingsCloseBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
charmsSettingsCloseBtn.TextColor3 = Color3.new(1,1,1)
charmsSettingsCloseBtn.Font = Enum.Font.SourceSansBold
charmsSettingsCloseBtn.TextSize = 14
charmsSettingsCloseBtn.Text = "Close"
Instance.new("UICorner", charmsSettingsCloseBtn)

-- ===== CHARMS COLOR PICKER FRAME =====
local charmsColorPickerFrame = Instance.new("Frame", screenGui)
charmsColorPickerFrame.Size = UDim2.new(0, 200, 0, 200)
charmsColorPickerFrame.Position = UDim2.new(0.5, 320, 0.3, 0)
charmsColorPickerFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
charmsColorPickerFrame.BorderSizePixel = 0
charmsColorPickerFrame.Visible = false
charmsColorPickerFrame.Active = true
Instance.new("UICorner", charmsColorPickerFrame)

local charmsColorPickerTitle = Instance.new("TextLabel", charmsColorPickerFrame)
charmsColorPickerTitle.Size = UDim2.new(1, 0, 0, 25)
charmsColorPickerTitle.BackgroundTransparency = 1
charmsColorPickerTitle.Text = "Pick Color"
charmsColorPickerTitle.Font = Enum.Font.SourceSansBold
charmsColorPickerTitle.TextSize = 14
charmsColorPickerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)

local charmsRSlider = Instance.new("Frame", charmsColorPickerFrame)
charmsRSlider.Size = UDim2.new(0.9, 0, 0, 15)
charmsRSlider.Position = UDim2.new(0.05, 0, 0, 35)
charmsRSlider.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
charmsRSlider.BorderSizePixel = 0
Instance.new("UICorner", charmsRSlider)

local charmsRHandle = Instance.new("Frame", charmsRSlider)
charmsRHandle.Size = UDim2.new(0, 14, 1, 0)
charmsRHandle.Position = UDim2.new(1, -7, 0, 0)
charmsRHandle.ZIndex = 5
charmsRHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
charmsRHandle.BorderSizePixel = 0
Instance.new("UICorner", charmsRHandle).CornerRadius = UDim.new(1, 0)

local charmsGSlider = Instance.new("Frame", charmsColorPickerFrame)
charmsGSlider.Size = UDim2.new(0.9, 0, 0, 15)
charmsGSlider.Position = UDim2.new(0.05, 0, 0, 65)
charmsGSlider.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
charmsGSlider.BorderSizePixel = 0
Instance.new("UICorner", charmsGSlider)

local charmsGHandle = Instance.new("Frame", charmsGSlider)
charmsGHandle.Size = UDim2.new(0, 14, 1, 0)
charmsGHandle.Position = UDim2.new(0, -7, 0, 0)
charmsGHandle.ZIndex = 5
charmsGHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
charmsGHandle.BorderSizePixel = 0
Instance.new("UICorner", charmsGHandle).CornerRadius = UDim.new(1, 0)

local charmsBSlider = Instance.new("Frame", charmsColorPickerFrame)
charmsBSlider.Size = UDim2.new(0.9, 0, 0, 15)
charmsBSlider.Position = UDim2.new(0.05, 0, 0, 95)
charmsBSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
charmsBSlider.BorderSizePixel = 0
Instance.new("UICorner", charmsBSlider)

local charmsBHandle = Instance.new("Frame", charmsBSlider)
charmsBHandle.Size = UDim2.new(0, 14, 1, 0)
charmsBHandle.Position = UDim2.new(0, -7, 0, 0)
charmsBHandle.ZIndex = 5
charmsBHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
charmsBHandle.BorderSizePixel = 0
Instance.new("UICorner", charmsBHandle).CornerRadius = UDim.new(1, 0)

local charmsColorPreview = Instance.new("Frame", charmsColorPickerFrame)
charmsColorPreview.Size = UDim2.new(0.9, 0, 0, 25)
charmsColorPreview.Position = UDim2.new(0.05, 0, 0, 120)
charmsColorPreview.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
charmsColorPreview.BorderSizePixel = 0
Instance.new("UICorner", charmsColorPreview)

local charmsColorPickerClose = Instance.new("TextButton", charmsColorPickerFrame)
charmsColorPickerClose.Size = UDim2.new(0.9, 0, 0, 25)
charmsColorPickerClose.Position = UDim2.new(0.05, 0, 1, -30)
charmsColorPickerClose.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
charmsColorPickerClose.TextColor3 = Color3.new(1,1,1)
charmsColorPickerClose.Font = Enum.Font.SourceSansBold
charmsColorPickerClose.TextSize = 14
charmsColorPickerClose.Text = "← Back"
Instance.new("UICorner", charmsColorPickerClose)

local espColorPickerTitle = Instance.new("TextLabel", espColorPickerFrame)
espColorPickerTitle.Size = UDim2.new(1, 0, 0, 25)
espColorPickerTitle.BackgroundTransparency = 1
espColorPickerTitle.Text = "Pick Color"
espColorPickerTitle.Font = Enum.Font.SourceSansBold
espColorPickerTitle.TextSize = 14
espColorPickerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)

-- R slider
local espRSlider = Instance.new("Frame", espColorPickerFrame)
espRSlider.Size = UDim2.new(0.9, 0, 0, 15)
espRSlider.Position = UDim2.new(0.05, 0, 0, 35)
espRSlider.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
espRSlider.BorderSizePixel = 0
Instance.new("UICorner", espRSlider)
local espRHandle = Instance.new("Frame", espRSlider)
espRHandle.Size = UDim2.new(0, 18, 0, 18)
espRHandle.Position = UDim2.new(1, -9, 0, -1.5)
espRHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
espRHandle.BorderSizePixel = 0
Instance.new("UICorner", espRHandle).CornerRadius = UDim.new(1, 0)

-- G slider
local espGSlider = Instance.new("Frame", espColorPickerFrame)
espGSlider.Size = UDim2.new(0.9, 0, 0, 15)
espGSlider.Position = UDim2.new(0.05, 0, 0, 65)
espGSlider.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
espGSlider.BorderSizePixel = 0
Instance.new("UICorner", espGSlider)
local espGHandle = Instance.new("Frame", espGSlider)
espGHandle.Size = UDim2.new(0, 18, 0, 18)
espGHandle.Position = UDim2.new(0, -9, 0, -1.5)
espGHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
espGHandle.BorderSizePixel = 0
Instance.new("UICorner", espGHandle).CornerRadius = UDim.new(1, 0)

-- B slider
local espBSlider = Instance.new("Frame", espColorPickerFrame)
espBSlider.Size = UDim2.new(0.9, 0, 0, 15)
espBSlider.Position = UDim2.new(0.05, 0, 0, 95)
espBSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
espBSlider.BorderSizePixel = 0
Instance.new("UICorner", espBSlider)
local espBHandle = Instance.new("Frame", espBSlider)
espBHandle.Size = UDim2.new(0, 18, 0, 18)
espBHandle.Position = UDim2.new(0, -9, 0, -1.5)
espBHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
espBHandle.BorderSizePixel = 0
Instance.new("UICorner", espBHandle).CornerRadius = UDim.new(1, 0)

-- Preview
local espColorPreview = Instance.new("Frame", espColorPickerFrame)
espColorPreview.Size = UDim2.new(0.9, 0, 0, 25)
espColorPreview.Position = UDim2.new(0.05, 0, 0, 120)
espColorPreview.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
espColorPreview.BorderSizePixel = 0
Instance.new("UICorner", espColorPreview)

local espColorPickerClose = Instance.new("TextButton", espColorPickerFrame)
espColorPickerClose.Size = UDim2.new(0.9, 0, 0, 25)
espColorPickerClose.Position = UDim2.new(0.05, 0, 1, -30)
espColorPickerClose.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espColorPickerClose.TextColor3 = Color3.new(1,1,1)
espColorPickerClose.Font = Enum.Font.SourceSansBold
espColorPickerClose.TextSize = 14
espColorPickerClose.Text = "← Back"
Instance.new("UICorner", espColorPickerClose)

local espValCheckFrame = Instance.new("Frame", screenGui)
espValCheckFrame.Size = UDim2.new(0, 180, 0, 280)
espValCheckFrame.Position = UDim2.new(0.5, 320, 0.3, 0)
espValCheckFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
espValCheckFrame.BorderSizePixel = 0
espValCheckFrame.Visible = false
espValCheckFrame.Active = true
Instance.new("UICorner", espValCheckFrame)

local espValCheckTitle = Instance.new("TextLabel", espValCheckFrame)
espValCheckTitle.Size = UDim2.new(1, 0, 0, 30)
espValCheckTitle.BackgroundTransparency = 1
espValCheckTitle.Text = "ESP Players"
espValCheckTitle.Font = Enum.Font.SourceSansBold
espValCheckTitle.TextSize = 15
espValCheckTitle.TextColor3 = Color3.fromRGB(255, 255, 255)

local espValCheckScroll = Instance.new("ScrollingFrame", espValCheckFrame)
espValCheckScroll.Size = UDim2.new(1, 0, 1, -65)
espValCheckScroll.Position = UDim2.new(0, 0, 0, 35)
espValCheckScroll.BackgroundTransparency = 1
espValCheckScroll.ScrollBarThickness = 5
espValCheckScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local espValCheckClose = Instance.new("TextButton", espValCheckFrame)
espValCheckClose.Size = UDim2.new(0.9, 0, 0, 25)
espValCheckClose.Position = UDim2.new(0.05, 0, 1, -30)
espValCheckClose.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espValCheckClose.TextColor3 = Color3.new(1,1,1)
espValCheckClose.Font = Enum.Font.SourceSansBold
espValCheckClose.TextSize = 14
espValCheckClose.Text = "Close"
Instance.new("UICorner", espValCheckClose)

local espSettingsTitle = Instance.new("TextLabel", espSettingsFrame)
espSettingsTitle.Size = UDim2.new(1, 0, 0, 30)
espSettingsTitle.BackgroundTransparency = 1
espSettingsTitle.Text = "ESP Settings"
espSettingsTitle.Font = Enum.Font.SourceSansBold
espSettingsTitle.TextSize = 16
espSettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)

local espScroll = Instance.new("ScrollingFrame", espSettingsFrame)
espScroll.Size = UDim2.new(1, 0, 1, -60)
espScroll.Position = UDim2.new(0, 0, 0, 25)
espScroll.BackgroundTransparency = 1
espScroll.ScrollBarThickness = 5
espScroll.CanvasSize = UDim2.new(0, 0, 0, 360)

-- Visible Color
local espVisColorBtn = Instance.new("TextButton", espScroll)
espVisColorBtn.Size = UDim2.new(0.75, -5, 0, 30)
espVisColorBtn.Position = UDim2.new(0.05, 0, 0, 5)
espVisColorBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
espVisColorBtn.TextColor3 = Color3.new(0,0,0)
espVisColorBtn.Font = Enum.Font.SourceSansBold
espVisColorBtn.TextSize = 13
espVisColorBtn.Text = "Visible Color"
Instance.new("UICorner", espVisColorBtn)

local espVisColorOpenBtn = Instance.new("TextButton", espScroll)
espVisColorOpenBtn.Size = UDim2.new(0.15, -5, 0, 30)
espVisColorOpenBtn.Position = UDim2.new(0.8, 0, 0, 5)
espVisColorOpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
espVisColorOpenBtn.TextColor3 = Color3.new(1,1,1)
espVisColorOpenBtn.Font = Enum.Font.SourceSansBold
espVisColorOpenBtn.TextSize = 18
espVisColorOpenBtn.Text = "+"
Instance.new("UICorner", espVisColorOpenBtn)

-- Unvisible Color
local espUnvisColorBtn = Instance.new("TextButton", espScroll)
espUnvisColorBtn.Size = UDim2.new(0.75, -5, 0, 30)
espUnvisColorBtn.Position = UDim2.new(0.05, 0, 0, 45)
espUnvisColorBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
espUnvisColorBtn.TextColor3 = Color3.new(1,1,1)
espUnvisColorBtn.Font = Enum.Font.SourceSansBold
espUnvisColorBtn.TextSize = 13
espUnvisColorBtn.Text = "Unvisible Color"
Instance.new("UICorner", espUnvisColorBtn)

local espUnvisColorOpenBtn = Instance.new("TextButton", espScroll)
espUnvisColorOpenBtn.Size = UDim2.new(0.15, -5, 0, 30)
espUnvisColorOpenBtn.Position = UDim2.new(0.8, 0, 0, 45)
espUnvisColorOpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
espUnvisColorOpenBtn.TextColor3 = Color3.new(1,1,1)
espUnvisColorOpenBtn.Font = Enum.Font.SourceSansBold
espUnvisColorOpenBtn.TextSize = 18
espUnvisColorOpenBtn.Text = "+"
Instance.new("UICorner", espUnvisColorOpenBtn)

-- Tracer
local espTracerBtn = Instance.new("TextButton", espScroll)
espTracerBtn.Size = UDim2.new(0.9, 0, 0, 30)
espTracerBtn.Position = UDim2.new(0.05, 0, 0, 85)
espTracerBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
espTracerBtn.TextColor3 = Color3.new(1,1,1)
espTracerBtn.Font = Enum.Font.SourceSansBold
espTracerBtn.TextSize = 14
espTracerBtn.Text = "Tracer: ON"
Instance.new("UICorner", espTracerBtn)

-- Box
local espBoxBtn = Instance.new("TextButton", espScroll)
espBoxBtn.Size = UDim2.new(0.9, 0, 0, 30)
espBoxBtn.Position = UDim2.new(0.05, 0, 0, 125)
espBoxBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
espBoxBtn.TextColor3 = Color3.new(1,1,1)
espBoxBtn.Font = Enum.Font.SourceSansBold
espBoxBtn.TextSize = 14
espBoxBtn.Text = "Box: ON"
Instance.new("UICorner", espBoxBtn)

-- Name
local espNameBtn = Instance.new("TextButton", espScroll)
espNameBtn.Size = UDim2.new(0.9, 0, 0, 30)
espNameBtn.Position = UDim2.new(0.05, 0, 0, 165)
espNameBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
espNameBtn.TextColor3 = Color3.new(1,1,1)
espNameBtn.Font = Enum.Font.SourceSansBold
espNameBtn.TextSize = 14
espNameBtn.Text = "Name: ON"
Instance.new("UICorner", espNameBtn)

-- Health
local espHealthBtn = Instance.new("TextButton", espScroll)
espHealthBtn.Size = UDim2.new(0.9, 0, 0, 30)
espHealthBtn.Position = UDim2.new(0.05, 0, 0, 205)
espHealthBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
espHealthBtn.TextColor3 = Color3.new(1,1,1)
espHealthBtn.Font = Enum.Font.SourceSansBold
espHealthBtn.TextSize = 14
espHealthBtn.Text = "Health: ON"
Instance.new("UICorner", espHealthBtn)

-- Distance
local espDistBtn = Instance.new("TextButton", espScroll)
espDistBtn.Size = UDim2.new(0.9, 0, 0, 30)
espDistBtn.Position = UDim2.new(0.05, 0, 0, 245)
espDistBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
espDistBtn.TextColor3 = Color3.new(1,1,1)
espDistBtn.Font = Enum.Font.SourceSansBold
espDistBtn.TextSize = 14
espDistBtn.Text = "Distance: ON"
Instance.new("UICorner", espDistBtn)

local espTeamCheckBtn = Instance.new("TextButton", espScroll)
espTeamCheckBtn.Size = UDim2.new(0.9, 0, 0, 30)
espTeamCheckBtn.Position = UDim2.new(0.05, 0, 0, 285)
espTeamCheckBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
espTeamCheckBtn.TextColor3 = Color3.new(1,1,1)
espTeamCheckBtn.Font = Enum.Font.SourceSansBold
espTeamCheckBtn.TextSize = 14
espTeamCheckBtn.Text = "ESP Team Check: OFF"
Instance.new("UICorner", espTeamCheckBtn)

-- ESP ValCheck
local espValCheckBtn = Instance.new("TextButton", espScroll)
espValCheckBtn.Size = UDim2.new(0.75, -5, 0, 30)
espValCheckBtn.Position = UDim2.new(0.05, 0, 0, 325)
espValCheckBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
espValCheckBtn.TextColor3 = Color3.new(1,1,1)
espValCheckBtn.Font = Enum.Font.SourceSansBold
espValCheckBtn.TextSize = 14
espValCheckBtn.Text = "ESP ValCheck: OFF"
Instance.new("UICorner", espValCheckBtn)

local espValCheckOpenBtn = Instance.new("TextButton", espScroll)
espValCheckOpenBtn.Size = UDim2.new(0.15, -5, 0, 30)
espValCheckOpenBtn.Position = UDim2.new(0.8, 0, 0, 325)
espValCheckOpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
espValCheckOpenBtn.TextColor3 = Color3.new(1,1,1)
espValCheckOpenBtn.Font = Enum.Font.SourceSansBold
espValCheckOpenBtn.TextSize = 18
espValCheckOpenBtn.Text = "+"
Instance.new("UICorner", espValCheckOpenBtn)

-- Close
local espSettingsCloseBtn = Instance.new("TextButton", espSettingsFrame)
espSettingsCloseBtn.Size = UDim2.new(0.9, 0, 0, 25)
espSettingsCloseBtn.Position = UDim2.new(0.05, 0, 1, -30)
espSettingsCloseBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espSettingsCloseBtn.TextColor3 = Color3.new(1,1,1)
espSettingsCloseBtn.Font = Enum.Font.SourceSansBold
espSettingsCloseBtn.TextSize = 14
espSettingsCloseBtn.Text = "Close"
Instance.new("UICorner", espSettingsCloseBtn)

-- PC / Mobile Trigger кнопки
local pcTriggerButton = Instance.new("TextButton", aimScroll)
pcTriggerButton.Size = UDim2.new(0.44, 0, 0, 30)
pcTriggerButton.Position = UDim2.new(0.05, 0, 0, 385)
pcTriggerButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
pcTriggerButton.TextColor3 = Color3.new(1,1,1)
pcTriggerButton.Font = Enum.Font.SourceSansBold
pcTriggerButton.TextSize = 13
pcTriggerButton.Text = "PC Trigger: OFF"
Instance.new("UICorner", pcTriggerButton)

local mobileTriggerButton = Instance.new("TextButton", aimScroll)
mobileTriggerButton.Size = UDim2.new(0.44, 0, 0, 30)
mobileTriggerButton.Position = UDim2.new(0.51, 0, 0, 385)
mobileTriggerButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mobileTriggerButton.TextColor3 = Color3.new(1,1,1)
mobileTriggerButton.Font = Enum.Font.SourceSansBold
mobileTriggerButton.TextSize = 13
mobileTriggerButton.Text = "Mobile Trigger: OFF"
Instance.new("UICorner", mobileTriggerButton)

-- Val Check кнопка + відкрити список гравців
local valCheckButton = Instance.new("TextButton", aimScroll)
valCheckButton.Size = UDim2.new(0.75, -5, 0, 30)
valCheckButton.Position = UDim2.new(0.05, 0, 0, 425)
valCheckButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
valCheckButton.TextColor3 = Color3.new(1,1,1)
valCheckButton.Font = Enum.Font.SourceSansBold
valCheckButton.TextSize = 14
valCheckButton.Text = "Val Check: OFF"
Instance.new("UICorner", valCheckButton)

local valCheckOpenButton = Instance.new("TextButton", aimScroll)
valCheckOpenButton.Size = UDim2.new(0.15, -5, 0, 30)
valCheckOpenButton.Position = UDim2.new(0.8, 0, 0, 425)
valCheckOpenButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
valCheckOpenButton.TextColor3 = Color3.new(1,1,1)
valCheckOpenButton.Font = Enum.Font.SourceSansBold
valCheckOpenButton.TextSize = 18
valCheckOpenButton.Text = "+"
Instance.new("UICorner", valCheckOpenButton)

local triggerWallCheckButton = Instance.new("TextButton", aimScroll)
triggerWallCheckButton.Size = UDim2.new(0.9, 0, 0, 30)
triggerWallCheckButton.Position = UDim2.new(0.05, 0, 0, 465)
triggerWallCheckButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
triggerWallCheckButton.TextColor3 = Color3.new(1,1,1)
triggerWallCheckButton.Font = Enum.Font.SourceSansBold
triggerWallCheckButton.TextSize = 14
triggerWallCheckButton.Text = "Trigger WallCheck: OFF"
Instance.new("UICorner", triggerWallCheckButton)

local triggerTeamCheckButton = Instance.new("TextButton", aimScroll)
triggerTeamCheckButton.Size = UDim2.new(0.9, 0, 0, 30)
triggerTeamCheckButton.Position = UDim2.new(0.05, 0, 0, 505)
triggerTeamCheckButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
triggerTeamCheckButton.TextColor3 = Color3.new(1,1,1)
triggerTeamCheckButton.Font = Enum.Font.SourceSansBold
triggerTeamCheckButton.TextSize = 14
triggerTeamCheckButton.Text = "Trigger Team Check: OFF"
Instance.new("UICorner", triggerTeamCheckButton)

local aimCloseButton = Instance.new("TextButton", aimSettingsFrame)
aimCloseButton.Size = UDim2.new(0.9, 0, 0, 25)
aimCloseButton.Position = UDim2.new(0.05, 0, 1, -30)
aimCloseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
aimCloseButton.TextColor3 = Color3.new(1,1,1)
aimCloseButton.Font = Enum.Font.SourceSansBold
aimCloseButton.TextSize = 14
aimCloseButton.Text = "Close Menu"
local aimCloseButtonCorner = Instance.new("UICorner", aimCloseButton)

local fovCircleButton = Instance.new("TextButton", aimScroll)
fovCircleButton.Size = UDim2.new(0.9, 0, 0, 30)
fovCircleButton.Position = UDim2.new(0.05, 0, 0, 5)
fovCircleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
fovCircleButton.TextColor3 = Color3.new(1,1,1)
fovCircleButton.Font = Enum.Font.SourceSansBold
fovCircleButton.TextSize = 16
fovCircleButton.Text = "FOV Circle: ON"
local fovCircleButtonCorner = Instance.new("UICorner", fovCircleButton)

local wallButton = Instance.new("TextButton", aimScroll)
wallButton.Size = UDim2.new(0.9, 0, 0, 30)
wallButton.Position = UDim2.new(0.05, 0, 0, 45)
wallButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
wallButton.TextColor3 = Color3.new(1,1,1)
wallButton.Font = Enum.Font.SourceSansBold
wallButton.TextSize = 16
wallButton.Text = "WallCheck: OFF"
local wallButtonCorner = Instance.new("UICorner", wallButton)

-- AIM Val Check кнопка (після wallButton, перед FOV)
local aimValCheckButton = Instance.new("TextButton", aimScroll)
aimValCheckButton.Size = UDim2.new(0.75, -5, 0, 30)
aimValCheckButton.Position = UDim2.new(0.05, 0, 0, 85)
aimValCheckButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
aimValCheckButton.TextColor3 = Color3.new(1,1,1)
aimValCheckButton.Font = Enum.Font.SourceSansBold
aimValCheckButton.TextSize = 14
aimValCheckButton.Text = "AIM ValCheck: OFF"
Instance.new("UICorner", aimValCheckButton)

local aimValCheckOpenButton = Instance.new("TextButton", aimScroll)
aimValCheckOpenButton.Size = UDim2.new(0.15, -5, 0, 30)
aimValCheckOpenButton.Position = UDim2.new(0.8, 0, 0, 85)
aimValCheckOpenButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
aimValCheckOpenButton.TextColor3 = Color3.new(1,1,1)
aimValCheckOpenButton.Font = Enum.Font.SourceSansBold
aimValCheckOpenButton.TextSize = 18
aimValCheckOpenButton.Text = "+"
Instance.new("UICorner", aimValCheckOpenButton)

local aimFOVInputLabel = Instance.new("TextLabel", aimScroll)
aimFOVInputLabel.Size = UDim2.new(0.4, 0, 0, 25)
aimFOVInputLabel.Position = UDim2.new(0.05, 0, 0, 125)
aimFOVInputLabel.BackgroundTransparency = 1
aimFOVInputLabel.Text = "Aim FOV:"
aimFOVInputLabel.Font = Enum.Font.SourceSansBold
aimFOVInputLabel.TextSize = 14
aimFOVInputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
aimFOVInputLabel.TextXAlignment = Enum.TextXAlignment.Left

local aimFOVInput = Instance.new("TextBox", aimScroll)
aimFOVInput.Size = UDim2.new(0.45, 0, 0, 25)
aimFOVInput.Position = UDim2.new(0.5, 0, 0, 125)
aimFOVInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
aimFOVInput.TextColor3 = Color3.new(1,1,1)
aimFOVInput.Font = Enum.Font.SourceSans
aimFOVInput.TextSize = 14
aimFOVInput.Text = "60"
local aimFOVInputCorner = Instance.new("UICorner", aimFOVInput)

local aimFOVSliderFrame = Instance.new("Frame", aimScroll)
aimFOVSliderFrame.Size = UDim2.new(0.9, 0, 0, 15)
aimFOVSliderFrame.Position = UDim2.new(0.05, 0, 0, 155)
aimFOVSliderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
aimFOVSliderFrame.BorderSizePixel = 0
local aimFOVSliderCorner = Instance.new("UICorner", aimFOVSliderFrame)

local aimFOVSliderButton = Instance.new("Frame", aimFOVSliderFrame)
aimFOVSliderButton.Size = UDim2.new(0, 20, 0, 20)
aimFOVSliderButton.Position = UDim2.new(0.18, -10, 0, -2.5)
aimFOVSliderButton.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
aimFOVSliderButton.BorderSizePixel = 0
local aimFOVSliderButtonCorner = Instance.new("UICorner", aimFOVSliderButton)
aimFOVSliderButtonCorner.CornerRadius = UDim.new(1, 0)

local smoothButton = Instance.new("TextButton", aimScroll)
smoothButton.Size = UDim2.new(0.9, 0, 0, 30)
smoothButton.Position = UDim2.new(0.05, 0, 0, 175)
smoothButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
smoothButton.TextColor3 = Color3.new(1,1,1)
smoothButton.Font = Enum.Font.SourceSansBold
smoothButton.TextSize = 14
smoothButton.Text = "Smooth: OFF"
Instance.new("UICorner", smoothButton)

-- Smooth Aim слайдер
local smoothLabel = Instance.new("TextLabel", aimScroll)
smoothLabel.Size = UDim2.new(0.4, 0, 0, 25)
smoothLabel.Position = UDim2.new(0.05, 0, 0, 215)
smoothLabel.BackgroundTransparency = 1
smoothLabel.Text = "Smooth:"
smoothLabel.Font = Enum.Font.SourceSansBold
smoothLabel.TextSize = 14
smoothLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
smoothLabel.TextXAlignment = Enum.TextXAlignment.Left

local smoothInput = Instance.new("TextBox", aimScroll)
smoothInput.Size = UDim2.new(0.45, 0, 0, 25)
smoothInput.Position = UDim2.new(0.5, 0, 0, 215)
smoothInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
smoothInput.TextColor3 = Color3.new(1,1,1)
smoothInput.Font = Enum.Font.SourceSans
smoothInput.TextSize = 14
smoothInput.Text = "1"
Instance.new("UICorner", smoothInput)

local smoothSliderFrame = Instance.new("Frame", aimScroll)
smoothSliderFrame.Size = UDim2.new(0.9, 0, 0, 15)
smoothSliderFrame.Position = UDim2.new(0.05, 0, 0, 245)
smoothSliderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
smoothSliderFrame.BorderSizePixel = 0
Instance.new("UICorner", smoothSliderFrame)

local smoothSliderButton = Instance.new("Frame", smoothSliderFrame)
smoothSliderButton.Size = UDim2.new(0, 20, 0, 20)
smoothSliderButton.Position = UDim2.new(0.2, -10, 0, -2.5)
smoothSliderButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
smoothSliderButton.BorderSizePixel = 0
local smoothSliderButtonCorner = Instance.new("UICorner", smoothSliderButton)
smoothSliderButtonCorner.CornerRadius = UDim.new(1, 0)

-- Team Check кнопка
local teamCheckButton = Instance.new("TextButton", aimScroll)
teamCheckButton.Size = UDim2.new(0.9, 0, 0, 30)
teamCheckButton.Position = UDim2.new(0.05, 0, 0, 275)
teamCheckButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
teamCheckButton.TextColor3 = Color3.new(1,1,1)
teamCheckButton.Font = Enum.Font.SourceSansBold
teamCheckButton.TextSize = 14
teamCheckButton.Text = "Team Check: OFF"
Instance.new("UICorner", teamCheckButton)

-- Silent Aim кнопка
local silentAimButton = Instance.new("TextButton", aimScroll)
silentAimButton.Size = UDim2.new(0.9, 0, 0, 30)
silentAimButton.Position = UDim2.new(0.05, 0, 0, 315)
silentAimButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
silentAimButton.TextColor3 = Color3.new(1,1,1)
silentAimButton.Font = Enum.Font.SourceSansBold
silentAimButton.TextSize = 14
silentAimButton.Text = "Silent Aim: OFF"
Instance.new("UICorner", silentAimButton)

local hitboxSettingsFrame = Instance.new("Frame", screenGui)
hitboxSettingsFrame.Size = UDim2.new(0, 200, 0, 310)
hitboxSettingsFrame.Position = UDim2.new(0.5, 100, 0.3, 0)
hitboxSettingsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
hitboxSettingsFrame.BorderSizePixel = 0
hitboxSettingsFrame.Visible = false
hitboxSettingsFrame.Active = true
local hitboxSettingsCorner = Instance.new("UICorner", hitboxSettingsFrame)

local hitboxSettingsTitle = Instance.new("TextLabel", hitboxSettingsFrame)
hitboxSettingsTitle.Size = UDim2.new(1, 0, 0, 30)
hitboxSettingsTitle.BackgroundTransparency = 1
hitboxSettingsTitle.Text = "Hitbox Settings"
hitboxSettingsTitle.Font = Enum.Font.SourceSansBold
hitboxSettingsTitle.TextSize = 16
hitboxSettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)

local hitboxScroll = Instance.new("ScrollingFrame", hitboxSettingsFrame)
hitboxScroll.Size = UDim2.new(1, 0, 1, -65)
hitboxScroll.Position = UDim2.new(0, 0, 0, 35)
hitboxScroll.BackgroundTransparency = 1
hitboxScroll.ScrollBarThickness = 6
hitboxScroll.CanvasSize = UDim2.new(0, 0, 0, 300)

local hitboxHeadButton = Instance.new("TextButton", hitboxScroll)
hitboxHeadButton.Size = UDim2.new(0.9, 0, 0, 40)
hitboxHeadButton.Position = UDim2.new(0.05, 0, 0, 10)
hitboxHeadButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
hitboxHeadButton.TextColor3 = Color3.new(1,1,1)
hitboxHeadButton.Font = Enum.Font.SourceSansBold
hitboxHeadButton.TextSize = 16
hitboxHeadButton.Text = "🎯 Head"
local hitboxHeadButtonCorner = Instance.new("UICorner", hitboxHeadButton)

local hitboxTorsoButton = Instance.new("TextButton", hitboxScroll)
hitboxTorsoButton.Size = UDim2.new(0.9, 0, 0, 40)
hitboxTorsoButton.Position = UDim2.new(0.05, 0, 0, 60)
hitboxTorsoButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
hitboxTorsoButton.TextColor3 = Color3.new(1,1,1)
hitboxTorsoButton.Font = Enum.Font.SourceSansBold
hitboxTorsoButton.TextSize = 16
hitboxTorsoButton.Text = "💪 Torso"
local hitboxTorsoButtonCorner = Instance.new("UICorner", hitboxTorsoButton)

local hitboxArmsButton = Instance.new("TextButton", hitboxScroll)
hitboxArmsButton.Size = UDim2.new(0.9, 0, 0, 40)
hitboxArmsButton.Position = UDim2.new(0.05, 0, 0, 110)
hitboxArmsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
hitboxArmsButton.TextColor3 = Color3.new(1,1,1)
hitboxArmsButton.Font = Enum.Font.SourceSansBold
hitboxArmsButton.TextSize = 16
hitboxArmsButton.Text = "👐 Arms"
local hitboxArmsButtonCorner = Instance.new("UICorner", hitboxArmsButton)

local hitboxLegsButton = Instance.new("TextButton", hitboxScroll)
hitboxLegsButton.Size = UDim2.new(0.9, 0, 0, 40)
hitboxLegsButton.Position = UDim2.new(0.05, 0, 0, 160)
hitboxLegsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
hitboxLegsButton.TextColor3 = Color3.new(1,1,1)
hitboxLegsButton.Font = Enum.Font.SourceSansBold
hitboxLegsButton.TextSize = 16
hitboxLegsButton.Text = "🦵 Legs"
local hitboxLegsButtonCorner = Instance.new("UICorner", hitboxLegsButton)

local hitboxSizeLabel = Instance.new("TextLabel", hitboxScroll)
hitboxSizeLabel.Size = UDim2.new(0.4, 0, 0, 25)
hitboxSizeLabel.Position = UDim2.new(0.05, 0, 0, 210)
hitboxSizeLabel.BackgroundTransparency = 1
hitboxSizeLabel.Text = "Size:"
hitboxSizeLabel.Font = Enum.Font.SourceSansBold
hitboxSizeLabel.TextSize = 14
hitboxSizeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
hitboxSizeLabel.TextXAlignment = Enum.TextXAlignment.Left

local hitboxSizeInput = Instance.new("TextBox", hitboxScroll)
hitboxSizeInput.Size = UDim2.new(0.45, 0, 0, 25)
hitboxSizeInput.Position = UDim2.new(0.5, 0, 0, 210)
hitboxSizeInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
hitboxSizeInput.TextColor3 = Color3.new(1,1,1)
hitboxSizeInput.Font = Enum.Font.SourceSans
hitboxSizeInput.TextSize = 14
hitboxSizeInput.Text = "20"
hitboxSizeInput.PlaceholderText = "5-50"
local hitboxSizeInputCorner = Instance.new("UICorner", hitboxSizeInput)

local hitboxCloseButton = Instance.new("TextButton", hitboxSettingsFrame)
hitboxCloseButton.Size = UDim2.new(0.9, 0, 0, 25)
hitboxCloseButton.Position = UDim2.new(0.05, 0, 1, -30)
hitboxCloseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
hitboxCloseButton.TextColor3 = Color3.new(1,1,1)
hitboxCloseButton.Font = Enum.Font.SourceSansBold
hitboxCloseButton.TextSize = 14
hitboxCloseButton.Text = "Close Menu"
local hitboxCloseButtonCorner = Instance.new("UICorner", hitboxCloseButton)

local teleportFrame = Instance.new("Frame", screenGui)
teleportFrame.Size = UDim2.new(0, 200, 0, 300)
teleportFrame.Position = UDim2.new(0.5, -100, 0.5, -150)
teleportFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
teleportFrame.BorderSizePixel = 0
teleportFrame.Visible = false
teleportFrame.Active = true
local teleportFrameCorner = Instance.new("UICorner", teleportFrame)

local teleportTitle = Instance.new("TextLabel", teleportFrame)
teleportTitle.Size = UDim2.new(1, 0, 0, 30)
teleportTitle.BackgroundTransparency = 1
teleportTitle.Text = "Teleport to players"
teleportTitle.Font = Enum.Font.SourceSansBold
teleportTitle.TextSize = 16
teleportTitle.TextColor3 = Color3.fromRGB(255, 255, 255)

local backButton = Instance.new("TextButton", teleportFrame)
backButton.Size = UDim2.new(0.9, 0, 0, 25)
backButton.Position = UDim2.new(0.05, 0, 1, -30)
backButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
backButton.TextColor3 = Color3.new(1,1,1)
backButton.Font = Enum.Font.SourceSansBold
backButton.TextSize = 14
backButton.Text = "← Back"
local backButtonCorner = Instance.new("UICorner", backButton)

local teleportScroll = Instance.new("ScrollingFrame", teleportFrame)
teleportScroll.Size = UDim2.new(1, 0, 1, -65)
teleportScroll.Position = UDim2.new(0, 0, 0, 35)
teleportScroll.BackgroundTransparency = 1
teleportScroll.ScrollBarThickness = 6
teleportScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local scrollFrame = Instance.new("ScrollingFrame", frame)
scrollFrame.Size = UDim2.new(1, 0, 1, -60)
scrollFrame.Position = UDim2.new(0, 0, 0, 30)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 6
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 1000)

local titleLabel = Instance.new("TextLabel", frame)
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Smile Mod Menu"
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 20
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

local function createButton(text, yPos, parent)
	local btn = Instance.new("TextButton", parent or scrollFrame)
	btn.Size = UDim2.new(0.9, 0, 0, 30)
	btn.Position = UDim2.new(0.05, 0, 0, yPos)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 16
	btn.Text = text
	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0, 8)
	return btn
end

local teleportButton = createButton("Teleport", 10)
local aimButton = createButton("AIM: OFF", 50)
aimButton.Size = UDim2.new(0.75, -5, 0, 30)

local aimSettingsOpenButton = Instance.new("TextButton", scrollFrame)
aimSettingsOpenButton.Size = UDim2.new(0.15, -5, 0, 30)
aimSettingsOpenButton.Position = UDim2.new(0.8, 0, 0, 50)
aimSettingsOpenButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
aimSettingsOpenButton.TextColor3 = Color3.new(1,1,1)
aimSettingsOpenButton.Font = Enum.Font.SourceSansBold
aimSettingsOpenButton.TextSize = 18
aimSettingsOpenButton.Text = "+"
local aimSettingsOpenButtonCorner = Instance.new("UICorner", aimSettingsOpenButton)

local espButton = createButton("ESP: OFF", 90)
espButton.Size = UDim2.new(0.75, -5, 0, 30)

local espSettingsOpenButton = Instance.new("TextButton", scrollFrame)
espSettingsOpenButton.Size = UDim2.new(0.15, -5, 0, 30)
espSettingsOpenButton.Position = UDim2.new(0.8, 0, 0, 90)
espSettingsOpenButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
espSettingsOpenButton.TextColor3 = Color3.new(1,1,1)
espSettingsOpenButton.Font = Enum.Font.SourceSansBold
espSettingsOpenButton.TextSize = 18
espSettingsOpenButton.Text = "+"
Instance.new("UICorner", espSettingsOpenButton)

local charmsButton = createButton("Charms: OFF", 130)
charmsButton.Size = UDim2.new(0.75, -5, 0, 30)

local charmsSettingsOpenButton = Instance.new("TextButton", scrollFrame)
charmsSettingsOpenButton.Size = UDim2.new(0.15, -5, 0, 30)
charmsSettingsOpenButton.Position = UDim2.new(0.8, 0, 0, 130)
charmsSettingsOpenButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
charmsSettingsOpenButton.TextColor3 = Color3.new(1,1,1)
charmsSettingsOpenButton.Font = Enum.Font.SourceSansBold
charmsSettingsOpenButton.TextSize = 18
charmsSettingsOpenButton.Text = "+"
Instance.new("UICorner", charmsSettingsOpenButton)

local infiniteJumpButton = createButton("Infinite Jump: OFF", 170)
local noclipButton = createButton("Noclip: OFF", 210)
local bunnyHopButton = createButton("BunnyHop: OFF", 250)
local skyButton = createButton("Sky: Default", 290)
local chaosButton = createButton("Chaos: OFF", 330)
local thirdPersonButton = createButton("Third Person: OFF", 370)
local wallHopButton = createButton("Wall Hop: OFF", 410)

local hitboxButton = createButton("Hitbox: OFF", 450)
hitboxButton.Size = UDim2.new(0.75, -5, 0, 30)

local hitboxSettingsOpenButton = Instance.new("TextButton", scrollFrame)
hitboxSettingsOpenButton.Size = UDim2.new(0.15, -5, 0, 30)
hitboxSettingsOpenButton.Position = UDim2.new(0.8, 0, 0, 450)
hitboxSettingsOpenButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
hitboxSettingsOpenButton.TextColor3 = Color3.new(1,1,1)
hitboxSettingsOpenButton.Font = Enum.Font.SourceSansBold
hitboxSettingsOpenButton.TextSize = 18
hitboxSettingsOpenButton.Text = "+"
local hitboxSettingsOpenButtonCorner = Instance.new("UICorner", hitboxSettingsOpenButton)

local fullbrightButton = createButton("Fullbright: OFF", 490)
local godModeButton = createButton("God Mode: OFF", 530)
local fpsBoostButton = createButton("FPS Boost: OFF", 570)
local antiAfkButton = createButton("Anti AFK: OFF", 610)
local configButton = createButton("⚙️ Config", 650)

local flyInputLabel = Instance.new("TextLabel", scrollFrame)
flyInputLabel.Size = UDim2.new(0.4, 0, 0, 25)
flyInputLabel.Position = UDim2.new(0.05, 0, 0, 695)
flyInputLabel.BackgroundTransparency = 1
flyInputLabel.Text = "Fly Speed:"
flyInputLabel.Font = Enum.Font.SourceSansBold
flyInputLabel.TextSize = 14
flyInputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
flyInputLabel.TextXAlignment = Enum.TextXAlignment.Left

local flyInput = Instance.new("TextBox", scrollFrame)
flyInput.Size = UDim2.new(0.45, 0, 0, 25)
flyInput.Position = UDim2.new(0.5, 0, 0, 695)
flyInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
flyInput.TextColor3 = Color3.new(1,1,1)
flyInput.Font = Enum.Font.SourceSans
flyInput.TextSize = 14
flyInput.Text = "50"
local flyInputCorner = Instance.new("UICorner", flyInput)

local flyButton = createButton("Fly: OFF", 725)

local speedInputLabel = Instance.new("TextLabel", scrollFrame)
speedInputLabel.Size = UDim2.new(0.4, 0, 0, 25)
speedInputLabel.Position = UDim2.new(0.05, 0, 0, 765)
speedInputLabel.BackgroundTransparency = 1
speedInputLabel.Text = "Speed:"
speedInputLabel.Font = Enum.Font.SourceSansBold
speedInputLabel.TextSize = 14
speedInputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedInputLabel.TextXAlignment = Enum.TextXAlignment.Left

local speedInput = Instance.new("TextBox", scrollFrame)
speedInput.Size = UDim2.new(0.45, 0, 0, 25)
speedInput.Position = UDim2.new(0.5, 0, 0, 765)
speedInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedInput.TextColor3 = Color3.new(1,1,1)
speedInput.Font = Enum.Font.SourceSans
speedInput.TextSize = 14
speedInput.Text = "16"
local speedInputCorner = Instance.new("UICorner", speedInput)

local sliderFrame = Instance.new("Frame", scrollFrame)
sliderFrame.Size = UDim2.new(0.9, 0, 0, 15)
sliderFrame.Position = UDim2.new(0.05, 0, 0, 795)
sliderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
sliderFrame.BorderSizePixel = 0
local sliderCorner = Instance.new("UICorner", sliderFrame)

local sliderButton = Instance.new("Frame", sliderFrame)
sliderButton.Size = UDim2.new(0, 20, 0, 20)
sliderButton.Position = UDim2.new(0, -2, 0, -2.5)
sliderButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
sliderButton.BorderSizePixel = 0
local sliderButtonCorner = Instance.new("UICorner", sliderButton)
sliderButtonCorner.CornerRadius = UDim.new(1, 0)

local speedButton = createButton("Speed: OFF", 820)

local fovInputLabel = Instance.new("TextLabel", scrollFrame)
fovInputLabel.Size = UDim2.new(0.4, 0, 0, 25)
fovInputLabel.Position = UDim2.new(0.05, 0, 0, 860)
fovInputLabel.BackgroundTransparency = 1
fovInputLabel.Text = "FOV:"
fovInputLabel.Font = Enum.Font.SourceSansBold
fovInputLabel.TextSize = 14
fovInputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fovInputLabel.TextXAlignment = Enum.TextXAlignment.Left

local fovInput = Instance.new("TextBox", scrollFrame)
fovInput.Size = UDim2.new(0.45, 0, 0, 25)
fovInput.Position = UDim2.new(0.5, 0, 0, 860)
fovInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
fovInput.TextColor3 = Color3.new(1,1,1)
fovInput.Font = Enum.Font.SourceSans
fovInput.TextSize = 14
fovInput.Text = "70"
local fovInputCorner = Instance.new("UICorner", fovInput)

local fovSliderFrame = Instance.new("Frame", scrollFrame)
fovSliderFrame.Size = UDim2.new(0.9, 0, 0, 15)
fovSliderFrame.Position = UDim2.new(0.05, 0, 0, 890)
fovSliderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
fovSliderFrame.BorderSizePixel = 0
local fovSliderCorner = Instance.new("UICorner", fovSliderFrame)

local fovSliderButton = Instance.new("Frame", fovSliderFrame)
fovSliderButton.Size = UDim2.new(0, 20, 0, 20)
fovSliderButton.Position = UDim2.new(0.44, -10, 0, -2.5)
fovSliderButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
fovSliderButton.BorderSizePixel = 0
local fovSliderButtonCorner = Instance.new("UICorner", fovSliderButton)
fovSliderButtonCorner.CornerRadius = UDim.new(1, 0)

local fovButton = createButton("FOV: OFF", 915)

local minimizeButton = Instance.new("TextButton", frame)
minimizeButton.Size = UDim2.new(0.9, 0, 0, 25)
minimizeButton.Position = UDim2.new(0.05, 0, 1, -30)
minimizeButton.Text = "Minimize menu"
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
minimizeButton.BorderSizePixel = 0
minimizeButton.Font = Enum.Font.SourceSansBold
minimizeButton.TextSize = 14
local minimizeButtonCorner = Instance.new("UICorner", minimizeButton)

local minimizedCircle = Instance.new("TextButton", screenGui)
minimizedCircle.Size = UDim2.new(0, 30, 0, 30)
minimizedCircle.Position = UDim2.new(0, 300, 0, 200)
minimizedCircle.Text = ""
minimizedCircle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
minimizedCircle.BorderSizePixel = 0
minimizedCircle.Visible = false
minimizedCircle.AnchorPoint = Vector2.new(0.5, 0.5)
local corner = Instance.new("UICorner", minimizedCircle)
corner.CornerRadius = UDim.new(1, 0)

-- Config вікно
local configFrame = Instance.new("Frame", screenGui)
configFrame.Size = UDim2.new(0, 230, 0, 370)
configFrame.Position = UDim2.new(0.5, -115, 0.5, -170)
configFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
configFrame.BorderSizePixel = 0
configFrame.Visible = false
configFrame.Active = true
local configFrameCorner = Instance.new("UICorner", configFrame)

-- Панель вибору гравців для Val Check
local playerSelectFrame = Instance.new("Frame", screenGui)
playerSelectFrame.Size = UDim2.new(0, 180, 0, 280)
playerSelectFrame.Position = UDim2.new(0.5, 110, 0.3, 0)
playerSelectFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
playerSelectFrame.BorderSizePixel = 0
playerSelectFrame.Visible = false
playerSelectFrame.Active = true
Instance.new("UICorner", playerSelectFrame)

local aimValCheckFrame = Instance.new("Frame", screenGui)
aimValCheckFrame.Size = UDim2.new(0, 180, 0, 280)
aimValCheckFrame.Position = UDim2.new(0.5, 110, 0.3, 0)
aimValCheckFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
aimValCheckFrame.BorderSizePixel = 0
aimValCheckFrame.Visible = false
aimValCheckFrame.Active = true
Instance.new("UICorner", aimValCheckFrame)

local aimValCheckTitle = Instance.new("TextLabel", aimValCheckFrame)
aimValCheckTitle.Size = UDim2.new(1, 0, 0, 30)
aimValCheckTitle.BackgroundTransparency = 1
aimValCheckTitle.Text = "AIM Players"
aimValCheckTitle.Font = Enum.Font.SourceSansBold
aimValCheckTitle.TextSize = 15
aimValCheckTitle.TextColor3 = Color3.fromRGB(255, 255, 255)

local aimValCheckScroll = Instance.new("ScrollingFrame", aimValCheckFrame)
aimValCheckScroll.Size = UDim2.new(1, 0, 1, -65)
aimValCheckScroll.Position = UDim2.new(0, 0, 0, 35)
aimValCheckScroll.BackgroundTransparency = 1
aimValCheckScroll.ScrollBarThickness = 5
aimValCheckScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local aimValCheckClose = Instance.new("TextButton", aimValCheckFrame)
aimValCheckClose.Size = UDim2.new(0.9, 0, 0, 25)
aimValCheckClose.Position = UDim2.new(0.05, 0, 1, -30)
aimValCheckClose.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
aimValCheckClose.TextColor3 = Color3.new(1,1,1)
aimValCheckClose.Font = Enum.Font.SourceSansBold
aimValCheckClose.TextSize = 14
aimValCheckClose.Text = "Close"
Instance.new("UICorner", aimValCheckClose)

local playerSelectTitle = Instance.new("TextLabel", playerSelectFrame)
playerSelectTitle.Size = UDim2.new(1, 0, 0, 30)
playerSelectTitle.BackgroundTransparency = 1
playerSelectTitle.Text = "Val Check Players"
playerSelectTitle.Font = Enum.Font.SourceSansBold
playerSelectTitle.TextSize = 15
playerSelectTitle.TextColor3 = Color3.fromRGB(255, 255, 255)

local playerSelectScroll = Instance.new("ScrollingFrame", playerSelectFrame)
playerSelectScroll.Size = UDim2.new(1, 0, 1, -65)
playerSelectScroll.Position = UDim2.new(0, 0, 0, 35)
playerSelectScroll.BackgroundTransparency = 1
playerSelectScroll.ScrollBarThickness = 5
playerSelectScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local playerSelectClose = Instance.new("TextButton", playerSelectFrame)
playerSelectClose.Size = UDim2.new(0.9, 0, 0, 25)
playerSelectClose.Position = UDim2.new(0.05, 0, 1, -30)
playerSelectClose.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
playerSelectClose.TextColor3 = Color3.new(1,1,1)
playerSelectClose.Font = Enum.Font.SourceSansBold
playerSelectClose.TextSize = 14
playerSelectClose.Text = "Close"
Instance.new("UICorner", playerSelectClose)

-- Mobile Trigger GUI
local mobileGui = Instance.new("Frame", screenGui)
mobileGui.Size = UDim2.new(0, 160, 0, 95)
mobileGui.Position = UDim2.new(0, 20, 1, -160)
mobileGui.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mobileGui.BorderSizePixel = 0
mobileGui.Visible = false
mobileGui.Active = true
Instance.new("UICorner", mobileGui)

-- WASD + діагональні кнопки
local mobileWBtn = Instance.new("TextButton", mobileGui)
mobileWBtn.Size = UDim2.new(0,40,0,40)
mobileWBtn.Position = UDim2.new(0,60,0,5)
mobileWBtn.BackgroundColor3 = Color3.fromRGB(40,40,60)
mobileWBtn.Text = "W"
mobileWBtn.TextColor3 = Color3.new(1,1,1)
mobileWBtn.TextSize = 16
mobileWBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", mobileWBtn)

local mobileABtn = Instance.new("TextButton", mobileGui)
mobileABtn.Size = UDim2.new(0,40,0,40)
mobileABtn.Position = UDim2.new(0,10,0,50)
mobileABtn.BackgroundColor3 = Color3.fromRGB(40,40,60)
mobileABtn.Text = "A"
mobileABtn.TextColor3 = Color3.new(1,1,1)
mobileABtn.TextSize = 16
mobileABtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", mobileABtn)

local mobileSBtn = Instance.new("TextButton", mobileGui)
mobileSBtn.Size = UDim2.new(0,40,0,40)
mobileSBtn.Position = UDim2.new(0,60,0,50)
mobileSBtn.BackgroundColor3 = Color3.fromRGB(40,40,60)
mobileSBtn.Text = "S"
mobileSBtn.TextColor3 = Color3.new(1,1,1)
mobileSBtn.TextSize = 16
mobileSBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", mobileSBtn)

local mobileDBtn = Instance.new("TextButton", mobileGui)
mobileDBtn.Size = UDim2.new(0,40,0,40)
mobileDBtn.Position = UDim2.new(0,110,0,50)
mobileDBtn.BackgroundColor3 = Color3.fromRGB(40,40,60)
mobileDBtn.Text = "D"
mobileDBtn.TextColor3 = Color3.new(1,1,1)
mobileDBtn.TextSize = 16
mobileDBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", mobileDBtn)

-- Діагональні
local mobileWABtn = Instance.new("TextButton", mobileGui)
mobileWABtn.Size = UDim2.new(0,40,0,40)
mobileWABtn.Position = UDim2.new(0,10,0,5)
mobileWABtn.BackgroundColor3 = Color3.fromRGB(60,30,30)
mobileWABtn.Text = "↙"
mobileWABtn.TextColor3 = Color3.fromRGB(255,80,80)
mobileWABtn.TextSize = 20
mobileWABtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", mobileWABtn)

local mobileWDBtn = Instance.new("TextButton", mobileGui)
mobileWDBtn.Size = UDim2.new(0,40,0,40)
mobileWDBtn.Position = UDim2.new(0,110,0,5)
mobileWDBtn.BackgroundColor3 = Color3.fromRGB(60,30,30)
mobileWDBtn.Text = "↘"
mobileWDBtn.TextColor3 = Color3.fromRGB(255,80,80)
mobileWDBtn.TextSize = 20
mobileWDBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", mobileWDBtn)

-- Space окремо справа
local mobileSpaceFrame = Instance.new("Frame", screenGui)
mobileSpaceFrame.Size = UDim2.new(0, 80, 0, 60)
mobileSpaceFrame.Position = UDim2.new(1, -100, 1, -80)
mobileSpaceFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mobileSpaceFrame.BorderSizePixel = 0
mobileSpaceFrame.Visible = false
mobileSpaceFrame.Active = true
Instance.new("UICorner", mobileSpaceFrame)

local mobileSpaceBtn = Instance.new("TextButton", mobileSpaceFrame)
mobileSpaceBtn.Size = UDim2.new(1,-10,1,-10)
mobileSpaceBtn.Position = UDim2.new(0,5,0,5)
mobileSpaceBtn.BackgroundColor3 = Color3.fromRGB(40,40,60)
mobileSpaceBtn.Text = "SPACE"
mobileSpaceBtn.TextColor3 = Color3.new(1,1,1)
mobileSpaceBtn.TextSize = 14
mobileSpaceBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", mobileSpaceBtn)

local configTitle = Instance.new("TextLabel", configFrame)
configTitle.Size = UDim2.new(1, 0, 0, 30)
configTitle.BackgroundTransparency = 1
configTitle.Text = "⚙️ Config Manager"
configTitle.Font = Enum.Font.SourceSansBold
configTitle.TextSize = 18
configTitle.TextColor3 = Color3.fromRGB(255, 255, 255)

local configBackButton = Instance.new("TextButton", configFrame)
configBackButton.Size = UDim2.new(0.9, 0, 0, 25)
configBackButton.Position = UDim2.new(0.05, 0, 1, -30)
configBackButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
configBackButton.TextColor3 = Color3.new(1,1,1)
configBackButton.Font = Enum.Font.SourceSansBold
configBackButton.TextSize = 14
configBackButton.Text = "← Back"
local configBackButtonCorner = Instance.new("UICorner", configBackButton)

local configNameLabel = Instance.new("TextLabel", configFrame)
configNameLabel.Size = UDim2.new(0.9, 0, 0, 20)
configNameLabel.Position = UDim2.new(0.05, 0, 0, 40)
configNameLabel.BackgroundTransparency = 1
configNameLabel.Text = "Config Name:"
configNameLabel.Font = Enum.Font.SourceSansBold
configNameLabel.TextSize = 14
configNameLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
configNameLabel.TextXAlignment = Enum.TextXAlignment.Left

local configNameInput = Instance.new("TextBox", configFrame)
configNameInput.Size = UDim2.new(0.9, 0, 0, 35)
configNameInput.Position = UDim2.new(0.05, 0, 0, 62)
configNameInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
configNameInput.TextColor3 = Color3.new(1,1,1)
configNameInput.Font = Enum.Font.SourceSans
configNameInput.TextSize = 15
configNameInput.Text = ""
configNameInput.PlaceholderText = "Введи ім'я конфігу..."
local configNameInputCorner = Instance.new("UICorner", configNameInput)

local saveConfigButton = Instance.new("TextButton", configFrame)
saveConfigButton.Size = UDim2.new(0.43, 0, 0, 35)
saveConfigButton.Position = UDim2.new(0.05, 0, 0, 105)
saveConfigButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
saveConfigButton.TextColor3 = Color3.new(1,1,1)
saveConfigButton.Font = Enum.Font.SourceSansBold
saveConfigButton.TextSize = 15
saveConfigButton.Text = "💾 Save"
local saveConfigButtonCorner = Instance.new("UICorner", saveConfigButton)

local loadConfigButton = Instance.new("TextButton", configFrame)
loadConfigButton.Size = UDim2.new(0.43, 0, 0, 35)
loadConfigButton.Position = UDim2.new(0.52, 0, 0, 105)
loadConfigButton.BackgroundColor3 = Color3.fromRGB(0, 130, 255)
loadConfigButton.TextColor3 = Color3.new(1,1,1)
loadConfigButton.Font = Enum.Font.SourceSansBold
loadConfigButton.TextSize = 15
loadConfigButton.Text = "📂 Load"
local loadConfigButtonCorner = Instance.new("UICorner", loadConfigButton)

local configListLabel = Instance.new("TextLabel", configFrame)
configListLabel.Size = UDim2.new(0.9, 0, 0, 20)
configListLabel.Position = UDim2.new(0.05, 0, 0, 150)
configListLabel.BackgroundTransparency = 1
configListLabel.Text = "Saved Configs:"
configListLabel.Font = Enum.Font.SourceSansBold
configListLabel.TextSize = 14
configListLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
configListLabel.TextXAlignment = Enum.TextXAlignment.Left

local configScroll = Instance.new("ScrollingFrame", configFrame)
configScroll.Size = UDim2.new(0.9, 0, 0, 120)
configScroll.Position = UDim2.new(0.05, 0, 0, 165)
configScroll.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
configScroll.BorderSizePixel = 0
configScroll.ScrollBarThickness = 5
configScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
local configScrollCorner = Instance.new("UICorner", configScroll)

local deleteConfigButton = Instance.new("TextButton", configFrame)
deleteConfigButton.Size = UDim2.new(0.9, 0, 0, 35)
deleteConfigButton.Position = UDim2.new(0.05, 0, 0, 295)
deleteConfigButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
deleteConfigButton.TextColor3 = Color3.new(1,1,1)
deleteConfigButton.Font = Enum.Font.SourceSansBold
deleteConfigButton.TextSize = 15
deleteConfigButton.Text = "🗑️ Delete Selected"
local deleteConfigButtonCorner = Instance.new("UICorner", deleteConfigButton)

-- Повертаємо всі елементи
return {
	screenGui = screenGui,
	frame = frame,
	titleLabel = titleLabel,
	scrollFrame = scrollFrame,
	aimSettingsFrame = aimSettingsFrame,
	aimSettingsTitle = aimSettingsTitle,
	aimCloseButton = aimCloseButton,
	fovCircleButton = fovCircleButton,
	wallButton = wallButton,
	aimFOVInput = aimFOVInput,
	aimFOVSliderFrame = aimFOVSliderFrame,
	aimFOVSliderButton = aimFOVSliderButton,
	hitboxSettingsFrame = hitboxSettingsFrame,
	hitboxSettingsTitle = hitboxSettingsTitle,
	hitboxHeadButton = hitboxHeadButton,
	hitboxTorsoButton = hitboxTorsoButton,
	hitboxArmsButton = hitboxArmsButton,
	hitboxLegsButton = hitboxLegsButton,
	hitboxSizeInput = hitboxSizeInput,
	hitboxCloseButton = hitboxCloseButton,
	teleportFrame = teleportFrame,
	teleportTitle = teleportTitle,
	teleportScroll = teleportScroll,
	backButton = backButton,
	teleportButton = teleportButton,
	aimButton = aimButton,
	aimSettingsOpenButton = aimSettingsOpenButton,
	espButton = espButton,
	charmsButton = charmsButton,
	infiniteJumpButton = infiniteJumpButton,
	noclipButton = noclipButton,
	bunnyHopButton = bunnyHopButton,
	skyButton = skyButton,
	chaosButton = chaosButton,
	thirdPersonButton = thirdPersonButton,
	wallHopButton = wallHopButton,
	hitboxButton = hitboxButton,
	hitboxSettingsOpenButton = hitboxSettingsOpenButton,
	fullbrightButton = fullbrightButton,
	godModeButton = godModeButton,
	fpsBoostButton = fpsBoostButton,
	antiAfkButton = antiAfkButton,
	configButton = configButton,
	flyInput = flyInput,
	flyButton = flyButton,
	speedInput = speedInput,
	sliderFrame = sliderFrame,
	sliderButton = sliderButton,
	speedButton = speedButton,
	fovInput = fovInput,
	fovSliderFrame = fovSliderFrame,
	fovSliderButton = fovSliderButton,
	fovButton = fovButton,
	minimizeButton = minimizeButton,
	minimizedCircle = minimizedCircle,
	configFrame = configFrame,
	configTitle = configTitle,
	configBackButton = configBackButton,
	configNameInput = configNameInput,
	saveConfigButton = saveConfigButton,
	loadConfigButton = loadConfigButton,
	configScroll = configScroll,
	deleteConfigButton = deleteConfigButton,
	pcTriggerButton = pcTriggerButton,
	mobileTriggerButton = mobileTriggerButton,
	valCheckButton = valCheckButton,
	valCheckOpenButton = valCheckOpenButton,
	triggerWallCheckButton = triggerWallCheckButton,
	playerSelectFrame = playerSelectFrame,
	playerSelectTitle = playerSelectTitle,
	playerSelectScroll = playerSelectScroll,
	playerSelectClose = playerSelectClose,
	mobileGui = mobileGui,
	mobileWBtn = mobileWBtn,
	mobileABtn = mobileABtn,
	mobileSBtn = mobileSBtn,
	mobileDBtn = mobileDBtn,
	mobileWABtn = mobileWABtn,
	mobileWDBtn = mobileWDBtn,
	mobileSpaceBtn = mobileSpaceBtn,
	mobileSpaceFrame = mobileSpaceFrame,
	espSettingsFrame = espSettingsFrame,
	espSettingsTitle = espSettingsTitle,
	espSettingsCloseBtn = espSettingsCloseBtn,
	espVisColorBtn = espVisColorBtn,
	espVisColorOpenBtn = espVisColorOpenBtn,
	espUnvisColorBtn = espUnvisColorBtn,
	espUnvisColorOpenBtn = espUnvisColorOpenBtn,
	espTracerBtn = espTracerBtn,
	espBoxBtn = espBoxBtn,
	espNameBtn = espNameBtn,
	espHealthBtn = espHealthBtn,
	espDistBtn = espDistBtn,
	espValCheckBtn = espValCheckBtn,
	espValCheckOpenBtn = espValCheckOpenBtn,
	espColorPickerFrame = espColorPickerFrame,
	espColorPickerTitle = espColorPickerTitle,
	espRSlider = espRSlider,
	espRHandle = espRHandle,
	espGSlider = espGSlider,
	espGHandle = espGHandle,
	espBSlider = espBSlider,
	espBHandle = espBHandle,
	espColorPreview = espColorPreview,
	espValCheckFrame = espValCheckFrame,
	espValCheckScroll = espValCheckScroll,
	espValCheckClose = espValCheckClose,
	espSettingsOpenButton = espSettingsOpenButton,
	espValCheckTitle = espValCheckTitle,
	espColorPickerClose = espColorPickerClose,
	espScroll = espScroll,
	charmsSettingsFrame = charmsSettingsFrame,
	charmsSettingsTitle = charmsSettingsTitle,
	charmsScroll = charmsScroll,
	charmsVisBtn = charmsVisBtn,
	charmsVisColorOpenBtn = charmsVisColorOpenBtn,
	charmsUnvisBtn = charmsUnvisBtn,
	charmsUnvisColorOpenBtn = charmsUnvisColorOpenBtn,
	charmsSettingsCloseBtn = charmsSettingsCloseBtn,
	charmsColorPickerFrame = charmsColorPickerFrame,
	charmsColorPickerTitle = charmsColorPickerTitle,
	charmsRSlider = charmsRSlider,
	charmsRHandle = charmsRHandle,
	charmsGSlider = charmsGSlider,
	charmsGHandle = charmsGHandle,
	charmsBSlider = charmsBSlider,
	charmsBHandle = charmsBHandle,
	charmsColorPreview = charmsColorPreview,
	charmsColorPickerClose = charmsColorPickerClose,
	charmsSettingsOpenButton = charmsSettingsOpenButton,
	charmsNpcButton = charmsNpcButton,
	aimScroll = aimScroll,
	aimValCheckFrame = aimValCheckFrame,
	aimValCheckTitle = aimValCheckTitle,
	aimValCheckScroll = aimValCheckScroll,
	aimValCheckClose = aimValCheckClose,
	aimValCheckButton = aimValCheckButton,
	aimValCheckOpenButton = aimValCheckOpenButton,
	charmsEspObjButton = charmsEspObjButton,
	smoothInput = smoothInput,
	smoothSliderFrame = smoothSliderFrame,
	smoothSliderButton = smoothSliderButton,
	teamCheckButton = teamCheckButton,
	silentAimButton = silentAimButton,
	smoothButton = smoothButton,
	espTeamCheckBtn = espTeamCheckBtn,
	triggerTeamCheckButton = triggerTeamCheckButton,
}
