-- ============================================================
--   functions.lua — повний файл з усіма геттерами/сеттерами
-- ============================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function init(G, V)

-- ======================================================
-- GAME DETECTION
-- ======================================================
local IS_MM2 = (game.PlaceId == 142823291) or (game.Name == "Murder Mystery 2")
local IS_RIVALS = (game.PlaceId == 11247156815) or (game.PlaceId == 17625359962) or (game.PlaceId == 117398147513099) or (game.Name == "Rivals") or (game.Name == "Matchmaking") or (game.Name == "[🏖️] RIVALS")

-- ======================================================
-- MM2 ROLE FUNCTIONS
-- ======================================================
local function getMM2RoleColor(player)
    local char = player.Character
    local backpack = player:FindFirstChild("Backpack")
    if (backpack and backpack:FindFirstChild("Knife")) or (char and char:FindFirstChild("Knife")) then
        return Color3.fromRGB(255, 0, 0)
    elseif (backpack and backpack:FindFirstChild("Gun")) or (char and char:FindFirstChild("Gun")) then
        return Color3.fromRGB(0, 0, 255)
    else
        return Color3.fromRGB(0, 255, 0)
    end
end

local function getMM2LocalRole()
    local char = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if (backpack and backpack:FindFirstChild("Knife")) or (char and char:FindFirstChild("Knife")) then
        return "Murderer"
    elseif (backpack and backpack:FindFirstChild("Gun")) or (char and char:FindFirstChild("Gun")) then
        return "Sheriff"
    else
        return "Innocent"
    end
end

local function isMM2Murderer(player)
    local char = player.Character
    local backpack = player:FindFirstChild("Backpack")
    return (backpack and backpack:FindFirstChild("Knife")) or (char and char:FindFirstChild("Knife")) ~= nil
end

-- ======================================================
-- RIVALS SILENT AIM HOOK
-- ======================================================
local rivalsHooked = false
local rivalsOriginalRaycast = nil

local function setupRivalsHook()
    if not IS_RIVALS or rivalsHooked then return end
    local ok, mod = pcall(function()
        return require(game:GetService("ReplicatedStorage").Modules.Utility)
    end)
    if not ok or not mod or not mod.Raycast then return end
    rivalsOriginalRaycast = mod.Raycast
    rivalsHooked = true
    mod.Raycast = function(...)
        local args = {...}
        if args[4] ~= 999 then return rivalsOriginalRaycast(...) end
        if not silentAimEnabled then return rivalsOriginalRaycast(...) end
        local cx = Camera.ViewportSize.X / 2
        local cy = Camera.ViewportSize.Y / 2
        local winner, record = nil, math.huge
        local pool = {}
        for _, v in workspace:GetChildren() do
            if v:FindFirstChildOfClass("Humanoid") then pool[#pool+1] = v end
            if v.Name == "HurtEffect" then
                for _, c in v:GetChildren() do
                    if c.ClassName ~= "Highlight" then pool[#pool+1] = c end
                end
            end
        end
        for _, v in pool do
            if v == LocalPlayer.Character then continue end
            if not v:FindFirstChild("HumanoidRootPart") then continue end
            if not v:FindFirstChild("Head") then continue end
            local p, vis = Camera:WorldToViewportPoint(v.Head.Position)
            if not vis then continue end
            local d = ((Vector2.new(cx, cy)) - Vector2.new(p.X, p.Y)).Magnitude
            if d < record then winner, record = v, d end
        end
        if winner and winner:FindFirstChild("Head") then
            args[3] = winner.Head.Position
        end
        return rivalsOriginalRaycast(table.unpack(args))
    end
end

-- ======================================================
-- ЗМІННІ
-- ======================================================
local smoothToggle = false
local smoothValue = 0.2
local teamCheckEnabled = false
local silentAimEnabled = false
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
local infiniteJumpConn = nil
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
local espColorPickerTarget = nil
local espTeamCheckEnabled = false
local charmsVisColor = Color3.fromRGB(0, 255, 0)
local charmsUnvisColor = Color3.fromRGB(255, 0, 0)
local mobileTriggerLoop = nil
local pcTriggerLoop = nil
local triggerWallCheckEnabled = false
local triggerTeamCheckEnabled = false
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
local bodyVelocity, bodyAngularVelocity
local lastClickTime = 0
local clickDelay = 0.5
local savedObjects = {}
local wallHopConnection = nil
local canWallJump = true
local mobileMove = {w=false, a=false, s=false, d=false, space=false}

local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

local circle = Drawing.new("Circle")
circle.Color = Color3.fromRGB(0, 255, 0)
circle.Thickness = 1
circle.Radius = FieldOfView
circle.Filled = false
circle.Visible = true

-- ======================================================
-- УТІЛІТИ
-- ======================================================
local function canClick()
    local currentTime = tick()
    if currentTime - lastClickTime < clickDelay then return false end
    lastClickTime = currentTime
    return true
end

local function showNotif(title, text, duration)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title, Text = text, Duration = duration or 2
        })
    end)
end

if IS_MM2 then
    showNotif("Smile Mod Menu", "Game detected: Murder Mystery 2", 5)
elseif IS_RIVALS then
    showNotif("Smile Mod Menu", "Game detected: Rivals", 5)
    task.spawn(function()
        task.wait(2)
        setupRivalsHook()
    end)
end

-- ======================================================
-- АНІМАЦІЯ
-- ======================================================
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

-- ======================================================
-- ТЕЛЕПОРТ
-- ======================================================
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
            Instance.new("UICorner", btn)
            btn.MouseButton1Click:Connect(function()
                if canClick() then teleportToPlayer(player) end
            end)
            yPos = yPos + 35
        end
    end
    G.teleportScroll.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- ======================================================
-- SKY
-- ======================================================
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

-- ======================================================
-- CHAOS
-- ======================================================
local function saveLightingSettings()
    originalLightingSettings = {
        Ambient = Lighting.Ambient, Brightness = Lighting.Brightness,
        ColorShift_Bottom = Lighting.ColorShift_Bottom, ColorShift_Top = Lighting.ColorShift_Top,
        OutdoorAmbient = Lighting.OutdoorAmbient, FogColor = Lighting.FogColor,
        FogEnd = Lighting.FogEnd, FogStart = Lighting.FogStart
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

-- ======================================================
-- THIRD PERSON
-- ======================================================
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

-- ======================================================
-- WALL HOP
-- ======================================================
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

-- ======================================================
-- VAL CHECK / TRIGGER
-- ======================================================
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
    if triggerTeamCheckEnabled and player.Team == LocalPlayer.Team then return false end
    if triggerWallCheckEnabled then
        local head = player.Character:FindFirstChild("Head")
        if not head then return false end
        local rayParams = RaycastParams.new()
        rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
        rayParams.FilterType = Enum.RaycastFilterType.Exclude
        local dir = (head.Position - Camera.CFrame.Position)
        local result = workspace:Raycast(Camera.CFrame.Position, dir, rayParams)
        if result and not result.Instance:IsDescendantOf(player.Character) then return false end
    end
    if valCheckEnabled then return valCheckTargets[player.Name] == true end
    return true
end

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
                            if silentAimEnabled then
                                local camPos = Camera.CFrame.Position
                                Camera.CFrame = CFrame.new(camPos, part.Position)
                            end
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

local function startMobileTrigger()
    if mobileTriggerLoop then return end
    local VIM = game:GetService("VirtualInputManager")
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
                            if silentAimEnabled then
                                local camPos = Camera.CFrame.Position
                                Camera.CFrame = CFrame.new(camPos, head.Position)
                            end
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

-- ======================================================
-- FPS BOOST
-- ======================================================
local function enableFPSBoost()
    pcall(function()
        originalTextureQuality = settings():GetService("RenderSettings").QualityLevel
        settings():GetService("RenderSettings").QualityLevel = Enum.QualityLevel.Level01
    end)
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
    pcall(function()
        if originalTextureQuality then
            settings():GetService("RenderSettings").QualityLevel = originalTextureQuality
        end
    end)
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

-- ======================================================
-- ANTI AFK
-- ======================================================
local function startAntiAFK()
    antiAfkConnection = RunService.Heartbeat:Connect(function()
        pcall(function()
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton2(Vector2.new())
        end)
    end)
end

local function stopAntiAFK()
    if antiAfkConnection then antiAfkConnection:Disconnect(); antiAfkConnection = nil end
end

-- ======================================================
-- FULLBRIGHT
-- ======================================================
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

-- ======================================================
-- HITBOX
-- ======================================================
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
                setPartSize(player.Character:FindFirstChild("Torso") or player.Character:FindFirstChild("UpperTorso"), "Torso")
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

-- ======================================================
-- AIM
-- ======================================================
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
    if IS_MM2 then
        local myRole = getMM2LocalRole()
        if myRole == "Innocent" then return nil end
    end
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(AimPart) then
            local skip = false
            if aimValCheckEnabled and not aimValCheckTargets[v.Name] then skip = true end
            if teamCheckEnabled and v.Team == LocalPlayer.Team then skip = true end
            if not skip and IS_MM2 then
                local myRole = getMM2LocalRole()
                if myRole == "Sheriff" then
                    if not isMM2Murderer(v) then skip = true end
                end
            end
            if not skip then
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
    if IS_RIVALS and not rivalsHooked then setupRivalsHook() end
    if Holding and not silentAimEnabled then
        local target = GetClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild(AimPart) then
            local camPos = Camera.CFrame.Position
            local headPos = target.Character[AimPart].Position
            local targetCFrame = CFrame.new(camPos, camPos + (headPos - camPos).Unit)
            if smoothToggle then
                Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, smoothValue)
            else
                Camera.CFrame = targetCFrame
            end
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

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then Holding = true end
    if input.UserInputType == Enum.UserInputType.MouseButton1 and Holding and silentAimEnabled then
        if IS_RIVALS then return end
        local target = GetClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild(AimPart) then
            local originalCFrame = Camera.CFrame
            local camPos = Camera.CFrame.Position
            local headPos = target.Character[AimPart].Position
            Camera.CFrame = CFrame.new(camPos, camPos + (headPos - camPos).Unit)
            task.defer(function()
                Camera.CFrame = originalCFrame
            end)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then Holding = false end
end)

-- ======================================================
-- ESP
-- ======================================================
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

local function scanEspObjects()
    table.clear(charmsEspObjTargets)
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA("ProximityPrompt") or descendant:IsA("ClickDetector") then
            local parentObj = descendant.Parent
            if parentObj and parentObj:IsA("BasePart") then
                if not table.find(charmsEspObjTargets, parentObj) then
                    if descendant:IsA("ProximityPrompt") and descendant.ObjectText ~= "" then
                        parentObj.Name = descendant.ObjectText
                    end
                    table.insert(charmsEspObjTargets, parentObj)
                end
            end
        end
    end
end

local charmsEspNpcStorage = {}
local charmsEspNpcTargets = {}

local function createNpcESP(npc)
    if charmsEspNpcStorage[npc] then return end
    local root = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Head")
    if not root then return end
    local h = Instance.new("Highlight")
    h.FillTransparency = 1
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Adornee = npc
    h.Parent = game:GetService("CoreGui")
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

local function createObjESP(obj)
    if charmsEspObjStorage[obj] then return end
    local h = Instance.new("Highlight")
    h.FillTransparency = 1
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Adornee = obj
    h.Parent = game:GetService("CoreGui")
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
Players.PlayerAdded:Connect(function(p)
    createESP(p)
    p.CharacterAdded:Connect(function()
        task.wait(0.5)
        if charmsEnabled then
            if charmsObjects[p] then charmsObjects[p]:Destroy(); charmsObjects[p] = nil end
            createCharms(p)
        end
    end)
end)
Players.PlayerRemoving:Connect(function(p)
    removePlayerESP(p)
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
                    local col
                    if IS_MM2 then
                        col = getMM2RoleColor(p)
                    else
                        local rayParams = RaycastParams.new()
                        rayParams.FilterDescendantsInstances = {LocalPlayer.Character, char}
                        rayParams.FilterType = Enum.RaycastFilterType.Exclude
                        local root = char.HumanoidRootPart
                        local result = workspace:Raycast(Camera.CFrame.Position, root.Position - Camera.CFrame.Position, rayParams)
                        col = (not result or not result.Instance) and charmsVisColor or charmsUnvisColor
                    end
                    h.FillColor = col
                    h.OutlineColor = col
                end
            end
        end
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
        else clearNpcESP() end
    else
        clearCharms()
        clearNpcESP()
    end
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
    else clearObjESP() end
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
                        local isEnemy = not espTeamCheckEnabled or (p.Team ~= LocalPlayer.Team)
                        local shouldShow = isEnemy and (not espValCheckEnabled or espValCheckTargets[p.Name] == true)
                        if shouldShow then
                            local col
                            if IS_MM2 then
                                col = getMM2RoleColor(p)
                            else
                                col = canSee and espVisColor or espUnvisColor
                            end
                            esp.Box.Color = col; esp.Tracer.Color = col
                            esp.Box.Size = Vector2.new(width, height)
                            esp.Box.Position = Vector2.new(pos.X-width/2, pos.Y-height/1.5)
                            esp.Box.Visible = espShowBox
                            local nameText = p.Name
                            if IS_MM2 then
                                local role = "Innocent"
                                if col == Color3.fromRGB(255, 0, 0) then role = "Murderer"
                                elseif col == Color3.fromRGB(0, 0, 255) then role = "Sheriff" end
                                nameText = "[" .. role .. "] " .. p.Name
                            end
                            esp.Name.Position = Vector2.new(pos.X, pos.Y-height/1.5-15)
                            esp.Name.Text = nameText; esp.Name.Visible = espShowName
                            esp.Name.Color = col
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

-- ======================================================
-- FLY
-- ======================================================
local function startFly()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        bodyVelocity = Instance.new("BodyVelocity", char.HumanoidRootPart)
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyAngularVelocity = Instance.new("BodyAngularVelocity", char.HumanoidRootPart)
        bodyAngularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
        flyConnection = RunService.RenderStepped:Connect(function()
            if not flyEnabled or not char or not char.Parent then return end
            local cf = Camera.CFrame
            local dir = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) or mobileMove.w then dir = dir + cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) or mobileMove.s then dir = dir - cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) or mobileMove.a then dir = dir - cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) or mobileMove.d then dir = dir + cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) or mobileMove.space then dir = dir + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0, 1, 0) end
            bodyVelocity.Velocity = dir * flySpeed
        end)
    end
end

local function stopFly()
    if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
    if bodyVelocity then bodyVelocity:Destroy(); bodyVelocity = nil end
    if bodyAngularVelocity then bodyAngularVelocity:Destroy(); bodyAngularVelocity = nil end
end

-- ======================================================
-- SPEED
-- ======================================================
local function startSpeedHack()
    pcall(function() flySpeed = tonumber(G.flyInput.Text) or 50 end)
    pcall(function() currentSpeed = tonumber(G.speedInput.Text) or 16 end)
    speedHackConnection = RunService.Heartbeat:Connect(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = currentSpeed
        end
    end)
end

local function stopSpeedHack()
    if speedHackConnection then speedHackConnection:Disconnect(); speedHackConnection = nil end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
    end
end

-- ============================================================
--   СТВОРЕННЯ ТАБЛИЦІ F (ЯКУ ЧЕКАЄ buttons.lua)
-- ============================================================
local F = {}

-- Автоматичні геттери/сеттери для всіх змінних
local vars = {
    Holding = false, FovCircle = false, WallCheck = false, Esp = false,
    Charms = false, CharmsNpc = false, CharmsEspObj = false, InfiniteJump = false,
    Noclip = false, BunnyHop = false, Chaos = false, ThirdPerson = false,
    WallHop = false, Hitbox = false, Fullbright = false, GodMode = false,
    FpsBoost = false, AntiAfk = false, Fly = false, Speed = false,
    FovChanger = false, PCTrigger = false, MobileTrigger = false, ValCheck = false,
    TriggerWallCheck = false, TriggerTeamCheck = false, EspShowTracer = true,
    EspShowBox = true, EspShowName = true, EspShowHealth = true, EspShowDist = true,
    EspTeamCheck = false, EspValCheck = false, AimValCheck = false, TeamCheck = false,
    SilentAim = false, SmoothToggle = false, EspColorTarget = nil
}

for name, default in pairs(vars) do
    local current = default
    F["get"..name] = function() return current end
    F["set"..name] = function(v) current = v end
end

F.getInfiniteJumpConn = function() return infiniteJumpConn end
F.setInfiniteJumpConn = function(v) infiniteJumpConn = v end

-- Додаємо існуючі функції в таблицю
F.canClick = canClick
F.updateTeleportList = updateTeleportList
F.clearESP = clearESP
F.changeSky = changeSky
F.startChaos = startChaos
F.stopChaos = stopChaos
F.startThirdPerson = startThirdPerson
F.stopThirdPerson = stopThirdPerson
F.startWallHop = startWallHop
F.stopWallHop = stopWallHop
F.updateHitboxes = updateHitboxes
F.setHitboxPart = function(v) hitboxPart = v end
F.updateHitboxPartButtons = updateHitboxPartButtons
F.enableFullbright = enableFullbright
F.disableFullbright = disableFullbright
F.startGodMode = function() end
F.stopGodMode = function() end
F.enableFPSBoost = enableFPSBoost
F.disableFPSBoost = disableFPSBoost
F.startAntiAFK = startAntiAFK
F.stopAntiAFK = stopAntiAFK
F.startFly = startFly
F.stopFly = stopFly
F.startSpeedHack = startSpeedHack
F.stopSpeedHack = stopSpeedHack
F.openCharmsColorPicker = function() end
F.updatePlayerSelectList = updatePlayerSelectList
F.updateEspValCheckList = function() end
F.updateAimValCheckList = function() end

return function(G, V)
    return F
end
