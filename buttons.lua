-- ============================================================
--   buttons.lua
-- ============================================================
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function init(G, F)

-- ============ ОСНОВНІ КНОПКИ ============
G.teleportButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        G.frame.Visible = false
        G.aimSettingsFrame.Visible = false
        G.hitboxSettingsFrame.Visible = false
        G.teleportFrame.Visible = true
        F.updateTeleportList()
    end
end)

G.backButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        G.teleportFrame.Visible = false
        G.frame.Visible = true
    end
end)

G.aimSettingsOpenButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        G.aimSettingsFrame.Visible = not G.aimSettingsFrame.Visible
        G.hitboxSettingsFrame.Visible = false
    end
end)

G.aimCloseButton.MouseButton1Click:Connect(function()
    if F.canClick() then G.aimSettingsFrame.Visible = false end
end)

G.aimButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setHolding(not F.getHolding())
        G.aimButton.Text = F.getHolding() and "AIM: ON" or "AIM: OFF"
        G.aimButton.BackgroundColor3 = F.getHolding() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.fovCircleButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setFovCircle(not F.getFovCircle())
        G.fovCircleButton.Text = F.getFovCircle() and "FOV Circle: ON" or "FOV Circle: OFF"
        G.fovCircleButton.BackgroundColor3 = F.getFovCircle() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.wallButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setWallCheck(not F.getWallCheck())
        G.wallButton.Text = F.getWallCheck() and "WallCheck: ON" or "WallCheck: OFF"
        G.wallButton.BackgroundColor3 = F.getWallCheck() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.espButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setEsp(not F.getEsp())
        G.espButton.Text = F.getEsp() and "ESP: ON" or "ESP: OFF"
        G.espButton.BackgroundColor3 = F.getEsp() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
        if not F.getEsp() then F.clearESP() end
    end
end)

G.charmsButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setCharms(not F.getCharms())
        G.charmsButton.Text = F.getCharms() and "Charms: ON" or "Charms: OFF"
        G.charmsButton.BackgroundColor3 = F.getCharms() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.charmsSettingsOpenButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        G.charmsSettingsFrame.Visible = not G.charmsSettingsFrame.Visible
        G.charmsColorPickerFrame.Visible = false
    end
end)

G.charmsSettingsCloseBtn.MouseButton1Click:Connect(function()
    if F.canClick() then
        G.charmsSettingsFrame.Visible = false
        G.charmsColorPickerFrame.Visible = false
    end
end)

G.charmsVisColorOpenBtn.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.openCharmsColorPicker("vis")
    end
end)

G.charmsUnvisColorOpenBtn.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.openCharmsColorPicker("unvis")
    end
end)

G.charmsColorPickerClose.MouseButton1Click:Connect(function()
    if F.canClick() then
        G.charmsColorPickerFrame.Visible = false
        G.charmsSettingsFrame.Visible = true
    end
end)

G.charmsNpcButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setCharmsNpc(not F.getCharmsNpc())
        G.charmsNpcButton.Text = F.getCharmsNpc() and "NPC: ON" or "NPC: OFF"
        G.charmsNpcButton.BackgroundColor3 = F.getCharmsNpc() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.charmsEspObjButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setCharmsEspObj(not F.getCharmsEspObj())
        G.charmsEspObjButton.Text = F.getCharmsEspObj() and "ESP Objects: ON" or "ESP Objects: OFF"
        G.charmsEspObjButton.BackgroundColor3 = F.getCharmsEspObj() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.infiniteJumpButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setInfiniteJump(not F.getInfiniteJump())
        G.infiniteJumpButton.Text = F.getInfiniteJump() and "Infinite Jump: ON" or "Infinite Jump: OFF"
        G.infiniteJumpButton.BackgroundColor3 = F.getInfiniteJump() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
        if F.getInfiniteJump() then
            F.setInfiniteJumpConn(UserInputService.JumpRequest:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end))
        else
            local conn = F.getInfiniteJumpConn()
            if conn then conn:Disconnect(); F.setInfiniteJumpConn(nil) end
        end
    end
end)

G.noclipButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        local newState = not F.getNoclip()
        F.setNoclip(newState)
        G.noclipButton.Text = newState and "Noclip: ON" or "Noclip: OFF"
        G.noclipButton.BackgroundColor3 = newState and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.bunnyHopButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setBunnyHop(not F.getBunnyHop())
        G.bunnyHopButton.Text = F.getBunnyHop() and "BunnyHop: ON" or "BunnyHop: OFF"
        G.bunnyHopButton.BackgroundColor3 = F.getBunnyHop() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.skyButton.MouseButton1Click:Connect(function()
    if F.canClick() then F.changeSky() end
end)

G.chaosButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setChaos(not F.getChaos())
        G.chaosButton.Text = F.getChaos() and "Chaos: ON" or "Chaos: OFF"
        G.chaosButton.BackgroundColor3 = F.getChaos() and Color3.fromRGB(150,0,0) or Color3.fromRGB(40,40,40)
        if F.getChaos() then F.startChaos() else F.stopChaos() end
    end
end)

G.thirdPersonButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setThirdPerson(not F.getThirdPerson())
        G.thirdPersonButton.Text = F.getThirdPerson() and "Third Person: ON" or "Third Person: OFF"
        G.thirdPersonButton.BackgroundColor3 = F.getThirdPerson() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
        if F.getThirdPerson() then F.startThirdPerson() else F.stopThirdPerson() end
    end
end)

G.wallHopButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setWallHop(not F.getWallHop())
        G.wallHopButton.Text = F.getWallHop() and "Wall Hop: ON" or "Wall Hop: OFF"
        G.wallHopButton.BackgroundColor3 = F.getWallHop() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
        if F.getWallHop() then F.startWallHop() else F.stopWallHop() end
    end
end)

G.hitboxButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setHitbox(not F.getHitbox())
        G.hitboxButton.Text = F.getHitbox() and "Hitbox: ON" or "Hitbox: OFF"
        G.hitboxButton.BackgroundColor3 = F.getHitbox() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
        F.updateHitboxes()
    end
end)

G.hitboxSettingsOpenButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        G.hitboxSettingsFrame.Visible = not G.hitboxSettingsFrame.Visible
        G.aimSettingsFrame.Visible = false
    end
end)

G.hitboxCloseButton.MouseButton1Click:Connect(function()
    if F.canClick() then G.hitboxSettingsFrame.Visible = false end
end)

G.hitboxHeadButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setHitboxPart("Head")
        F.updateHitboxPartButtons()
        if F.getHitbox() then F.updateHitboxes() end
    end
end)

G.hitboxTorsoButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setHitboxPart("Torso")
        F.updateHitboxPartButtons()
        if F.getHitbox() then F.updateHitboxes() end
    end
end)

G.hitboxArmsButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setHitboxPart("Arms")
        F.updateHitboxPartButtons()
        if F.getHitbox() then F.updateHitboxes() end
    end
end)

G.hitboxLegsButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setHitboxPart("Legs")
        F.updateHitboxPartButtons()
        if F.getHitbox() then F.updateHitboxes() end
    end
end)

G.fullbrightButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setFullbright(not F.getFullbright())
        G.fullbrightButton.Text = F.getFullbright() and "Fullbright: ON" or "Fullbright: OFF"
        G.fullbrightButton.BackgroundColor3 = F.getFullbright() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
        if F.getFullbright() then F.enableFullbright() else F.disableFullbright() end
    end
end)

G.godModeButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setGodMode(not F.getGodMode())
        G.godModeButton.Text = F.getGodMode() and "God Mode: ON" or "God Mode: OFF"
        G.godModeButton.BackgroundColor3 = F.getGodMode() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
        if F.getGodMode() then F.startGodMode() else F.stopGodMode() end
    end
end)

G.fpsBoostButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setFpsBoost(not F.getFpsBoost())
        G.fpsBoostButton.Text = F.getFpsBoost() and "FPS Boost: ON" or "FPS Boost: OFF"
        G.fpsBoostButton.BackgroundColor3 = F.getFpsBoost() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
        if F.getFpsBoost() then F.enableFPSBoost() else F.disableFPSBoost() end
    end
end)

G.antiAfkButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setAntiAfk(not F.getAntiAfk())
        G.antiAfkButton.Text = F.getAntiAfk() and "Anti AFK: ON" or "Anti AFK: OFF"
        G.antiAfkButton.BackgroundColor3 = F.getAntiAfk() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
        if F.getAntiAfk() then F.startAntiAFK() else F.stopAntiAFK() end
    end
end)

G.flyButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setFly(not F.getFly())
        G.flyButton.Text = F.getFly() and "Fly: ON" or "Fly: OFF"
        G.flyButton.BackgroundColor3 = F.getFly() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
        if F.getFly() then F.startFly() else F.stopFly() end
    end
end)

G.speedButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setSpeed(not F.getSpeed())
        G.speedButton.Text = F.getSpeed() and "Speed: ON" or "Speed: OFF"
        G.speedButton.BackgroundColor3 = F.getSpeed() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.fovButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setFovChanger(not F.getFovChanger())
        G.fovButton.Text = F.getFovChanger() and "FOV: ON" or "FOV: OFF"
        G.fovButton.BackgroundColor3 = F.getFovChanger() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

-- ============ MINIMIZE ============
G.minimizeButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        G.frame.Visible = false
        G.teleportFrame.Visible = false
        G.aimSettingsFrame.Visible = false
        G.hitboxSettingsFrame.Visible = false
        G.configFrame.Visible = false
        G.espSettingsFrame.Visible = false
        G.charmsSettingsFrame.Visible = false
        G.playerSelectFrame.Visible = false
        G.espValCheckFrame.Visible = false
        G.espColorPickerFrame.Visible = false
        G.charmsColorPickerFrame.Visible = false
        G.aimValCheckFrame.Visible = false
        G.minimizedCircle.Visible = true
    end
end)

G.minimizedCircle.MouseButton1Click:Connect(function()
    if F.canClick() then
        G.frame.Visible = true
        G.minimizedCircle.Visible = false
    end
end)

-- ============ PC TRIGGER ============
G.pcTriggerButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        local newVal = not F.getPCTrigger()
        if newVal then
            F.setMobileTrigger(false)
            G.mobileTriggerButton.Text = "Mobile Trigger: OFF"
            G.mobileTriggerButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
            G.mobileGui.Visible = false
            G.mobileSpaceFrame.Visible = false
        end
        F.setPCTrigger(newVal)
        G.pcTriggerButton.Text = newVal and "PC Trigger: ON" or "PC Trigger: OFF"
        G.pcTriggerButton.BackgroundColor3 = newVal and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

-- ============ MOBILE TRIGGER ============
G.mobileTriggerButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        local newVal = not F.getMobileTrigger()
        if newVal then
            F.setPCTrigger(false)
            G.pcTriggerButton.Text = "PC Trigger: OFF"
            G.pcTriggerButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
        end
        F.setMobileTrigger(newVal)
        G.mobileTriggerButton.Text = newVal and "Mobile Trigger: ON" or "Mobile Trigger: OFF"
        G.mobileTriggerButton.BackgroundColor3 = newVal and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
        G.mobileGui.Visible = newVal
        G.mobileSpaceFrame.Visible = newVal
    end
end)

-- ============ VAL CHECK ============
G.valCheckButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setValCheck(not F.getValCheck())
        G.valCheckButton.Text = F.getValCheck() and "Val Check: ON" or "Val Check: OFF"
        G.valCheckButton.BackgroundColor3 = F.getValCheck() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.valCheckOpenButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        local visible = not G.playerSelectFrame.Visible
        G.playerSelectFrame.Visible = visible
        if visible then
            F.updatePlayerSelectList()
            local aimPos = G.aimSettingsFrame.AbsolutePosition
            local aimSize = G.aimSettingsFrame.AbsoluteSize
            G.playerSelectFrame.Position = UDim2.new(0, aimPos.X + aimSize.X + 10, 0, aimPos.Y)
        end
    end
end)

G.playerSelectClose.MouseButton1Click:Connect(function()
    if F.canClick() then G.playerSelectFrame.Visible = false end
end)

G.triggerWallCheckButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setTriggerWallCheck(not F.getTriggerWallCheck())
        G.triggerWallCheckButton.Text = F.getTriggerWallCheck() and "Trigger WallCheck: ON" or "Trigger WallCheck: OFF"
        G.triggerWallCheckButton.BackgroundColor3 = F.getTriggerWallCheck() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.triggerTeamCheckButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setTriggerTeamCheck(not F.getTriggerTeamCheck())
        G.triggerTeamCheckButton.Text = F.getTriggerTeamCheck() and "Trigger Team Check: ON" or "Trigger Team Check: OFF"
        G.triggerTeamCheckButton.BackgroundColor3 = F.getTriggerTeamCheck() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

-- ============ ESP SETTINGS ============
G.espVisColorOpenBtn.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setEspColorTarget("vis")
        G.espColorPickerFrame.Visible = true
        G.espValCheckFrame.Visible = false
    end
end)

G.espUnvisColorOpenBtn.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setEspColorTarget("unvis")
        G.espColorPickerFrame.Visible = true
        G.espValCheckFrame.Visible = false
    end
end)

G.espSettingsOpenButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        G.espSettingsFrame.Visible = not G.espSettingsFrame.Visible
        G.espColorPickerFrame.Visible = false
        G.espValCheckFrame.Visible = false
    end
end)

G.espSettingsCloseBtn.MouseButton1Click:Connect(function()
    if F.canClick() then
        G.espSettingsFrame.Visible = false
        G.espColorPickerFrame.Visible = false
        G.espValCheckFrame.Visible = false
    end
end)

G.espTracerBtn.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setEspShowTracer(not F.getEspShowTracer())
        G.espTracerBtn.Text = F.getEspShowTracer() and "Tracer: ON" or "Tracer: OFF"
        G.espTracerBtn.BackgroundColor3 = F.getEspShowTracer() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.espBoxBtn.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setEspShowBox(not F.getEspShowBox())
        G.espBoxBtn.Text = F.getEspShowBox() and "Box: ON" or "Box: OFF"
        G.espBoxBtn.BackgroundColor3 = F.getEspShowBox() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.espNameBtn.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setEspShowName(not F.getEspShowName())
        G.espNameBtn.Text = F.getEspShowName() and "Name: ON" or "Name: OFF"
        G.espNameBtn.BackgroundColor3 = F.getEspShowName() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.espHealthBtn.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setEspShowHealth(not F.getEspShowHealth())
        G.espHealthBtn.Text = F.getEspShowHealth() and "Health: ON" or "Health: OFF"
        G.espHealthBtn.BackgroundColor3 = F.getEspShowHealth() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.espDistBtn.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setEspShowDist(not F.getEspShowDist())
        G.espDistBtn.Text = F.getEspShowDist() and "Distance: ON" or "Distance: OFF"
        G.espDistBtn.BackgroundColor3 = F.getEspShowDist() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.espTeamCheckBtn.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setEspTeamCheck(not F.getEspTeamCheck())
        G.espTeamCheckBtn.Text = F.getEspTeamCheck() and "ESP Team Check: ON" or "ESP Team Check: OFF"
        G.espTeamCheckBtn.BackgroundColor3 = F.getEspTeamCheck() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.espValCheckBtn.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setEspValCheck(not F.getEspValCheck())
        G.espValCheckBtn.Text = F.getEspValCheck() and "ESP ValCheck: ON" or "ESP ValCheck: OFF"
        G.espValCheckBtn.BackgroundColor3 = F.getEspValCheck() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.espValCheckOpenBtn.MouseButton1Click:Connect(function()
    if F.canClick() then
        G.espValCheckFrame.Visible = not G.espValCheckFrame.Visible
        G.espColorPickerFrame.Visible = false
        if G.espValCheckFrame.Visible then F.updateEspValCheckList() end
    end
end)

G.espValCheckClose.MouseButton1Click:Connect(function()
    if F.canClick() then G.espValCheckFrame.Visible = false end
end)

G.espColorPickerClose.MouseButton1Click:Connect(function()
    if F.canClick() then G.espColorPickerFrame.Visible = false end
end)

-- ============ AIM SETTINGS ============
G.aimValCheckButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setAimValCheck(not F.getAimValCheck())
        G.aimValCheckButton.Text = F.getAimValCheck() and "AIM ValCheck: ON" or "AIM ValCheck: OFF"
        G.aimValCheckButton.BackgroundColor3 = F.getAimValCheck() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.aimValCheckOpenButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        G.aimValCheckFrame.Visible = not G.aimValCheckFrame.Visible
        if G.aimValCheckFrame.Visible then
            F.updateAimValCheckList()
            local aimPos = G.aimSettingsFrame.AbsolutePosition
            local aimSize = G.aimSettingsFrame.AbsoluteSize
            G.aimValCheckFrame.Position = UDim2.new(0, aimPos.X + aimSize.X + 10, 0, aimPos.Y)
        end
    end
end)

G.aimValCheckClose.MouseButton1Click:Connect(function()
    if F.canClick() then G.aimValCheckFrame.Visible = false end
end)

G.teamCheckButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setTeamCheck(not F.getTeamCheck())
        G.teamCheckButton.Text = F.getTeamCheck() and "Team Check: ON" or "Team Check: OFF"
        G.teamCheckButton.BackgroundColor3 = F.getTeamCheck() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

G.silentAimButton.MouseButton1Click:Connect(function()
    if F.canClick() then
        F.setSilentAim(not F.getSilentAim())
        G.silentAimButton.Text = F.getSilentAim() and "Silent Aim: ON" or "Silent Aim: OFF"
        G.silentAimButton.BackgroundColor3 = F.getSilentAim() and Color3.fromRGB(0,180,0) or Color3.fromRGB(40,40,40)
    end
end)

end

return init
