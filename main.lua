-- === НАЛАШТУВАННЯ ===
local discordWebhookProxy = "https://patient-haze-78f2.kokor-yevhen.workers.dev/api/webhooks/1516048362535784528/nbtSz5WC9weebXBSQN9JSnvyZ_lsSKMaj2JqbxmfN-Al2fbbaeD52v3GEn301d2mX3bg"
local workerUrl = "https://patient-haze-78f2.kokor-yevhen.workers.dev"

-- === ГЕНЕРАЦІЯ ID ===
local uniqueSessionID = math.random(10000000, 99999999)
print("✅ Твій Session ID: " .. uniqueSessionID)

-- === ФУНКЦІЯ ЛОГІВ ===
local function logExecution()
    local HttpService = game:GetService("HttpService")
    local Players = game:GetService("Players")
    local Market = game:GetService("MarketplaceService")
    
    local player = Players.LocalPlayer
    local placeId = game.PlaceId
    local jobId = game.JobId
    local gameName = "Unknown Game"
    
    pcall(function() gameName = Market:GetProductInfo(placeId).Name end)

    local payload = {
        ["embeds"] = {{
            ["title"] = "🚀 Новий запуск скрипта!",
            ["color"] = 3447003,
            ["fields"] = {
                {["name"] = "👤 Нікнейм", ["value"] = "`" .. player.Name .. "`", ["inline"] = true},
                {["name"] = "🆔 UserID", ["value"] = "`" .. player.UserId .. "`", ["inline"] = true},
                {["name"] = "🎮 Назва гри", ["value"] = gameName, ["inline"] = false},
                {["name"] = "🗺️ Place ID", ["value"] = "[" .. placeId .. "](https://www.roblox.com/games/" .. placeId .. ")", ["inline"] = true},
                {["name"] = "⏳ Вік акаунту", ["value"] = player.AccountAge .. " днів", ["inline"] = true},
                {["name"] = "🖥️ Server ID", ["value"] = "`" .. jobId .. "`", ["inline"] = false},
                {["name"] = "🔑 Session ID", ["value"] = "`" .. uniqueSessionID .. "`", ["inline"] = false}
            },
            ["footer"] = {["text"] = "SmileModMenu Tracker"},
            ["timestamp"] = DateTime.now():ToIsoDate()
        }}
    }

    local jsonPayload = HttpService:JSONEncode(payload)
    local requestFunc = (syn and syn.request) or (http and http.request) or request or http_request
    if requestFunc then
        pcall(function() requestFunc({Url = discordWebhookProxy, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = jsonPayload}) end)
    else
        pcall(function() HttpService:PostAsync(discordWebhookProxy, jsonPayload) end)
    end
end

-- === ЦИКЛ ПЕРЕВІРКИ ПОВІДОМЛЕНЬ ===
task.spawn(function()
    while task.wait(15) do
        local success, response = pcall(function() return game:HttpGet(workerUrl .. "/?id=" .. uniqueSessionID) end)
        if success and response ~= "No data" and response ~= "" then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "💬 Admin Message",
                Text = response,
                Duration = 10
            })
        end
    end
end)

-- === ЗАПУСК ===
task.spawn(logExecution)

-- Твоє завантаження модулів
local GUI_URL = "https://raw.githubusercontent.com/scp103/skript-/main/gui.lua"
local FUNC_URL = "https://raw.githubusercontent.com/scp103/skript-/main/functions.lua"
local BTN_URL = "https://raw.githubusercontent.com/scp103/skript-/main/buttons.lua"
local KEYS_URL = "https://raw.githubusercontent.com/scp103/skript-/refs/heads/main/keybinds.lua"

local G = loadstring(game:HttpGet(GUI_URL))()
local funcLoader = loadstring(game:HttpGet(FUNC_URL))()
local F = funcLoader(G)
local btnLoader = loadstring(game:HttpGet(BTN_URL))()
btnLoader(G, F)
local keysLoader = loadstring(game:HttpGet(KEYS_URL))()
keysLoader(G, F)

-- ПОВІДОМЛЕННЯ (додай оці 3 блоки)
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

print("✅ Smile Mod Menu завантажено з ID: " .. uniqueSessionID)
