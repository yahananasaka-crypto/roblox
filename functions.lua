
-- Functions частина
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function init(G, V)

local HttpService = game:GetService("HttpService")
local CONFIG_FOLDER = "SmileConfigs"

-- ДОДАЙ ЦЕЙ РЯДОК СЮДИ  (перед усіма функціями!)
local savedConfigs = {}
local selectedConfig = nil

-- Створюємо папку якщо немає
if not isfolder(CONFIG_FOLDER) then
	makefolder(CONFIG_FOLDER)
end

local function saveConfigToFile(name, config)
	local ok, data = pcall(function()
		return HttpService:JSONEncode(config)
	end)
	if ok then
		writefile(CONFIG_FOLDER.."/"..name..".json", data)
	end
end

local function loadConfigFromFile(name)
	local path = CONFIG_FOLDER.."/"..name..".json"
	if isfile(path) then
		local ok, data = pcall(function()
			return HttpService:JSONDecode(readfile(path))
		end)
		if ok then return data end
	end
	return nil
end

local function loadAllConfigs()
	if isfolder(CONFIG_FOLDER) then
		for _, file in pairs(listfiles(CONFIG_FOLDER)) do
			local name = file:match("([^/\\]+)%.json$")
			if name then
				local config = loadConfigFromFile(name)
				if config then
					savedConfigs[name] = config
				end
			end
		end
	end
end

-- ========== UPGRADED ANTI-DETECT ==========
local function genrandstr(length)
    length = length or math.random(14, 28)
    local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local result = ""
    for i = 1, length do
        local idx = math.random(1, #charset)
        result = result .. charset:sub(idx, idx)
    end
    return result
end

local fakeNames = {
    "Frame", "ScrollingFrame", "TextLabel", "TextButton",
    "UIListLayout", "UIGridLayout", "UICorner", "UIStroke",
    "UIPadding", "UIScale", "UIAspectRatioConstraint",
    "CanvasGroup", "Frame", "Frame"
}

local function getFakeName()
    return fakeNames[math.random(1, #fakeNames)]
end

local function deepRename(parent, useFakeNames)
    for _, child in ipairs(parent:GetDescendants()) do
        if child:IsA("GuiObject") or child:IsA("UIBase") or child:IsA("Instance") then
            if useFakeNames and math.random() > 0.5 then
                child.Name = getFakeName()
            else
                child.Name = genrandstr()
            end
        end
    end
end

local metamethodProtected = false
local function protectMetamethods()
    if metamethodProtected then return end
    if not getrawmetatable or not setreadonly then return end
    metamethodProtected = true

    local ok, mt = pcall(getrawmetatable, game)
    if not ok or not mt then return end

    -- Cache references BEFORE hooking
    local coreGuiRef = game:GetService("CoreGui")
    local huiRef = gethui and gethui() or nil
    local screenGuiRef = G.screenGui

    pcall(setreadonly, mt, false)

    local originalNamecall = mt.__namecall
    if not originalNamecall then return end

    local function hook(self, ...)
        local method = getnamecallmethod and getnamecallmethod() or ""
        if method == "GetChildren" or method == "GetDescendants" then
            local results = originalNamecall(self, ...)
            if (self == coreGuiRef) or (huiRef and self == huiRef) then
                local filtered = {}
                for _, item in pairs(results) do
                    if item ~= screenGuiRef then
                        local isDesc = false
                        pcall(function()
                            if screenGuiRef then isDesc = item:IsDescendantOf(screenGuiRef) end
                        end)
                        if not isDesc then
                            table.insert(filtered, item)
                        end
                    end
                end
                return filtered
            end
            return results
        end
        return originalNamecall(self, ...)
    end

    if newcclosure then
        mt.__namecall = newcclosure(hook)
    else
        mt.__namecall = hook
    end

    pcall(setreadonly, mt, true)
end

local function startSecurity()
    protectMetamethods()

    if G.screenGui then G.screenGui.Name = genrandstr() end

    local topLevelFrames = {
        G.frame, G.teleportFrame, G.aimSettingsFrame,
        G.hitboxSettingsFrame, G.configFrame, G.minimizedCircle,
        G.espSettingsFrame, G.espColorPickerFrame, G.charmsSettingsFrame,
        G.charmsColorPickerFrame, G.playerSelectFrame, G.aimValCheckFrame,
        G.espValCheckFrame, G.mobileGui, G.mobileSpaceFrame
    }

    for _, frame in ipairs(topLevelFrames) do
        if frame then
            frame.Name = getFakeName()
            pcall(deepRename, frame, true)
        end
    end

    task.spawn(function()
        while task.wait(math.random(3, 7)) do
            if G.screenGui and G.screenGui.Parent then
                if math.random() > 0.7 then
                    G.screenGui.Name = genrandstr()
                end

                for _, frame in ipairs(topLevelFrames) do
                    if frame and frame.Parent and math.random() > 0.85 then
                        frame.Name = getFakeName()
                    end
                end
            end
        end
    end)

    task.spawn(function()
        while task.wait(math.random(5, 12)) do
            if G.screenGui and math.random() > 0.7 then
                pcall(deepRename, G.screenGui, true)
            end
        end
    end)
end

task.spawn(startSecurity)

local VIM = game:GetService("VirtualInputManager")
local TS = game:GetService("TweenService")

-- ============ ЗМІННІ ============
local AimPart = "Head"
local FieldOfView = 60
local Holding = false
local WallCheckEnabled = false
local fovCircleEnabled = false
local espEnabled = false
local espObjects = {}
local bunnyHopEnabled = false
local speedHackEnabled = false
local currentSpeed = 16
local flyEnabled = false
local flySpeed = 50
local fovChangerEnabled = false
local currentFOV = 70
local skyIndex = 1
local charmsEnabled = false
local charmsNpcEnabled = false
local charmsEspObjEnabled = false
local charmsEspObjStorage = {}
local charmsEspObjTargets = {}
local infiniteJumpEnabled = false
local chaosEnabled = false
local originalLightingSettings = {}
local chaosConnection = nil
local chaosSound = nil
local originalCameraMode = nil
local chaosSpinAngle = 0
local hitboxEnabled = false
local hitboxSize = 20
local hitboxPart = "Head"
local pcTriggerEnabled = false
local mobileTriggerEnabled = false
local valCheckEnabled = false
local valCheckTargets = {}
local aimValCheckEnabled = false
local aimValCheckTargets = {}
local espVisColor = Color3.fromRGB(0, 255, 0)
local espUnvisColor = Color3.fromRGB(255, 0, 0)
local espShowTracer = true
local espShowBox = true
local espShowName = true
local espShowHealth = true
local espShowDist = true
local espValCheckEnabled = false
local espValCheckTargets = {}
local espColorPickerTarget = nil -- "vis" або "unvis"
-- Charms кольори (окремо для кожної кнопки)
local charmsVisColor = Color3.fromRGB(0, 255, 0)   -- дефолт зелений
local charmsUnvisColor = Color3.fromRGB(255, 0, 0) -- дефолт червоний
local espRVal, espGVal, espBVal = 255, 0, 0
local mobileTriggerLoop = nil
local pcTriggerLoop = nil
local triggerWallCheckEnabled = false
local fullbrightEnabled = false
local godModeEnabled = false
local godModeConnection = nil
local thirdPersonEnabled = false
local thirdPersonConnection = nil
local wallHopEnabled = false
local fpsBoostEnabled = false
local originalTextureQuality = nil
local antiAfkEnabled = false
local antiAfkConnection = nil
local originalHitboxSizes = {}
local flyConnection, speedHackConnection, fovChangerConnection, noclipConnection
local bunnyHopConnection, infiniteJumpConnection
local bodyVelocity, bodyAngularVelocity
local lastClickTime = 0
local clickDelay = 0.5
local savedObjects = {}
local wallHopConnection = nil
local canWallJump = true

local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

local circle = Drawing.new("Circle")
circle.Color = Color3.fromRGB(0, 255, 0)
circle.Thickness = 1
circle.Radius = FieldOfView
circle.Filled = false
circle.Visible = true

-- ============ УТІЛІТИ ============
local function canClick()
	local currentTime = tick()
	if currentTime - lastClickTime < clickDelay then return false end
	lastClickTime = currentTime
	return true
end

local function showNotif(title, text, duration)
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = title;
		Text = text;
		Duration = duration or 2;
	})
end

-- ============ АНІМАЦІЯ ============
RunService.RenderStepped:Connect(function(dt)
	local hue = (tick() * 0.5) % 1
	G.titleLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
end)

task.spawn(function()
	while true do
		if G.minimizedCircle.Visible then
			local t = tick()
			G.minimizedCircle.BackgroundColor3 = Color3.new(
				0.5 + 0.5 * math.sin(t),
				0.5 + 0.5 * math.sin(t + 2),
				0.5 + 0.5 * math.sin(t + 4)
			)
		end
		task.wait(0.05)
	end
end)

-- ============ ТЕЛЕПОРТ ============
local function teleportToPlayer(targetPlayer)
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
	   targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
	end
end

local function updateTeleportList()
	for _, child in pairs(G.teleportScroll:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	local yPos = 5
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local btn = Instance.new("TextButton", G.teleportScroll)
			btn.Size = UDim2.new(0.9, 0, 0, 30)
			btn.Position = UDim2.new(0.05, 0, 0, yPos)
			btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			btn.TextColor3 = Color3.new(1,1,1)
			btn.Font = Enum.Font.SourceSans
			btn.TextSize = 14
			btn.Text = player.Name
			local c = Instance.new("UICorner", btn)
			btn.MouseButton1Click:Connect(function()
				if canClick() then teleportToPlayer(player) end
			end)
			yPos = yPos + 35
		end
	end
	G.teleportScroll.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- ============ SKY ============
local function changeSky()
	local sky = Lighting:FindFirstChildOfClass("Sky")
	if skyIndex == 1 then
		if not sky then sky = Instance.new("Sky", Lighting) end
		sky.SkyboxBk = "rbxassetid://159454299"
		sky.SkyboxDn = "rbxassetid://159454296"
		sky.SkyboxFt = "rbxassetid://159454293"
		sky.SkyboxLf = "rbxassetid://159454286"
		sky.SkyboxRt = "rbxassetid://159454300"
		sky.SkyboxUp = "rbxassetid://159454288"
		G.skyButton.Text = "Sky: Space"
		skyIndex = 2
	else
		if sky then sky:Destroy() end
		G.skyButton.Text = "Sky: Default"
		skyIndex = 1
	end
end

-- ============ CHAOS ============
local function saveLightingSettings()
	originalLightingSettings = {
		Ambient = Lighting.Ambient,
		Brightness = Lighting.Brightness,
		ColorShift_Bottom = Lighting.ColorShift_Bottom,
		ColorShift_Top = Lighting.ColorShift_Top,
		OutdoorAmbient = Lighting.OutdoorAmbient,
		FogColor = Lighting.FogColor,
		FogEnd = Lighting.FogEnd,
		FogStart = Lighting.FogStart
	}
end

local function restoreLightingSettings()
	if originalLightingSettings.Ambient then
		Lighting.Ambient = originalLightingSettings.Ambient
		Lighting.Brightness = originalLightingSettings.Brightness
		Lighting.ColorShift_Bottom = originalLightingSettings.ColorShift_Bottom
		Lighting.ColorShift_Top = originalLightingSettings.ColorShift_Top
		Lighting.OutdoorAmbient = originalLightingSettings.OutdoorAmbient
		Lighting.FogColor = originalLightingSettings.FogColor
		Lighting.FogEnd = originalLightingSettings.FogEnd
		Lighting.FogStart = originalLightingSettings.FogStart
	end
end

local function startChaos()
	saveLightingSettings()
	originalCameraMode = LocalPlayer.CameraMode
	LocalPlayer.CameraMode = Enum.CameraMode.Classic
	chaosSound = Instance.new("Sound", workspace)
	chaosSound.SoundId = "rbxassetid://1839246711"
	chaosSound.Volume = 0.5
	chaosSound.Looped = true
	chaosSound:Play()
	chaosConnection = RunService.Heartbeat:Connect(function(dt)
		local t = tick() * 2
		Lighting.Ambient = Color3.new(math.abs(math.sin(t)), math.abs(math.sin(t+2)), math.abs(math.sin(t+4)))
		chaosSpinAngle = chaosSpinAngle + (dt * 420)
		if chaosSpinAngle >= 360 then chaosSpinAngle = 0 end
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local root = LocalPlayer.Character.HumanoidRootPart
			root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, math.rad(chaosSpinAngle), 0)
		end
	end)
end

local function stopChaos()
	if chaosConnection then chaosConnection:Disconnect(); chaosConnection = nil end
	if chaosSound then chaosSound:Stop(); chaosSound:Destroy(); chaosSound = nil end
	if originalCameraMode then LocalPlayer.CameraMode = originalCameraMode end
	restoreLightingSettings()
end

-- ============ THIRD PERSON ============
local function startThirdPerson()
	LocalPlayer.CameraMode = Enum.CameraMode.Classic
	LocalPlayer.CameraMaxZoomDistance = 128
	LocalPlayer.CameraMinZoomDistance = 0.5
	thirdPersonConnection = RunService.RenderStepped:Connect(function()
		LocalPlayer.CameraMode = Enum.CameraMode.Classic
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local distance = (Camera.CFrame.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
			if distance < 3 then
				local root = LocalPlayer.Character.HumanoidRootPart
				local camLook = Camera.CFrame.LookVector
				local newPos = root.Position - (camLook * 5) + Vector3.new(0, 2, 0)
				Camera.CFrame = CFrame.new(newPos, root.Position + Vector3.new(0, 2, 0))
			end
		end
	end)
end

local function stopThirdPerson()
	if thirdPersonConnection then thirdPersonConnection:Disconnect(); thirdPersonConnection = nil end
	LocalPlayer.CameraMode = Enum.CameraMode.Classic
	LocalPlayer.CameraMaxZoomDistance = 128
	LocalPlayer.CameraMinZoomDistance = 0.5
end

-- ============ WALL HOP ============
local function startWallHop()
	wallHopConnection = RunService.RenderStepped:Connect(function()
		local char = LocalPlayer.Character
		if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChildOfClass("Humanoid") then return end
		local hum = char:FindFirstChildOfClass("Humanoid")
		local root = char.HumanoidRootPart
		local ray = Ray.new(root.Position, root.CFrame.LookVector * 3)
		local hit = workspace:FindPartOnRay(ray, char)
		if hit and canWallJump then
			hum:ChangeState(Enum.HumanoidStateType.Jumping)
			canWallJump = false
			task.delay(0.4, function() canWallJump = true end)
		end
	end)
end

local function stopWallHop()
	if wallHopConnection then wallHopConnection:Disconnect(); wallHopConnection = nil end
	canWallJump = true
end

-- ============ VAL CHECK / TRIGGER ============
local function updatePlayerSelectList()
    for _, child in pairs(G.playerSelectScroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    local yPos = 5
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local isSelected = valCheckTargets[player.Name] == true
            local btn = Instance.new("TextButton", G.playerSelectScroll)
            btn.Size = UDim2.new(0.9, 0, 0, 30)
            btn.Position = UDim2.new(0.05, 0, 0, yPos)
            btn.BackgroundColor3 = isSelected and Color3.fromRGB(0,180,0) or Color3.fromRGB(50,50,50)
            btn.TextColor3 = Color3.new(1,1,1)
            btn.Font = Enum.Font.SourceSans
            btn.TextSize = 14
            btn.Text = (isSelected and "✅ " or "⬜ ") .. player.Name
            Instance.new("UICorner", btn)
            btn.MouseButton1Click:Connect(function()
                valCheckTargets[player.Name] = not valCheckTargets[player.Name]
                btn.BackgroundColor3 = valCheckTargets[player.Name] and Color3.fromRGB(0,180,0) or Color3.fromRGB(50,50,50)
                btn.Text = (valCheckTargets[player.Name] and "✅ " or "⬜ ") .. player.Name
            end)
            yPos = yPos + 35
        end
    end
    G.playerSelectScroll.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

local function isValidTarget(player)
    if not player.Character then return false end
    if triggerWallCheckEnabled then
        local head = player.Character:FindFirstChild("Head")
        if not head then return false end
        local rayParams = RaycastParams.new()
        rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
        rayParams.FilterType = Enum.RaycastFilterType.Exclude
        local dir = (head.Position - Camera.CFrame.Position)
        local result = workspace:Raycast(Camera.CFrame.Position, dir, rayParams)
        if result and not result.Instance:IsDescendantOf(player.Character) then
            return false
        end
    end
    if valCheckEnabled then
        return valCheckTargets[player.Name] == true
    end
    return true
end

-- PC Trigger логіка
local pcTriggerLoop = nil
local function startPCTrigger()
    if pcTriggerLoop then return end
    pcTriggerLoop = RunService.Heartbeat:Connect(function()
        if not pcTriggerEnabled then return end
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and isValidTarget(player) then
                local part = player.Character:FindFirstChild(AimPart)
                if part then
                    local vector, onScreen = Camera:WorldToViewportPoint(part.Position)
                    if onScreen then
                        local dist = (Vector2.new(vector.X, vector.Y) - screenCenter).Magnitude
                        if dist < FieldOfView then
                            -- симулюємо клік мишею для ПК
                            mouse1click()
                            task.wait(0.05)
                        end
                    end
                end
            end
        end
    end)
end

local function stopPCTrigger()
    if pcTriggerLoop then pcTriggerLoop:Disconnect(); pcTriggerLoop = nil end
end

-- Mobile Trigger логіка
local function startMobileTrigger()
    if mobileTriggerLoop then return end
    mobileTriggerLoop = RunService.Heartbeat:Connect(function()
        if not mobileTriggerEnabled then return end
        local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and isValidTarget(player) then
                local head = player.Character:FindFirstChild("Head")
                local hum = player.Character:FindFirstChild("Humanoid")
                if head and hum and hum.Health > 0 then
                    local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                        if dist < FieldOfView then
                            pcall(function()
                                VIM:SendMouseButtonEvent(0,0,0,true,game,0)
                                task.wait(0.05)
                                VIM:SendMouseButtonEvent(0,0,0,false,game,0)
                            end)
                            task.wait(0.05)
                        end
                    end
                end
            end
        end
    end)
end

local function stopMobileTrigger()
    if mobileTriggerLoop then mobileTriggerLoop:Disconnect(); mobileTriggerLoop = nil end
end

-- ============ FPS BOOST ============
local function enableFPSBoost()
	originalTextureQuality = settings():GetService("RenderSettings").QualityLevel
	settings():GetService("RenderSettings").QualityLevel = Enum.QualityLevel.Level01
	savedObjects = {}
	for _, obj in pairs(workspace:GetDescendants()) do
		local isChar = obj.Parent and obj.Parent:FindFirstChildOfClass("Humanoid")
		if not isChar then
			if obj:IsA("Decal") or obj:IsA("Texture") then
				table.insert(savedObjects, {obj=obj, type="Transparency", value=obj.Transparency})
				obj.Transparency = 1
			end
			if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
				table.insert(savedObjects, {obj=obj, type="Enabled", value=obj.Enabled})
				obj.Enabled = false
			end
			if obj:IsA("MeshPart") then
				table.insert(savedObjects, {obj=obj, type="TextureID", value=obj.TextureID})
				obj.TextureID = ""
			end
			if obj:IsA("SpecialMesh") then
				table.insert(savedObjects, {obj=obj, type="TextureId", value=obj.TextureId})
				obj.TextureId = ""
			end
		end
	end
	Lighting.GlobalShadows = false
	Lighting.FogEnd = 9e9
	for _, effect in pairs(Lighting:GetChildren()) do
		if effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("BloomEffect") or effect:IsA("DepthOfFieldEffect") then
			table.insert(savedObjects, {obj=effect, type="Enabled", value=effect.Enabled})
			effect.Enabled = false
		end
	end
end

local function disableFPSBoost()
	if originalTextureQuality then
		settings():GetService("RenderSettings").QualityLevel = originalTextureQuality
	end
	Lighting.GlobalShadows = true
	Lighting.FogEnd = 100000
	for _, data in pairs(savedObjects) do
		if data.obj then
			if data.type == "Transparency" then data.obj.Transparency = data.value
			elseif data.type == "Enabled" then data.obj.Enabled = data.value
			elseif data.type == "TextureID" then data.obj.TextureID = data.value
			elseif data.type == "TextureId" then data.obj.TextureId = data.value end
		end
	end
	savedObjects = {}
end

-- ============ ANTI AFK ============
local function startAntiAFK()
    antiAfkConnection = RunService.Heartbeat:Connect(function()
        if math.random() > 0.998 then
            pcall(function()
                local VirtualUser = game:GetService("VirtualUser")
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    end)
end

local function stopAntiAFK()
	if antiAfkConnection then antiAfkConnection:Disconnect(); antiAfkConnection = nil end
end

-- ============ FULLBRIGHT ============
local function enableFullbright()
	Lighting.Brightness = 2
	Lighting.ClockTime = 14
	Lighting.GlobalShadows = false
	Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end

local function disableFullbright()
	Lighting.Brightness = 1
	Lighting.ClockTime = 12
	Lighting.GlobalShadows = true
	Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70)
end

-- ============ GOD MODE ============
local function startGodMode()
	local char = LocalPlayer.Character
	if not char then return end
	for _, v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") then v.CanTouch = false end
	end
	godModeConnection = char.DescendantAdded:Connect(function(d)
		if godModeEnabled and d:IsA("BasePart") then d.CanTouch = false end
	end)
end

local function stopGodMode()
	if godModeConnection then godModeConnection:Disconnect(); godModeConnection = nil end
	local char = LocalPlayer.Character
	if char then
		for _, v in pairs(char:GetDescendants()) do
			if v:IsA("BasePart") then v.CanTouch = true end
		end
	end
end

-- ============ HITBOX ============
local function updateHitboxPartButtons()
	G.hitboxHeadButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	G.hitboxTorsoButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	G.hitboxArmsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	G.hitboxLegsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	if hitboxPart == "Head" then G.hitboxHeadButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	elseif hitboxPart == "Torso" then G.hitboxTorsoButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	elseif hitboxPart == "Arms" then G.hitboxArmsButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	elseif hitboxPart == "Legs" then G.hitboxLegsButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) end
end

local function updateHitboxes()
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			local function setPartSize(part, key)
				if not part then return end
				if not originalHitboxSizes[player.Name.."_"..key] then
					originalHitboxSizes[player.Name.."_"..key] = part.Size
				end
				if hitboxEnabled then
					part.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
					part.Transparency = 0.5
					part.CanCollide = false
					part.Massless = true
				else
					local orig = originalHitboxSizes[player.Name.."_"..key]
					if orig then
						part.Size = orig
						part.Transparency = 0
						part.CanCollide = false
						part.Massless = false
					end
				end
			end

			if hitboxPart == "Head" then
				setPartSize(player.Character:FindFirstChild("Head"), "Head")
			elseif hitboxPart == "Torso" then
				setPartSize(
					player.Character:FindFirstChild("Torso") or player.Character:FindFirstChild("UpperTorso"),
					"Torso"
				)
			elseif hitboxPart == "Arms" then
				setPartSize(player.Character:FindFirstChild("Left Arm") or player.Character:FindFirstChild("LeftUpperArm"), "LeftArm")
				setPartSize(player.Character:FindFirstChild("Right Arm") or player.Character:FindFirstChild("RightUpperArm"), "RightArm")
			elseif hitboxPart == "Legs" then
				setPartSize(player.Character:FindFirstChild("Left Leg") or player.Character:FindFirstChild("LeftUpperLeg"), "LeftLeg")
				setPartSize(player.Character:FindFirstChild("Right Leg") or player.Character:FindFirstChild("RightUpperLeg"), "RightLeg")
			end
		end
	end
end

local hitboxTimer = 0
RunService.Heartbeat:Connect(function(dt)
	if hitboxEnabled then
		hitboxTimer = hitboxTimer + dt
		if hitboxTimer >= 0.5 then
			hitboxTimer = 0
			pcall(updateHitboxes)
		end
	end
end)

-- ============ AIM ============
local function IsVisible(part)
	if not WallCheckEnabled then return true end
	local rayParams = RaycastParams.new()
	rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
	rayParams.FilterType = Enum.RaycastFilterType.Blacklist
	local direction = (part.Position - Camera.CFrame.Position).Unit * 500
	local result = workspace:Raycast(Camera.CFrame.Position, direction, rayParams)
	return not (result and result.Instance and not result.Instance:IsDescendantOf(part.Parent))
end

local function GetClosestPlayer()
    local closestPlayer, shortestDistance = nil, FieldOfView
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(AimPart) then
            if aimValCheckEnabled and not aimValCheckTargets[v.Name] then
                -- пропускаємо якщо не в списку
            else
                local part = v.Character[AimPart]
                local vector, onScreen = Camera:WorldToViewportPoint(part.Position)
                if onScreen and IsVisible(part) then
                    local dist = (Vector2.new(vector.X, vector.Y) - screenCenter).Magnitude
                    if dist < shortestDistance then closestPlayer, shortestDistance = v, dist end
                end
            end
        end
    end
    return closestPlayer
end

RunService.RenderStepped:Connect(function()
	if Holding then
		local target = GetClosestPlayer()
		if target and target.Character and target.Character:FindFirstChild(AimPart) then
			local camPos = Camera.CFrame.Position
			local headPos = target.Character[AimPart].Position
			Camera.CFrame = CFrame.new(camPos, camPos + (headPos - camPos).Unit)
		end
	end
	local target = GetClosestPlayer()
	if WallCheckEnabled and target and target.Character and target.Character:FindFirstChild(AimPart) then
		circle.Color = IsVisible(target.Character[AimPart]) and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
	else
		circle.Color = Color3.fromRGB(0,255,0)
	end
	circle.Position = screenCenter
	circle.Visible = fovCircleEnabled
end)

-- ============ ESP ============
local charmsObjects = {}

local function clearESP()
	for _, esp in pairs(espObjects) do
		for _, obj in pairs(esp) do if obj and obj.Remove then obj:Remove() end end
	end
	espObjects = {}
end

local function removePlayerESP(player)
	if espObjects[player] then
		for _, obj in pairs(espObjects[player]) do if obj and obj.Remove then obj:Remove() end end
		espObjects[player] = nil
	end
end

local function createESP(p)
	if p == LocalPlayer then return end
	local box = Drawing.new("Square")
	box.Thickness = 2; box.Color = Color3.fromRGB(0,255,0); box.Filled = false; box.Transparency = 1; box.Visible = false
	local name = Drawing.new("Text")
	name.Size = 14; name.Center = true; name.Outline = true; name.Color = Color3.fromRGB(0,255,255); name.Visible = false
	local health = Drawing.new("Text")
	health.Size = 13; health.Center = true; health.Outline = true; health.Color = Color3.fromRGB(0,255,0); health.Visible = false
	local distance = Drawing.new("Text")
	distance.Size = 13; distance.Center = true; distance.Outline = true; distance.Color = Color3.fromRGB(255,255,0); distance.Visible = false
	local tracer = Drawing.new("Line")
	tracer.Thickness = 1; tracer.Color = Color3.fromRGB(255,255,255); tracer.Transparency = 0.8; tracer.Visible = false
	espObjects[p] = {Box=box, Name=name, Health=health, Distance=distance, Tracer=tracer}
end

local function clearCharms()
	for _, charm in pairs(charmsObjects) do if charm and charm.Destroy then charm:Destroy() end end
	charmsObjects = {}
end

local function createCharms(p)
	if p == LocalPlayer then return end
	if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
		local h = Instance.new("Highlight")
		h.Parent = p.Character
		h.FillColor = charmsVisColor
		h.FillTransparency = 0.5
		h.OutlineColor = charmsVisColor
		h.OutlineTransparency = 0
		charmsObjects[p] = h
	end
end

local function createNpcCharms()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChildOfClass("Humanoid") and not Players:GetPlayerFromCharacter(obj) then
            if not charmsObjects[obj] then
                local h = Instance.new("Highlight")
                h.Parent = obj
                h.FillColor = charmsVisColor
                h.FillTransparency = 0.5
                h.OutlineColor = charmsVisColor
                h.OutlineTransparency = 0
                charmsObjects[obj] = h
            end
        end
    end
end

local function scanEspObjects()
    table.clear(charmsEspObjTargets) -- Очищаємо старий список перед новим скануванням
    
    -- Шукаємо всі об'єкти у Workspace
    for _, descendant in pairs(workspace:GetDescendants()) do
        -- Перевіряємо, чи є в об'єкта ProximityPrompt або ClickDetector
        if descendant:IsA("ProximityPrompt") or descendant:IsA("ClickDetector") then
            
            -- Нам потрібен сам фізичний об'єкт (Part, MeshPart і т.д.), до якого прив'язана взаємодія
            local parentObj = descendant.Parent
            
            if parentObj and parentObj:IsA("BasePart") then
                -- Перевіряємо, щоб не додати один і той самий об'єкт двічі
                if not table.find(charmsEspObjTargets, parentObj) then
                    
                    -- Якщо це ProximityPrompt і у нього є гарний кастомний текст (наприклад, "Обшукати")
                    -- Можна міняти ім'я об'єкта, щоб у ESP відображалося: "Смітник (Обшукати)"
                    if descendant:IsA("ProximityPrompt") and descendant.ObjectText ~= "" then
                        parentObj.Name = descendant.ObjectText
                    end
                    
                    table.insert(charmsEspObjTargets, parentObj)
                end
            end
        end
    end
end

-- ============ ОНОВЛЕНІ ФУНКЦІЇ ДЛЯ ESP NPC ============
local charmsEspNpcStorage = {}
local charmsEspNpcTargets = {}

local function createNpcESP(npc)
    if charmsEspNpcStorage[npc] then return end
    
    local root = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Head")
    if not root then return end
    
    -- Створюємо підсвітку (Обводку)
    local h = Instance.new("Highlight")
    h.FillTransparency = 1
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Adornee = npc
    h.Parent = game:GetService("CoreGui")
    
    -- Створюємо GUI для відображення Назви та Відстані
    local bgui = Instance.new("BillboardGui")
    bgui.Size = UDim2.new(0, 200, 0, 50)
    bgui.AlwaysOnTop = true
    bgui.Adornee = root
    bgui.ExtentsOffset = Vector3.new(0, 2, 0)
    bgui.Parent = game:GetService("CoreGui")
    
    local textLabel = Instance.new("TextLabel", bgui)
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = 14
    textLabel.TextStrokeTransparency = 0
    textLabel.Text = npc.Name
    
    charmsEspNpcStorage[npc] = {Highlight = h, Billboard = bgui, Label = textLabel}
end

local function clearNpcESP()
    for npc, data in pairs(charmsEspNpcStorage) do
        if data.Highlight then data.Highlight:Destroy() end
        if data.Billboard then data.Billboard:Destroy() end
    end
    charmsEspNpcStorage = {}
end

-- ============ ОНОВЛЕНІ ФУНКЦІЇ ДЛЯ ESP ОБ'ЄКТІВ ============

local function createObjESP(obj)
    if charmsEspObjStorage[obj] then return end
    
    -- Створюємо підсвітку (Обводку) чітко для самого об'єкта
    local h = Instance.new("Highlight")
    h.FillTransparency = 1        -- Повністю прозоре всередині
    h.OutlineTransparency = 0     -- Чітка обводка
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Adornee = obj               -- Робимо обводку конкретно для цього Part
    h.Parent = game:GetService("CoreGui")
    
    -- Створюємо GUI для відображення Назви та Відстані
    local bgui = Instance.new("BillboardGui")
    bgui.Size = UDim2.new(0, 200, 0, 50)
    bgui.AlwaysOnTop = true
    bgui.Adornee = obj
    bgui.ExtentsOffset = Vector3.new(0, 2, 0)
    bgui.Parent = game:GetService("CoreGui")
    
    local textLabel = Instance.new("TextLabel", bgui)
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = 14
    textLabel.TextStrokeTransparency = 0
    textLabel.Text = obj.Name
    
    charmsEspObjStorage[obj] = {Highlight = h, Billboard = bgui, Label = textLabel}
end

local function clearObjESP()
    for obj, data in pairs(charmsEspObjStorage) do
        if data.Highlight then data.Highlight:Destroy() end
        if data.Billboard then data.Billboard:Destroy() end
    end
    charmsEspObjStorage = {}
end

for _, p in pairs(Players:GetPlayers()) do createESP(p) end
Players.PlayerAdded:Connect(createESP)
Players.PlayerAdded:Connect(function(p)
    if charmsEnabled then
        p.CharacterAdded:Connect(function()
            task.wait(0.5)
            if charmsObjects[p] then charmsObjects[p]:Destroy(); charmsObjects[p] = nil end
            createCharms(p)
        end)
        createCharms(p)
    end
end)
Players.PlayerRemoving:Connect(removePlayerESP)
Players.PlayerRemoving:Connect(function(p)
	if charmsObjects[p] then charmsObjects[p]:Destroy(); charmsObjects[p] = nil end
end)

RunService.RenderStepped:Connect(function()
    if charmsEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local char = p.Character
                local h = charmsObjects[p]
                if char and char:FindFirstChild("HumanoidRootPart") then
                    if not h or not h.Parent or h.Parent ~= char then
                        if h then h:Destroy() end
                        local newH = Instance.new("Highlight")
                        newH.Parent = char
                        newH.FillTransparency = 0.5
                        newH.OutlineTransparency = 0
                        charmsObjects[p] = newH
                        h = newH
                    end
                    local rayParams = RaycastParams.new()
                    rayParams.FilterDescendantsInstances = {LocalPlayer.Character, char}
                    rayParams.FilterType = Enum.RaycastFilterType.Exclude
                    local root = char.HumanoidRootPart
                    local result = workspace:Raycast(Camera.CFrame.Position, root.Position - Camera.CFrame.Position, rayParams)
                    local col = (not result or not result.Instance) and charmsVisColor or charmsUnvisColor
                    h.FillColor = col
                    h.OutlineColor = col
                end
            end
        end
        
        -- === ЛОГІКА ДЛЯ NPC (НАША НОВА) ===
        if charmsNpcEnabled then
            if tick() % 2 < 0.03 then
                table.clear(charmsEspNpcTargets)
                for _, descendant in pairs(workspace:GetDescendants()) do
                    if descendant:IsA("Humanoid") and descendant.Parent ~= LocalPlayer.Character and not Players:GetPlayerFromCharacter(descendant.Parent) then
                        local npcModel = descendant.Parent
                        if npcModel and npcModel:IsA("Model") and not table.find(charmsEspNpcTargets, npcModel) then
                            table.insert(charmsEspNpcTargets, npcModel)
                        end
                    end
                end
            end
            
            for _, npc in pairs(charmsEspNpcTargets) do
                if npc and npc.Parent and (npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Head")) then
                    createNpcESP(npc)
                    local data = charmsEspNpcStorage[npc]
                    local targetPart = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Head")
                    if data and targetPart then
                        local char = LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            local origin = char.HumanoidRootPart.Position
                            local dir = targetPart.Position - origin
                            local distance = math.floor(dir.Magnitude)
                            
                            data.Label.Text = npc.Name .. " [" .. tostring(distance) .. "m]"
                            
                            local params = RaycastParams.new()
                            params.FilterDescendantsInstances = {char, npc, npc.Parent}
                            params.FilterType = Enum.RaycastFilterType.Exclude
                            
                            local result = workspace:Raycast(origin, dir, params)
                            local isVisible = (not result)
                            local targetColor = isVisible and charmsVisColor or charmsUnvisColor
                            
                            data.Highlight.OutlineColor = targetColor
                            data.Label.TextColor3 = targetColor
                        end
                    end
                else
                    if charmsEspNpcStorage[npc] then
                        if charmsEspNpcStorage[npc].Highlight then charmsEspNpcStorage[npc].Highlight:Destroy() end
                        if charmsEspNpcStorage[npc].Billboard then charmsEspNpcStorage[npc].Billboard:Destroy() end
                        charmsEspNpcStorage[npc] = nil
                    end
                end
            end
        else
            clearNpcESP()
        end
    else
        clearCharms()
        clearNpcESP()
    end

-- === ОРИГІНАЛЬНА ЛОГІКА ОБ'ЄКТІВ (ЗАЛЕЖИТЬ ВІД CHARMS) ===
    if charmsEnabled and charmsEspObjEnabled then
        if tick() % 2 < 0.03 then scanEspObjects() end
        for _, obj in pairs(charmsEspObjTargets) do
            if obj and obj.Parent then
                createObjESP(obj)
                local data = charmsEspObjStorage[obj]
                if data then
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        local origin = char.HumanoidRootPart.Position
                        local dir = obj.Position - origin
                        local distance = math.floor(dir.Magnitude)
                        
                        data.Label.Text = obj.Name .. " [" .. tostring(distance) .. "m]"
                        
                        local params = RaycastParams.new()
                        params.FilterDescendantsInstances = {char, obj, obj.Parent}
                        params.FilterType = Enum.RaycastFilterType.Exclude
                        
                        local result = workspace:Raycast(origin, dir, params)
                        local isVisible = (not result)
                        local targetColor = isVisible and charmsVisColor or charmsUnvisColor
                        
                        data.Highlight.OutlineColor = targetColor
                        data.Label.TextColor3 = targetColor
                    end
                end
            else
                if charmsEspObjStorage[obj] then
                    if charmsEspObjStorage[obj].Highlight then charmsEspObjStorage[obj].Highlight:Destroy() end
                    if charmsEspObjStorage[obj].Billboard then charmsEspObjStorage[obj].Billboard:Destroy() end
                    charmsEspObjStorage[obj] = nil
                end
            end
        end
    else
        clearObjESP()
    end
end)

RunService.RenderStepped:Connect(function()
	if not espEnabled then
		for _, esp in pairs(espObjects) do
			for _, obj in pairs(esp) do if obj then obj.Visible = false end end
		end
		return
	end
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then
			local esp = espObjects[p]
			if not esp then createESP(p); esp = espObjects[p] end
			if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChildOfClass("Humanoid") then
				local root = p.Character.HumanoidRootPart
				local hum = p.Character:FindFirstChildOfClass("Humanoid")
				if hum.Health > 0 then
					local pos, visible = Camera:WorldToViewportPoint(root.Position)
					if visible and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
						local dist = (LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude
						local scale = math.clamp(3000/dist, 100, 300)
						local width, height = scale/2, scale
						local rayParams = RaycastParams.new()
						rayParams.FilterDescendantsInstances = {LocalPlayer.Character, p.Character}
						rayParams.FilterType = Enum.RaycastFilterType.Exclude
						local rayResult = workspace:Raycast(Camera.CFrame.Position, root.Position - Camera.CFrame.Position, rayParams)
						local canSee = not (rayResult and rayResult.Instance)
						local shouldShow = not espValCheckEnabled or espValCheckTargets[p.Name] == true
						if shouldShow then
							local col = canSee and espVisColor or espUnvisColor
							esp.Box.Color = col; esp.Tracer.Color = col
							esp.Box.Size = Vector2.new(width, height)
							esp.Box.Position = Vector2.new(pos.X-width/2, pos.Y-height/1.5)
							esp.Box.Visible = espShowBox
							esp.Name.Position = Vector2.new(pos.X, pos.Y-height/1.5-15)
							esp.Name.Text = p.Name; esp.Name.Visible = espShowName
							esp.Health.Position = Vector2.new(pos.X, pos.Y-height/1.5)
							esp.Health.Text = "HP: "..math.floor(hum.Health); esp.Health.Visible = espShowHealth
							esp.Distance.Position = Vector2.new(pos.X, pos.Y+height/2+5)
							esp.Distance.Text = "Dist: "..math.floor(dist); esp.Distance.Visible = espShowDist
							esp.Tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
							esp.Tracer.To = Vector2.new(pos.X, pos.Y); esp.Tracer.Visible = espShowTracer
						else
							for _, v in pairs(esp) do v.Visible = false end
						end
					else
						for _, v in pairs(esp) do v.Visible = false end
					end
				else
					for _, v in pairs(esp) do v.Visible = false end
				end
			else
				for _, v in pairs(esp) do v.Visible = false end
			end
		end
	end
end)

-- ============ FLY ============
local mobileMove = {w=false, a=false, s=false, d=false, space=false}

local function startFly()
	local char = LocalPlayer.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
		local root = char.HumanoidRootPart
		bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.MaxForce = Vector3.new(4000,4000,4000)
		bodyVelocity.Velocity = Vector3.new(0,0,0)
		bodyVelocity.Parent = root
		bodyAngularVelocity = Instance.new("BodyAngularVelocity")
		bodyAngularVelocity.MaxTorque = Vector3.new(4000,4000,4000)
		bodyAngularVelocity.AngularVelocity = Vector3.new(0,0,0)
		bodyAngularVelocity.Parent = root
flyConnection = RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and bodyVelocity then
        local moveVector = Vector3.new(0,0,0)
        local cam = workspace.CurrentCamera
        
        local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
        
        if isMobile then
            -- На телефоні — завжди летить туди куди дивиться камера
            moveVector = cam.CFrame.LookVector
            -- Space кнопка — летить вгору
            if mobileMove.space then
                moveVector = Vector3.new(0, 1, 0)
            end
        else
              -- На ПК — стандартне управління клавішами
              local isW = UserInputService:IsKeyDown(Enum.KeyCode.W)
              local isS = UserInputService:IsKeyDown(Enum.KeyCode.S)
              local isA = UserInputService:IsKeyDown(Enum.KeyCode.A)
              local isD = UserInputService:IsKeyDown(Enum.KeyCode.D)
              local isSpace = UserInputService:IsKeyDown(Enum.KeyCode.Space)
              if isW then moveVector = moveVector + cam.CFrame.LookVector end
              if isS then moveVector = moveVector - cam.CFrame.LookVector end
              if isA then moveVector = moveVector - cam.CFrame.RightVector end
              if isD then moveVector = moveVector + cam.CFrame.RightVector end
           	  if isSpace then moveVector = moveVector + Vector3.new(0,1,0) end
          	  if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then 
              	  moveVector = moveVector + Vector3.new(0,-1,0) 
         	  end
     	  end
        
  	     	   bodyVelocity.Velocity = moveVector.Magnitude > 0 and moveVector.Unit * flySpeed or Vector3.new(0,0,0)
 		   end
		end)
	end
end

local function stopFly()
	if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
	if bodyVelocity then bodyVelocity:Destroy(); bodyVelocity = nil end
	if bodyAngularVelocity then bodyAngularVelocity:Destroy(); bodyAngularVelocity = nil end
end

-- ============ SPEED/FOV ============
local function updateSpeed()
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = currentSpeed
	end
end

local function updateSlider()
	G.sliderButton.Position = UDim2.new((currentSpeed-16)/(400-16), -10, 0, -2.5)
	G.speedInput.Text = tostring(currentSpeed)
end

local function updateFOV()
	if Camera then Camera.FieldOfView = currentFOV end
end

local function updateFOVSlider()
	G.fovSliderButton.Position = UDim2.new((currentFOV-30)/(120-30), -10, 0, -2.5)
	G.fovInput.Text = tostring(currentFOV)
end

local function updateAimFOVSlider()
	G.aimFOVSliderButton.Position = UDim2.new((FieldOfView-30)/(200-30), -10, 0, -2.5)
	G.aimFOVInput.Text = tostring(FieldOfView)
	circle.Radius = FieldOfView
end

-- ============ SLIDERS ============
local draggingSlider, draggingFOVSlider, draggingAimFOVSlider = false, false, false

local function handleSliderInput()
	local mouse = UserInputService:GetMouseLocation()
	local sp = G.sliderFrame.AbsolutePosition
	local ss = G.sliderFrame.AbsoluteSize
	if mouse.X >= sp.X and mouse.X <= sp.X+ss.X then
		local pct = math.clamp(mouse.X-sp.X, 0, ss.X)/ss.X
		currentSpeed = math.clamp(math.floor(16+(400-16)*pct+0.5), 16, 400)
		updateSlider()
		if speedHackEnabled then updateSpeed() end
	end
end

local function handleFOVSliderInput()
	local mouse = UserInputService:GetMouseLocation()
	local sp = G.fovSliderFrame.AbsolutePosition
	local ss = G.fovSliderFrame.AbsoluteSize
	if mouse.X >= sp.X and mouse.X <= sp.X+ss.X then
		local pct = math.clamp(mouse.X-sp.X, 0, ss.X)/ss.X
		currentFOV = math.clamp(math.floor(30+(120-30)*pct+0.5), 30, 120)
		updateFOVSlider()
		if fovChangerEnabled then updateFOV() end
	end
end

local function handleAimFOVSliderInput()
	local mouse = UserInputService:GetMouseLocation()
	local sp = G.aimFOVSliderFrame.AbsolutePosition
	local ss = G.aimFOVSliderFrame.AbsoluteSize
	if mouse.X >= sp.X and mouse.X <= sp.X+ss.X then
		local pct = math.clamp(mouse.X-sp.X, 0, ss.X)/ss.X
		FieldOfView = math.clamp(math.floor(30+(200-30)*pct+0.5), 30, 200)
		updateAimFOVSlider()
	end
end

G.sliderFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		draggingSlider = true; handleSliderInput()
	end
end)

G.fovSliderFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		draggingFOVSlider = true; handleFOVSliderInput()
	end
end)

G.aimFOVSliderFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		draggingAimFOVSlider = true; handleAimFOVSliderInput()
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		draggingSlider, draggingFOVSlider, draggingAimFOVSlider = false, false, false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then handleSliderInput()
	elseif draggingFOVSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then handleFOVSliderInput()
	elseif draggingAimFOVSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then handleAimFOVSliderInput()
	end
end)

-- ============ TEXT INPUTS ============
G.speedInput.FocusLost:Connect(function()
	local v = tonumber(G.speedInput.Text)
	if v then
		currentSpeed = math.clamp(v, 16, 400)  -- ← клампить автоматично
		updateSlider()
		if speedHackEnabled then updateSpeed() end
		G.speedInput.Text = tostring(currentSpeed)
	else
		G.speedInput.Text = tostring(currentSpeed)
	end
end)

G.flyInput.FocusLost:Connect(function()
	local v = tonumber(G.flyInput.Text)
	if v then
		flySpeed = math.clamp(v, 10, 450)
		G.flyInput.Text = tostring(flySpeed)
	else
		G.flyInput.Text = tostring(flySpeed)
	end
end)

G.fovInput.FocusLost:Connect(function()
	local v = tonumber(G.fovInput.Text)
	if v then
		currentFOV = math.clamp(v, 30, 120)
		updateFOVSlider()
		if fovChangerEnabled then updateFOV() end
		G.fovInput.Text = tostring(currentFOV)
	else
		G.fovInput.Text = tostring(currentFOV)
	end
end)

G.aimFOVInput.FocusLost:Connect(function()
	local v = tonumber(G.aimFOVInput.Text)
	if v and v >= 30 and v <= 200 then FieldOfView = v; updateAimFOVSlider()
	else G.aimFOVInput.Text = tostring(FieldOfView) end
end)

G.hitboxSizeInput.FocusLost:Connect(function()
	local v = tonumber(G.hitboxSizeInput.Text)
	if v and v >= 5 and v <= 50 then hitboxSize = v; if hitboxEnabled then updateHitboxes() end
	else G.hitboxSizeInput.Text = tostring(hitboxSize) end
end)

-- ============ CONFIG СИСТЕМА ============
local function getCurrentConfig()
	return {
		aimEnabled = Holding,
		fovCircle = fovCircleEnabled,
		wallCheck = WallCheckEnabled,
		aimFOV = FieldOfView,
		espEnabled = espEnabled,
		charmsEnabled = charmsEnabled,
		infiniteJump = infiniteJumpEnabled,
		noclip = (noclipConnection ~= nil),
		bunnyHop = bunnyHopEnabled,
		chaos = chaosEnabled,
		thirdPerson = thirdPersonEnabled,
		wallHop = wallHopEnabled,
		hitboxEnabled = hitboxEnabled,
		hitboxPart = hitboxPart,
		hitboxSize = hitboxSize,
		fullbright = fullbrightEnabled,
		godMode = godModeEnabled,
		fpsBoost = fpsBoostEnabled,
		antiAfk = antiAfkEnabled,
		flySpeed = flySpeed,
		speed = currentSpeed,
		fov = currentFOV,
		pcTrigger = pcTriggerEnabled,
		mobileTrigger = mobileTriggerEnabled,
		valCheck = valCheckEnabled,
		valCheckTargets = valCheckTargets,
		triggerWallCheck = triggerWallCheckEnabled,
		skyIndex = skyIndex,
		espShowTracer = espShowTracer,
		espShowBox = espShowBox,
		espShowName = espShowName,
		espShowHealth = espShowHealth,
		espShowDist = espShowDist,
		espValCheckEnabled = espValCheckEnabled,
		espValCheckTargets = espValCheckTargets,
		espVisColor = {r = espVisColor.R, g = espVisColor.G, b = espVisColor.B},
		espUnvisColor = {r = espUnvisColor.R, g = espUnvisColor.G, b = espUnvisColor.B},
		charmsVisColor = {r = charmsVisColor.R, g = charmsVisColor.G, b = charmsVisColor.B},
		charmsUnvisColor = {r = charmsUnvisColor.R, g = charmsUnvisColor.G, b = charmsUnvisColor.B},
	}
end

local function updateConfigList()
	for _, child in pairs(G.configScroll:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	
	local yPos = 5
	local count = 0
	
	for name, _ in pairs(savedConfigs) do
		count = count + 1
		local btn = Instance.new("TextButton", G.configScroll)
		btn.Size = UDim2.new(0.95, 0, 0, 35)
		btn.Position = UDim2.new(0.025, 0, 0, yPos)
		btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		btn.TextColor3 = Color3.new(1,1,1)
		btn.Font = Enum.Font.SourceSans
		btn.TextSize = 14
		btn.Text = name
		local c = Instance.new("UICorner", btn)
		c.CornerRadius = UDim.new(0, 6)
		
		-- Якщо це вибраний - підсвічуємо
		if name == selectedConfig then
			btn.BackgroundColor3 = Color3.fromRGB(0, 130, 255)
		end
		
		btn.MouseButton1Click:Connect(function()
			for _, b in pairs(G.configScroll:GetChildren()) do
				if b:IsA("TextButton") then
					b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
				end
			end
			btn.BackgroundColor3 = Color3.fromRGB(0, 130, 255)
			selectedConfig = name
			G.configNameInput.Text = name
		end)
		
		yPos = yPos + 40
	end
	
	G.configScroll.CanvasSize = UDim2.new(0, 0, 0, yPos + 5)
end

local function applyConfig(config)
	-- AIM
	Holding = config.aimEnabled
	G.aimButton.Text = Holding and "AIM: ON" or "AIM: OFF"
	-- FOV Circle
	fovCircleEnabled = config.fovCircle
	G.fovCircleButton.Text = fovCircleEnabled and "FOV Circle: ON" or "FOV Circle: OFF"
	-- WallCheck
	WallCheckEnabled = config.wallCheck
	G.wallButton.Text = WallCheckEnabled and "WallCheck: ON" or "WallCheck: OFF"
	-- Aim FOV
	FieldOfView = config.aimFOV
	updateAimFOVSlider()
	-- ESP
	espEnabled = config.espEnabled
	G.espButton.Text = espEnabled and "ESP: ON" or "ESP: OFF"
	-- Charms
	charmsEnabled = config.charmsEnabled
	G.charmsButton.Text = charmsEnabled and "Charms: ON" or "Charms: OFF"
	-- Infinite Jump
	infiniteJumpEnabled = config.infiniteJump
	G.infiniteJumpButton.Text = infiniteJumpEnabled and "Infinite Jump: ON" or "Infinite Jump: OFF"
	-- BunnyHop
	bunnyHopEnabled = config.bunnyHop
	G.bunnyHopButton.Text = bunnyHopEnabled and "BunnyHop: ON" or "BunnyHop: OFF"
	-- Hitbox
	hitboxEnabled = config.hitboxEnabled
	hitboxPart = config.hitboxPart
	hitboxSize = config.hitboxSize
	G.hitboxButton.Text = hitboxEnabled and "Hitbox: ON" or "Hitbox: OFF"
	G.hitboxSizeInput.Text = tostring(hitboxSize)
	updateHitboxPartButtons()
	-- Fullbright
	if config.fullbright ~= fullbrightEnabled then
	fullbrightEnabled = config.fullbright
	G.fullbrightButton.Text = fullbrightEnabled and "Fullbright: ON" or "Fullbright: OFF"
	if fullbrightEnabled then enableFullbright() else disableFullbright() end
end

-- PC Trigger
if config.pcTrigger then
	pcTriggerEnabled = true
	G.pcTriggerButton.Text = "PC Trigger: ON"
	G.pcTriggerButton.BackgroundColor3 = Color3.fromRGB(0,180,0)
	startPCTrigger()
end

-- Mobile Trigger
if config.mobileTrigger then
	mobileTriggerEnabled = true
	G.mobileTriggerButton.Text = "Mobile Trigger: ON"
	G.mobileTriggerButton.BackgroundColor3 = Color3.fromRGB(0,180,0)
	startMobileTrigger()
end

-- Val Check
valCheckEnabled = config.valCheck or false
G.valCheckButton.Text = valCheckEnabled and "Val Check: ON" or "Val Check: OFF"
G.valCheckButton.BackgroundColor3 = valCheckEnabled and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)

-- Val Check Targets
if config.valCheckTargets then
	valCheckTargets = config.valCheckTargets
end

if config.aimValCheck ~= nil then
    aimValCheckEnabled = config.aimValCheck
    G.aimValCheckButton.Text = aimValCheckEnabled and "AIM ValCheck: ON" or "AIM ValCheck: OFF"
    G.aimValCheckButton.BackgroundColor3 = aimValCheckEnabled and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
end
if config.aimValCheckTargets then
    aimValCheckTargets = config.aimValCheckTargets
end

-- ESP toggles
if config.espShowTracer ~= nil then
    espShowTracer = config.espShowTracer
    G.espTracerBtn.Text = espShowTracer and "Tracer: ON" or "Tracer: OFF"
    G.espTracerBtn.BackgroundColor3 = espShowTracer and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
end
		
if config.espShowBox ~= nil then
    espShowBox = config.espShowBox
    G.espBoxBtn.Text = espShowBox and "Box: ON" or "Box: OFF"
    G.espBoxBtn.BackgroundColor3 = espShowBox and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
end
		
if config.espShowName ~= nil then
    espShowName = config.espShowName
    G.espNameBtn.Text = espShowName and "Name: ON" or "Name: OFF"
    G.espNameBtn.BackgroundColor3 = espShowName and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
end
		
if config.espShowHealth ~= nil then
    espShowHealth = config.espShowHealth
    G.espHealthBtn.Text = espShowHealth and "Health: ON" or "Health: OFF"
    G.espHealthBtn.BackgroundColor3 = espShowHealth and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
end
		
if config.espShowDist ~= nil then
    espShowDist = config.espShowDist
    G.espDistBtn.Text = espShowDist and "Distance: ON" or "Distance: OFF"
    G.espDistBtn.BackgroundColor3 = espShowDist and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
end
		
if config.espValCheckEnabled ~= nil then
    espValCheckEnabled = config.espValCheckEnabled
    G.espValCheckBtn.Text = espValCheckEnabled and "ESP ValCheck: ON" or "ESP ValCheck: OFF"
    G.espValCheckBtn.BackgroundColor3 = espValCheckEnabled and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
end
		
if config.espValCheckTargets then
    espValCheckTargets = config.espValCheckTargets
end
		
if config.espVisColor then
    espVisColor = Color3.fromRGB(
        math.floor(config.espVisColor.r * 255),
        math.floor(config.espVisColor.g * 255),
        math.floor(config.espVisColor.b * 255)
    )
    G.espVisColorBtn.BackgroundColor3 = espVisColor
end
		
if config.espUnvisColor then
    espUnvisColor = Color3.fromRGB(
        math.floor(config.espUnvisColor.r * 255),
        math.floor(config.espUnvisColor.g * 255),
        math.floor(config.espUnvisColor.b * 255)
    )
    G.espUnvisColorBtn.BackgroundColor3 = espUnvisColor
end

-- Charms кольори
if config.charmsVisColor then
    charmsVisColor = Color3.fromRGB(
        math.floor(config.charmsVisColor.r * 255),
        math.floor(config.charmsVisColor.g * 255),
        math.floor(config.charmsVisColor.b * 255)
    )
    G.charmsVisBtn.BackgroundColor3 = charmsVisColor
end

if config.charmsUnvisColor then
    charmsUnvisColor = Color3.fromRGB(
        math.floor(config.charmsUnvisColor.r * 255),
        math.floor(config.charmsUnvisColor.g * 255),
        math.floor(config.charmsUnvisColor.b * 255)
    )
    G.charmsUnvisBtn.BackgroundColor3 = charmsUnvisColor
end

-- Trigger WallCheck
triggerWallCheckEnabled = config.triggerWallCheck or false
G.triggerWallCheckButton.Text = triggerWallCheckEnabled and "Trigger WallCheck: ON" or "Trigger WallCheck: OFF"
G.triggerWallCheckButton.BackgroundColor3 = triggerWallCheckEnabled and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)

-- Sky
if config.skyIndex then
	skyIndex = config.skyIndex
	if skyIndex == 2 then
		skyIndex = 1
		changeSky()
	end
end

currentSpeed = config.speed
updateSlider()
if speedHackEnabled then updateSpeed() end

currentFOV = config.fov
updateFOVSlider()
if fovChangerEnabled then updateFOV() end

flySpeed = config.flySpeed
G.flyInput.Text = tostring(flySpeed)

-- Speed
	currentSpeed = config.speed
	updateSlider()
	if config.speed ~= 16 then
		speedHackEnabled = true
		G.speedButton.Text = "Speed: ON"
		if speedHackConnection then speedHackConnection:Disconnect() end
		speedHackConnection = RunService.RenderStepped:Connect(updateSpeed)
	else
		speedHackEnabled = false
		G.speedButton.Text = "Speed: OFF"
		if speedHackConnection then speedHackConnection:Disconnect(); speedHackConnection = nil end
	end

	-- FOV
	currentFOV = config.fov
	updateFOVSlider()
	if config.fov ~= 70 then
		fovChangerEnabled = true
		G.fovButton.Text = "FOV: ON"
		if fovChangerConnection then fovChangerConnection:Disconnect() end
		fovChangerConnection = RunService.RenderStepped:Connect(updateFOV)
	else
		fovChangerEnabled = false
		G.fovButton.Text = "FOV: OFF"
		if fovChangerConnection then fovChangerConnection:Disconnect(); fovChangerConnection = nil end
	end

	-- Fly
	flySpeed = config.flySpeed
	G.flyInput.Text = tostring(flySpeed)

	showNotif("✅ Config", "Loaded: "..selectedConfig, 2)
end

-- Config кнопки
G.configButton.MouseButton1Click:Connect(function()
	if canClick() then
		G.frame.Visible = false
		G.aimSettingsFrame.Visible = false
		G.hitboxSettingsFrame.Visible = false
		G.configFrame.Visible = true
		updateConfigList()
	end
end)

G.configBackButton.MouseButton1Click:Connect(function()
	if canClick() then
		G.configFrame.Visible = false
		G.frame.Visible = true
	end
end)

G.saveConfigButton.MouseButton1Click:Connect(function()
	if canClick() then
		local name = G.configNameInput.Text
		if name ~= "" then
			local config = getCurrentConfig()
			savedConfigs[name] = config
			saveConfigToFile(name, config)
			selectedConfig = name
			updateConfigList() -- оновлює список зразу
			showNotif("💾 Config", "Saved: "..name, 2)
		end
	end
end)

G.loadConfigButton.MouseButton1Click:Connect(function()
	if canClick() then
		local name = G.configNameInput.Text ~= "" and G.configNameInput.Text or selectedConfig
		if name and savedConfigs[name] then
			selectedConfig = name
			applyConfig(savedConfigs[name])
		end
	end
end)

G.deleteConfigButton.MouseButton1Click:Connect(function()
	if canClick() then
		if selectedConfig and savedConfigs[selectedConfig] then
			local path = CONFIG_FOLDER.."/"..selectedConfig..".json"
			if isfile(path) then
				delfile(path)
			end
			savedConfigs[selectedConfig] = nil
			selectedConfig = nil
			G.configNameInput.Text = ""
			updateConfigList()
			showNotif("🗑️ Config", "Deleted!", 2)
		end
	end
end)

-- ============ DRAG ============
local function makeDraggable(frame, dragHandle)
	local dragging, dragStart, startPos = false, nil, nil
	local handle = dragHandle or frame
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			if not draggingSlider and not draggingFOVSlider and not draggingAimFOVSlider then
				dragging = true; dragStart = input.Position; startPos = frame.Position
			end
		end
	end)
	handle.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X, startPos.Y.Scale, startPos.Y.Offset+delta.Y)
		end
	end)
	handle.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
end

makeDraggable(G.frame, G.titleLabel)
makeDraggable(G.teleportFrame, G.teleportTitle)
makeDraggable(G.minimizedCircle)
makeDraggable(G.configFrame, G.configTitle)
makeDraggable(G.mobileGui)
makeDraggable(G.aimSettingsFrame, G.aimSettingsTitle)
makeDraggable(G.hitboxSettingsFrame, G.hitboxSettingsTitle)
makeDraggable(G.espSettingsFrame, G.espSettingsTitle)
makeDraggable(G.espColorPickerFrame, G.espColorPickerTitle)
makeDraggable(G.espValCheckFrame, G.espValCheckTitle)
makeDraggable(G.charmsSettingsFrame, G.charmsSettingsTitle)
makeDraggable(G.charmsColorPickerFrame, G.charmsColorPickerTitle)
makeDraggable(G.playerSelectFrame, G.playerSelectTitle)
makeDraggable(G.aimValCheckFrame, G.aimValCheckTitle)

local keyMap = {
    [Enum.KeyCode.W] = "w",
    [Enum.KeyCode.A] = "a",
    [Enum.KeyCode.S] = "s",
    [Enum.KeyCode.D] = "d",
    [Enum.KeyCode.Space] = "space"
}

local function setupMobileKey(btn, key1, key2)
    local activeTouches = {}
    
    local function pressDown()
        btn.BackgroundColor3 = Color3.fromRGB(80,150,255)
        if keyMap[key1] then mobileMove[keyMap[key1]] = true end
        if key2 and keyMap[key2] then mobileMove[keyMap[key2]] = true end
        task.spawn(function()
            pcall(function() VIM:SendKeyEvent(true, key1, false, game) end)
            if key2 then pcall(function() VIM:SendKeyEvent(true, key2, false, game) end) end
        end)
    end
    
    local function pressUp()
        if next(activeTouches) ~= nil then return end -- ще є активні дотики
        btn.BackgroundColor3 = key2 and Color3.fromRGB(60,30,30) or Color3.fromRGB(40,40,60)
        if keyMap[key1] then mobileMove[keyMap[key1]] = false end
        if key2 and keyMap[key2] then mobileMove[keyMap[key2]] = false end
        task.spawn(function()
            pcall(function() VIM:SendKeyEvent(false, key1, false, game) end)
            if key2 then pcall(function() VIM:SendKeyEvent(false, key2, false, game) end) end
        end)
    end
    
    btn.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch then
            activeTouches[i] = true
            pressDown()
        end
    end)
    
    btn.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch then
            activeTouches[i] = nil
            pressUp()
        end
    end)
    
    btn.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch then
            if not activeTouches[i] then
                activeTouches[i] = true
                pressDown()
            end
        end
    end)
end

setupMobileKey(G.mobileWBtn, Enum.KeyCode.W)
setupMobileKey(G.mobileABtn, Enum.KeyCode.A)
setupMobileKey(G.mobileSBtn, Enum.KeyCode.S)
setupMobileKey(G.mobileDBtn, Enum.KeyCode.D)
setupMobileKey(G.mobileSpaceBtn, Enum.KeyCode.Space)
setupMobileKey(G.mobileWABtn, Enum.KeyCode.W, Enum.KeyCode.A)
setupMobileKey(G.mobileWDBtn, Enum.KeyCode.W, Enum.KeyCode.D)

-- ESP ValCheck список
local function updateEspValCheckList()
    for _, child in pairs(G.espValCheckScroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    local yPos = 5
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local isSel = espValCheckTargets[player.Name] == true
            local btn = Instance.new("TextButton", G.espValCheckScroll)
            btn.Size = UDim2.new(0.9, 0, 0, 30)
            btn.Position = UDim2.new(0.05, 0, 0, yPos)
            btn.BackgroundColor3 = isSel and Color3.fromRGB(0,180,0) or Color3.fromRGB(50,50,50)
            btn.TextColor3 = Color3.new(1,1,1)
            btn.Font = Enum.Font.SourceSans
            btn.TextSize = 14
            btn.Text = (isSel and "✅ " or "⬜ ") .. player.Name
            Instance.new("UICorner", btn)
            btn.MouseButton1Click:Connect(function()
                espValCheckTargets[player.Name] = not espValCheckTargets[player.Name]
                btn.BackgroundColor3 = espValCheckTargets[player.Name] and Color3.fromRGB(0,180,0) or Color3.fromRGB(50,50,50)
                btn.Text = (espValCheckTargets[player.Name] and "✅ " or "⬜ ") .. player.Name
            end)
            yPos = yPos + 35
        end
    end
    G.espValCheckScroll.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

local function updateAimValCheckList()
    for _, child in pairs(G.aimValCheckScroll:GetChildren()) do  -- ← змінити на aimValCheckScroll
        if child:IsA("TextButton") then child:Destroy() end
    end
    local yPos = 5
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local isSel = aimValCheckTargets[player.Name] == true
            local btn = Instance.new("TextButton", G.aimValCheckScroll)
            btn.Size = UDim2.new(0.9, 0, 0, 30)
            btn.Position = UDim2.new(0.05, 0, 0, yPos)
            btn.BackgroundColor3 = isSel and Color3.fromRGB(0,180,0) or Color3.fromRGB(50,50,50)
            btn.TextColor3 = Color3.new(1,1,1)
            btn.Font = Enum.Font.SourceSans
            btn.TextSize = 14
            btn.Text = (isSel and "✅ " or "⬜ ") .. player.Name
            Instance.new("UICorner", btn)
            btn.MouseButton1Click:Connect(function()
                aimValCheckTargets[player.Name] = not aimValCheckTargets[player.Name]
                btn.BackgroundColor3 = aimValCheckTargets[player.Name] and Color3.fromRGB(0,180,0) or Color3.fromRGB(50,50,50)
                btn.Text = (aimValCheckTargets[player.Name] and "✅ " or "⬜ ") .. player.Name
            end)
            yPos = yPos + 35
        end
    end
    G.aimValCheckScroll.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- Color picker слайдери
local draggingR, draggingG, draggingB = false, false, false

local function updateColorPreview()
    local c = Color3.fromRGB(espRVal, espGVal, espBVal)
    G.espColorPreview.BackgroundColor3 = c
    if espColorPickerTarget == "vis" then
        espVisColor = c
        G.espVisColorBtn.BackgroundColor3 = c
    elseif espColorPickerTarget == "unvis" then
        espUnvisColor = c
        G.espUnvisColorBtn.BackgroundColor3 = c
    end
end

local function handleRSlider()
    local mouse = UserInputService:GetMouseLocation()
    local sp = G.espRSlider.AbsolutePosition
    local ss = G.espRSlider.AbsoluteSize
    local pct = math.clamp((mouse.X - sp.X) / ss.X, 0, 1)
    espRVal = math.floor(pct * 255)
    G.espRHandle.Position = UDim2.new(pct, -9, 0, -1.5)
    updateColorPreview()
end

local function handleGSlider()
    local mouse = UserInputService:GetMouseLocation()
    local sp = G.espGSlider.AbsolutePosition
    local ss = G.espGSlider.AbsoluteSize
    local pct = math.clamp((mouse.X - sp.X) / ss.X, 0, 1)
    espGVal = math.floor(pct * 255)
    G.espGHandle.Position = UDim2.new(pct, -9, 0, -1.5)
    updateColorPreview()
end

local function handleBSlider()
    local mouse = UserInputService:GetMouseLocation()
    local sp = G.espBSlider.AbsolutePosition
    local ss = G.espBSlider.AbsoluteSize
    local pct = math.clamp((mouse.X - sp.X) / ss.X, 0, 1)
    espBVal = math.floor(pct * 255)
    G.espBHandle.Position = UDim2.new(pct, -9, 0, -1.5)
    updateColorPreview()
end

G.espRSlider.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        draggingR = true; handleRSlider()
    end
end)
G.espGSlider.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        draggingG = true; handleGSlider()
    end
end)
G.espBSlider.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        draggingB = true; handleBSlider()
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        draggingR = false; draggingG = false; draggingB = false
        charmsDraggingR = false; charmsDraggingG = false; charmsDraggingB = false
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
        if draggingR then handleRSlider()
        elseif draggingG then handleGSlider()
        elseif draggingB then handleBSlider()
        elseif charmsDraggingR then charmsHandleRSlider()
        elseif charmsDraggingG then charmsHandleGSlider()
        elseif charmsDraggingB then charmsHandleBSlider()
        end
    end
end)

-- ===== CHARMS COLOR PICKER LOGIC (копія ESP) =====
local charmsDraggingR, charmsDraggingG, charmsDraggingB = false, false, false
local charmsRVal, charmsGVal, charmsBVal = 0, 255, 0
local charmsColorTarget = nil

local function updateCharmsColorPreview()
    local c = Color3.fromRGB(charmsRVal, charmsGVal, charmsBVal)
    G.charmsColorPreview.BackgroundColor3 = c
    if charmsColorTarget == "vis" then
        charmsVisColor = c
        G.charmsVisBtn.BackgroundColor3 = c
    elseif charmsColorTarget == "unvis" then
        charmsUnvisColor = c
        G.charmsUnvisBtn.BackgroundColor3 = c
    end
end

local function charmsHandleRSlider()
    local mouse = UserInputService:GetMouseLocation()
    local sp = G.charmsRSlider.AbsolutePosition
    local ss = G.charmsRSlider.AbsoluteSize
    local pct = math.clamp((mouse.X - sp.X) / ss.X, 0, 1)
    charmsRVal = math.floor(pct * 255)
    G.charmsRHandle.Position = UDim2.new(pct, -9, 0, -1.5)
    updateCharmsColorPreview()
end

local function charmsHandleGSlider()
    local mouse = UserInputService:GetMouseLocation()
    local sp = G.charmsGSlider.AbsolutePosition
    local ss = G.charmsGSlider.AbsoluteSize
    local pct = math.clamp((mouse.X - sp.X) / ss.X, 0, 1)
    charmsGVal = math.floor(pct * 255)
    G.charmsGHandle.Position = UDim2.new(pct, -9, 0, -1.5)
    updateCharmsColorPreview()
end

local function charmsHandleBSlider()
    local mouse = UserInputService:GetMouseLocation()
    local sp = G.charmsBSlider.AbsolutePosition
    local ss = G.charmsBSlider.AbsoluteSize
    local pct = math.clamp((mouse.X - sp.X) / ss.X, 0, 1)
    charmsBVal = math.floor(pct * 255)
    G.charmsBHandle.Position = UDim2.new(pct, -9, 0, -1.5)
    updateCharmsColorPreview()
end

local function openCharmsColorPicker(target)
    charmsColorTarget = target
    if target == "vis" then
        G.charmsColorPickerTitle.Text = "Visible Color"
        charmsRVal = math.floor(charmsVisColor.R * 255)
        charmsGVal = math.floor(charmsVisColor.G * 255)
        charmsBVal = math.floor(charmsVisColor.B * 255)
    else
        G.charmsColorPickerTitle.Text = "Unvisible Color"
        charmsRVal = math.floor(charmsUnvisColor.R * 255)
        charmsGVal = math.floor(charmsUnvisColor.G * 255)
        charmsBVal = math.floor(charmsUnvisColor.B * 255)
    end
    G.charmsRHandle.Position = UDim2.new(charmsRVal/255, -9, 0, -1.5)
    G.charmsGHandle.Position = UDim2.new(charmsGVal/255, -9, 0, -1.5)
    G.charmsBHandle.Position = UDim2.new(charmsBVal/255, -9, 0, -1.5)
    G.charmsColorPreview.BackgroundColor3 = Color3.fromRGB(charmsRVal, charmsGVal, charmsBVal)
    G.charmsColorPickerFrame.Visible = true
end

G.charmsRSlider.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        charmsDraggingR = true; charmsHandleRSlider()
    end
end)
G.charmsRSlider.InputChanged:Connect(function(i)
    if charmsDraggingR and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        charmsHandleRSlider()
    end
end)

G.charmsGSlider.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        charmsDraggingG = true; charmsHandleGSlider()
    end
end)
G.charmsGSlider.InputChanged:Connect(function(i)
    if charmsDraggingG and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        charmsHandleGSlider()
    end
end)

G.charmsBSlider.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        charmsDraggingB = true; charmsHandleBSlider()
    end
end)
G.charmsBSlider.InputChanged:Connect(function(i)
    if charmsDraggingB and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        charmsHandleBSlider()
    end
end)

-- Init sliders
updateSlider()
updateFOVSlider()
updateAimFOVSlider()

-- Завантажуємо конфіги при старті 
loadAllConfigs()
updateConfigList()

-- Повертаємо всі функції для buttons.lua
return {
	canClick = canClick,
	showNotif = showNotif,
	updateTeleportList = updateTeleportList,
	changeSky = changeSky,
	startChaos = startChaos,
	stopChaos = stopChaos,
	startThirdPerson = startThirdPerson,
	stopThirdPerson = stopThirdPerson,
	startWallHop = startWallHop,
	stopWallHop = stopWallHop,
	enableFPSBoost = enableFPSBoost,
	disableFPSBoost = disableFPSBoost,
	startAntiAFK = startAntiAFK,
	stopAntiAFK = stopAntiAFK,
	enableFullbright = enableFullbright,
	disableFullbright = disableFullbright,
	startGodMode = startGodMode,
	stopGodMode = stopGodMode,
	updateHitboxes = updateHitboxes,
	updateHitboxPartButtons = updateHitboxPartButtons,
	startFly = startFly,
	stopFly = stopFly,
	updateSpeed = updateSpeed,
	updateFOV = updateFOV,
	clearESP = clearESP,
	-- Стан
	getHolding = function() return Holding end,
	setHolding = function(v) Holding = v end,
	getFovCircle = function() return fovCircleEnabled end,
	setFovCircle = function(v) fovCircleEnabled = v end,
	getWallCheck = function() return WallCheckEnabled end,
	setWallCheck = function(v) WallCheckEnabled = v end,
	getEsp = function() return espEnabled end,
	setEsp = function(v) espEnabled = v end,
	getCharms = function() return charmsEnabled end,
	setCharms = function(v) charmsEnabled = v end,
	getInfiniteJump = function() return infiniteJumpEnabled end,
	setInfiniteJump = function(v) infiniteJumpEnabled = v end,
	getNoclip = function() return noclipConnection ~= nil end,
	setNoclip = function(v)
		if v then
			noclipConnection = RunService.Stepped:Connect(function()
				if LocalPlayer.Character then
					for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
						if part:IsA("BasePart") then part.CanCollide = false end
					end
				end
			end)
		else
			if noclipConnection then noclipConnection:Disconnect(); noclipConnection = nil end
			if LocalPlayer.Character then
				for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
					if part:IsA("BasePart") then part.CanCollide = true end
				end
			end
		end
	end,
	getBunnyHop = function() return bunnyHopEnabled end,
	setBunnyHop = function(v)
		bunnyHopEnabled = v
		if v then
			bunnyHopConnection = RunService.RenderStepped:Connect(function()
				local char = LocalPlayer.Character
				if char and char:FindFirstChildOfClass("Humanoid") then
					local hum = char:FindFirstChildOfClass("Humanoid")
					hum.WalkSpeed = 100; hum.JumpPower = 35
					if hum.FloorMaterial ~= Enum.Material.Air then hum:ChangeState("Jumping") end
				end
			end)
		else
			if bunnyHopConnection then bunnyHopConnection:Disconnect(); bunnyHopConnection = nil end
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
				LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
				LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = 50
			end
		end
	end,
	getChaos = function() return chaosEnabled end,
	setChaos = function(v) chaosEnabled = v end,
	getThirdPerson = function() return thirdPersonEnabled end,
	setThirdPerson = function(v) thirdPersonEnabled = v end,
	getWallHop = function() return wallHopEnabled end,
	setWallHop = function(v) wallHopEnabled = v end,
	getHitbox = function() return hitboxEnabled end,
	setHitbox = function(v) hitboxEnabled = v end,
	getHitboxPart = function() return hitboxPart end,
	setHitboxPart = function(v) hitboxPart = v end,
	getFullbright = function() return fullbrightEnabled end,
	setFullbright = function(v) fullbrightEnabled = v end,
	getGodMode = function() return godModeEnabled end,
	setGodMode = function(v) godModeEnabled = v end,
	getFpsBoost = function() return fpsBoostEnabled end,
	setFpsBoost = function(v) fpsBoostEnabled = v end,
	getAntiAfk = function() return antiAfkEnabled end,
	setAntiAfk = function(v) antiAfkEnabled = v end,
	getFly = function() return flyEnabled end,
	setFly = function(v) flyEnabled = v end,
	getSpeed = function() return speedHackEnabled end,
	setSpeed = function(v)
		speedHackEnabled = v
		if v then
			speedHackConnection = RunService.RenderStepped:Connect(updateSpeed)
		else
			if speedHackConnection then speedHackConnection:Disconnect(); speedHackConnection = nil end
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
				LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
			end
		end
	end,
	getFovChanger = function() return fovChangerEnabled end,
	setFovChanger = function(v)
		fovChangerEnabled = v
		if v then
			fovChangerConnection = RunService.RenderStepped:Connect(updateFOV)
		else
			if fovChangerConnection then fovChangerConnection:Disconnect(); fovChangerConnection = nil end
			if Camera then Camera.FieldOfView = 70 end
		end
	end,
	getInfiniteJumpConn = function() return infiniteJumpConnection end,
	setInfiniteJumpConn = function(v) infiniteJumpConnection = v end,
	getPCTrigger = function() return pcTriggerEnabled end,
	setPCTrigger = function(v)
		pcTriggerEnabled = v
		if v then startPCTrigger() else stopPCTrigger() end
	end,
	getMobileTrigger = function() return mobileTriggerEnabled end,
	setMobileTrigger = function(v)
		mobileTriggerEnabled = v
		if v then startMobileTrigger() else stopMobileTrigger() end
	end,
	getValCheck = function() return valCheckEnabled end,
	setValCheck = function(v) valCheckEnabled = v end,
	updatePlayerSelectList = updatePlayerSelectList,
	getTriggerWallCheck = function() return triggerWallCheckEnabled end,
	setTriggerWallCheck = function(v) triggerWallCheckEnabled = v end,
	updateEspValCheckList = updateEspValCheckList,
	setEspColorTarget = function(v) espColorPickerTarget = v end,
	getEspShowTracer = function() return espShowTracer end,
	setEspShowTracer = function(v) espShowTracer = v end,
	getEspShowBox = function() return espShowBox end,
	setEspShowBox = function(v) espShowBox = v end,
	getEspShowName = function() return espShowName end,
	setEspShowName = function(v) espShowName = v end,
	getEspShowHealth = function() return espShowHealth end,
	setEspShowHealth = function(v) espShowHealth = v end,
	getEspShowDist = function() return espShowDist end,
	setEspShowDist = function(v) espShowDist = v end,
	getEspValCheck = function() return espValCheckEnabled end,
	setEspValCheck = function(v) espValCheckEnabled = v end,
	getCharmsVisColor = function() return charmsVisColor end,
	getCharmsUnvisColor = function() return charmsUnvisColor end,
	openCharmsColorPicker = openCharmsColorPicker,
	getCharmsNpc = function() return charmsNpcEnabled end,
	setCharmsNpc = function(v) charmsNpcEnabled = v end,
	getAimValCheck = function() return aimValCheckEnabled end,
	setAimValCheck = function(v) aimValCheckEnabled = v end,
	updateAimValCheckList = updateAimValCheckList,
	getCharmsEspObj = function() return charmsEspObjEnabled end,
	setCharmsEspObj = function(v) charmsEspObjEnabled = v end,
}

end

return init
