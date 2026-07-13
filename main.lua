-- ============================================================
--   main.lua — виправлена версія
-- ============================================================
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ВИПРАВЛЕНІ URL
local GUI_URL = "https://raw.githubusercontent.com/yahananasaka-crypto/roblox/refs/heads/main/gui.lua"
local FUNCTIONS_URL = "https://raw.githubusercontent.com/yahananasaka-crypto/roblox/refs/heads/main/functions.lua"
local BUTTONS_URL = "https://raw.githubusercontent.com/yahananasaka-crypto/roblox/refs/heads/main/buttons.lua"

-- Локальні шляхи (перевір різних варіантів)
local LOCAL_PATHS = {
    "gui.lua", "/gui.lua", "gui.lua.txt", "/gui.lua.txt",
    "functions.lua", "/functions.lua", "functions.lua.txt", "/functions.lua.txt",
    "buttons.lua", "/buttons.lua", "buttons.lua.txt", "/buttons.txt"
}

local function loadFromGitHub(url)
    local success, result = pcall(function()
        return HttpService:GetAsync(url)
    end)
    if not success then
        warn("[Smile] GitHub failed: " .. tostring(result))
        return nil
    end
    return result
end

local function loadLocal(filename)
    local pathsToTry = {
        filename,
        "workspace/" .. filename,
        filename .. ".lua",
        "workspace/" .. filename .. ".lua"
    }
    
    for _, path in ipairs(pathsToTry) do
        if isfile(path) then
            local success, result = pcall(function()
                return readfile(path)
            end)
            if success and result then
                return result
            end
        end
    end
    return nil
end

local function loadModule(name, url, filename)
    local code = loadFromGitHub(url)
    local source = "GitHub"
    
    if not code then
        code = loadLocal(filename)
        source = "local file"
    end
    
    if not code then
        error("[Smile] " .. name .. " not found from GitHub or local.\n\nLocal files must be in executor workspace folder:\n• gui.lua\n• functions.lua\n• buttons.lua\n\nOr check GitHub repo access.", 0)
    end
    
    local fn, err = loadstring(code)
    if not fn then
        error("[Smile] Syntax error in " .. name .. " (" .. source .. "): " .. tostring(err), 0)
    end
    
    local module = fn()
    
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Smile Mod Menu",
            Text = name .. " loaded from " .. source,
            Duration = 2
        })
    end)
    
    return module
end

-- ============================================================
--   ІНІЦІАЛІЗАЦІЯ
-- ============================================================
local success, err = pcall(function()
    local G = loadModule("GUI", GUI_URL, "gui.lua")
    local functionsInit = loadModule("Functions", FUNCTIONS_URL, "functions.lua")
    local F = functionsInit(G, {})
    local buttonsInit = loadModule("Buttons", BUTTONS_URL, "buttons.lua")
    buttonsInit(G, F)

    -- Драг головного фрейму
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

    -- Драг мінімізованого круга
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

    -- Мобільні кнопки
    local VIM = game:GetService("VirtualInputManager")
    
    local function mobileKey(btn, keyCode)
        if not btn then return end
        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                VIM:SendKeyEvent(true, keyCode, false, game)
            end
        end)
        btn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                VIM:SendKeyEvent(false, keyCode, false, game)
            end
        end)
    end
    
    mobileKey(G.mobileWBtn, Enum.KeyCode.W)
    mobileKey(G.mobileABtn, Enum.KeyCode.A)
    mobileKey(G.mobileSBtn, Enum.KeyCode.S)
    mobileKey(G.mobileDBtn, Enum.KeyCode.D)
    
    if G.mobileSpaceFrame then
        G.mobileSpaceFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            end
        end)
        G.mobileSpaceFrame.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
            end
        end)
    end

    -- Slider логіка
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
            if inputField then inputField.Text = math.floor(value) end
            if callback then callback(value) end
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

    setupSlider(G.sliderFrame, G.sliderButton, G.speedInput, 1, 500, function() end)
    setupSlider(G.fovSliderFrame, G.fovSliderButton, G.fovInput, 1, 120, function() end)
    
    -- ТУТ БУЛА ПОМИЛКА: було GaimFOVInput, стало G.aimFOVInput
    setupSlider(G.aimFOVSliderFrame, G.aimFOVSliderButton, G.aimFOVInput, 1, 360, function() end)
    
    setupSlider(G.smoothSliderFrame, G.smoothSliderButton, G.smoothInput, 0.01, 1, function() end)

    -- ПОВІДОМЛЕННЯ (як ти просив)
    task.wait(0.5)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "🛡️ Security";
        Text = "Anti-detect enabled!";
        Duration = 2;
    })
    task.wait(1)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "😊 Smile Mod Menu";
        Text = "Successfully loaded!";
        Duration = 2;
    })
    task.wait(1)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "💬 Discord Server";
        Text = "discord.gg/2M8g79zkk";
        Duration = 5;
    })

    print("[Smile Mod Menu] Successfully initialized")
end)

if not success then
    warn("[Smile] Error: " .. tostring(err))
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Smile Mod Menu",
            Text = "Error: " .. tostring(err),
            Duration = 10
        })
    end)
end
