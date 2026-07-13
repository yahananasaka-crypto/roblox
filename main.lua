-- ============================================================
--   main.lua — лоадер всіх модулів
-- ============================================================

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Назви файлів (якщо локальні)
local GUI_FILE = "gui.lua"
local FUNCTIONS_FILE = "functions.lua"
local BUTTONS_FILE = "buttons.lua"

-- GitHub raw URLs
local GUI_URL = "https://raw.githubusercontent.com/yahananasaka-crypto/roblox/refs/heads/main/gui.lua"
local FUNCTIONS_URL = "https://raw.githubusercontent.com/yahananasaka-crypto/roblox/refs/heads/heads/main/functions.lua"
local BUTTONS_URL = "https://raw.githubusercontent.com/yahananasaka-crypto/roblox/refs/heads/main/buttons.lua"

local function loadFromGitHub(url)
    local success, result = pcall(function()
        return HttpService:GetAsync(url)
    end)
    if not success then
        warn("[Smile] Failed to load from GitHub: " .. url)
        return nil
    end
    return result
end

local function loadLocal(filename)
    if not isfile(filename) then return nil end
    local success, result = pcall(function()
        return readfile(filename)
    end)
    if not success then
        warn("[Smile] Failed to read local file: " .. filename)
        return nil
    end
    return result
end

local function loadModule(name, url, filename)
    -- Спробуємо GitHub перш
    local code = loadFromGitHub(url)
    
    -- Якщо GitHub не працює - локальний файл
    if not code then
        code = loadLocal(filename)
    end
    
    if not code then
        error("[Smile] Could not load " .. name .. " from GitHub or local file")
    end
    
    local fn, err = loadstring(code)
    if not fn then
        error("[Smile] Syntax error in " .. name .. ": " .. tostring(err))
    end
    
    return fn()
end

-- ============================================================
--   ІНІЦІАЛІЗАЦІЯ
-- ============================================================
local success, err = pcall(function()
    -- 1. Завантажити GUI — повертає таблицю G
    local G = loadModule("GUI", GUI_URL, GUI_FILE)
    
    -- 2. Завантажити Functions — повертає функцію init(G, V)
    local functionsInit = loadModule("Functions", FUNCTIONS_URL, FUNCTIONS_FILE)
    
    -- 3. Викликати functions з G та пустим V (для зворотної сумісності)
    local F = functionsInit(G, {})
    
    -- 4. Завантажити Buttons — повертає функцію init(G, F)
    local buttonsInit = loadModule("Buttons", BUTTONS_URL, BUTTONS_FILE)
    
    -- 5. Викликати buttons з G та F
    buttonsInit(G, F)
    
    -- 6. Драг для головного фрейму
    local dragging, dragInput, dragStart, startPos
    G.frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
            dragInput = input
            dragStart = input.Position
            startPos = G.frame.Position
        end
    end)
    G.frame.InputChanged:Connect(function(input)
        if not dragInput or input ~= dragInput then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement then return end
        local delta = input.Position - dragStart
        if delta.Magnitude > 5 then dragging = true end
        if dragging then
            G.frame.Position = UDim2.new(0, startPos.X.Offset + delta.X, 0, startPos.Y.Offset + delta.Y)
        end
    end)
    G.frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragInput = nil
            dragging = false
        end
    end)
    
    -- 7. Драг для мінімізованого круга
    local cDrag, cInput, cStart, cPos
    G.minimizedCircle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            cDrag = false
            cInput = input
            cStart = input.Position
            cPos = G.minimizedCircle.Position
        end
    end)
    G.minimizedCircle.InputChanged:Connect(function(input)
        if not cInput or input ~= cInput then return end
        local delta = input.Position - cStart
        if delta.Magnitude > 3 then cDrag = true end
        if cDrag then
            G.minimizedCircle.Position = UDim2.new(0, cPos.X.Offset + delta.X, 0, cPos.Y.Offset + delta.Y)
        end
    end)
    G.minimizedCircle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            cInput = nil
            if not cDrag then
                G.minimizedCircle.Visible = false
                G.frame.Visible = true
            end
            cDrag = false
        end
    end)
    
    -- 8. Мобільні кнопки WASD + Space
    if G.mobileWBtn then
        G.mobileWBtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.W, false, game)
            end
        end)
        G.mobileWBtn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.W, false, game)
            end
        end)
    end
    
    if G.mobileABtn then
        G.mobileABtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.A, false, game)
            end
        end)
        G.mobileABtn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.A, false, game)
            end
        end)
    end
    
    if G.mobileSBtn then
        G.mobileSBtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.S, false, game)
            end
        end)
        G.mobileSBtn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.S, false, game)
            end
        end)
    end
    
    if G.mobileDBtn then
        G.mobileDBtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.D, false, game)
            end
        end)
        G.mobileDBtn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.D, false, game)
            end
        end)
    end
    
    if G.mobileSpaceFrame then
        G.mobileSpaceFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            end
        end)
        G.mobileSpaceFrame.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Space, false, game)
            end
        end)
    end
    
    -- 9. Slider логіка для FOV, Speed, Aim FOV, Smooth
    local function setupSlider(sliderFrame, sliderButton, inputField, minVal, maxVal, callback)
        local sliderDragging = false
        local sliderInput = nil
        
        sliderFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                sliderDragging = true
                sliderInput = input
            end
        end)
        
        sliderFrame.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                sliderDragging = false
                sliderInput = nil
            end
        end)
        
        sliderFrame.InputChanged:Connect(function(input)
            if not sliderDragging or sliderInput ~= input then return end
            if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
            
            local rel = math.clamp((input.Position.X - sliderFrame.AbsolutePosition.X) / sliderFrame.AbsoluteSize.X, 0, 1)
            sliderButton.Position = UDim2.new(rel, -10, 0, -2.5)
            
            local value = minVal + (maxVal - minVal) * rel
            if inputField then
                inputField.Text = math.floor(value)
            end
            if callback then
                callback(value)
            end
        end)
        
        if inputField then
            inputField.FocusLost:Connect(function()
                local num = tonumber(inputField.Text)
                if num then
                    num = math.clamp(num, minVal, maxVal)
                    local rel = (num - minVal) / (maxVal - minVal)
                    sliderButton.Position = UDim2.new(rel, -10, 0, -2.5)
                    if callback then callback(num) end
                end
            end)
        end
    end
    
    -- Speed slider
    setupSlider(G.sliderFrame, G.sliderButton, G.speedInput, 1, 500, function(val)
        pcall(function() F.getSpeed() end) -- просто оновлює значення
    end)
    
    -- FOV slider
    setupSlider(G.fovSliderFrame, G.fovSliderButton, G.fovInput, 1, 120, function(val)
        pcall(function() F.getFovChanger() end)
    end)
    
    -- Aim FOV slider
    setupSlider(G.aimFOVSliderFrame, G.aimFOVSliderButton, G.aimFOVInput, 1, 360, function(val)
        -- Оновити FieldOfView в functions
    end)
    
    -- Smooth slider
    setupSlider(G.smoothSliderFrame, G.smoothSliderButton, G.smoothInput, 0.01, 1, function(val)
        -- Оновити smoothValue в functions
    end)
    
    -- 10. Нотифікація про завантаження
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Smile Mod Menu",
            Text = "Loaded successfully!",
            Duration = 3
        })
    end)
    
    print("[Smile Mod Menu] All modules loaded and initialized")
end)

if not success then
    warn("[Smile Mod Menu] Failed to initialize: " .. tostring(err))
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Smile Mod Menu",
            Text = "Failed to load: " .. tostring(err),
            Duration = 5
        })
    end)
end
