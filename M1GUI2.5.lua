local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Function to fully freeze the player
local function freezePlayer(duration)
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        humanoidRootPart.Anchored = true -- Locks the player's position

        -- Unfreeze after the specified duration
        task.delay(duration, function()
            humanoidRootPart.Anchored = false
        end)
    else
        warn("HumanoidRootPart not found")
    end
end

-- Function to smoothly teleport the player
local function smoothTeleportToCFrame(targetCFrame)
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if rootPart then
        local tweenService = game:GetService("TweenService")
        local tweenInfo = TweenInfo.new(
            0.3, -- Duration
            Enum.EasingStyle.Sine, -- Smooth easing style
            Enum.EasingDirection.InOut -- Bidirectional smoothness
        )

        local tween = tweenService:Create(rootPart, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
    else
        warn("HumanoidRootPart not found")
    end
end

-- Function to play the animation and stop others
local function playAnimation(animationId)
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        local animator = humanoid:FindFirstChild("Animator") or humanoid:WaitForChild("Animator")
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            track:Stop()
        end
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://" .. animationId
        local animationTrack = animator:LoadAnimation(animation)
        animationTrack:Play()
        return animationTrack
    else
        warn("Humanoid not found")
    end
end

-- Function to play a sound with increased volume
local function playSound(soundId)
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Volume = 0.5 -- Increase volume
    sound.Parent = character:FindFirstChild("HumanoidRootPart") or workspace
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

-- GUI Setup
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

-- Button size and positioning variables
local buttonSize = UDim2.new(0, 100, 0, 100) -- Standard button size
local buttonSpacing = 110 -- Spacing between buttons

-- Toggle for direction
local tweenDirection = 1 -- 1 for right, -1 for left
local currentAnimationId = 10480793962 -- Default animation for Tween Right
local currentSoundId = "rbxassetid://10481117326" -- Default sound for Tween Right

-- Toggle Direction Image Button
local toggleDirectionButton = Instance.new("ImageButton")
toggleDirectionButton.Size = buttonSize
toggleDirectionButton.Position = UDim2.new(0, 10, 0.5, -buttonSpacing * 3)
toggleDirectionButton.Image = "rbxassetid://12253837933" -- Toggle Direction Image
toggleDirectionButton.BackgroundTransparency = 1
toggleDirectionButton.Parent = screenGui

toggleDirectionButton.MouseButton1Click:Connect(function()
    tweenDirection = -tweenDirection
    if tweenDirection == 1 then
        currentAnimationId = 10480793962
        currentSoundId = "rbxassetid://10481117326"
    else
        currentAnimationId = 10480796021
        currentSoundId = "rbxassetid://10481117236"
    end
end)

-- New Script Loader Button
local scriptLoaderButton = Instance.new("ImageButton")
scriptLoaderButton.Size = buttonSize
scriptLoaderButton.Position = UDim2.new(0, 10, 0.5, -buttonSpacing * 2) -- Position below the toggle button
scriptLoaderButton.Image = "rbxassetid://12252402662" -- Change image ID as needed
scriptLoaderButton.BackgroundTransparency = 1
scriptLoaderButton.Parent = screenGui

scriptLoaderButton.MouseButton1Click:Connect(function()
    local startTime = tick()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/berrizscript/Scripts_/main/script", true))()
    print("Script load time: ", tick() - startTime)
end)

-- Additional Script Loader Button
local additionalScriptLoaderButton = Instance.new("ImageButton")
additionalScriptLoaderButton.Size = buttonSize
additionalScriptLoaderButton.Position = UDim2.new(0, 120, 0.5, -buttonSpacing * 2) -- Position to the right of New Script Loader Button
additionalScriptLoaderButton.Image = "rbxassetid://12252402662" -- Same image as New Script Loader Button
additionalScriptLoaderButton.BackgroundTransparency = 1
additionalScriptLoaderButton.Parent = screenGui

additionalScriptLoaderButton.MouseButton1Click:Connect(function()
    local startTime = tick()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/berrizscript/Scripts_/refs/heads/main/scriptahh.lua", true))()
    print("Script load time: ", tick() - startTime)
end)

-- "Unorthodox" Image Button
local unorthodoxButton = Instance.new("ImageButton")
unorthodoxButton.Size = UDim2.new(0, 125, 0, 125) -- Slightly larger button
unorthodoxButton.Position = UDim2.new(0, 10, 0.5, -buttonSpacing)
unorthodoxButton.Image = "rbxassetid://12252434969"
unorthodoxButton.BackgroundTransparency = 1
unorthodoxButton.Parent = screenGui

unorthodoxButton.MouseButton1Click:Connect(function()
    smoothTeleportToCFrame(character.HumanoidRootPart.CFrame * CFrame.new(50 * tweenDirection, 0, 0))
    local dashAnimation = playAnimation(currentAnimationId) -- Play dash animation based on toggle
    dashAnimation.Stopped:Connect(function() -- Ensure no animations interfere
        for _, track in ipairs(character.Humanoid.Animator:GetPlayingAnimationTracks()) do
            if track ~= dashAnimation then
                track:Stop()
            end
        end
    end)
    playSound(currentSoundId) -- Play the sound based on toggle
end)

-- "Fake Side Dash" Image Button
local fakeSideDashButton = Instance.new("ImageButton")
fakeSideDashButton.Size = buttonSize
fakeSideDashButton.Position = UDim2.new(0, 10, 0.5, 20)
fakeSideDashButton.Image = "rbxassetid://12252434969"
fakeSideDashButton.BackgroundTransparency = 1
fakeSideDashButton.Parent = screenGui

fakeSideDashButton.MouseButton1Click:Connect(function()
    smoothTeleportToCFrame(character.HumanoidRootPart.CFrame * CFrame.new(30 * tweenDirection, 0, 0))
    local dashAnimation = playAnimation(currentAnimationId) -- Play dash animation based on toggle
    dashAnimation.Stopped:Connect(function() -- Ensure no animations interfere
        for _, track in ipairs(character.Humanoid.Animator:GetPlayingAnimationTracks()) do
            if track ~= dashAnimation then
                track:Stop()
            end
        end
    end)
    playSound(currentSoundId) -- Play the sound based on toggle
end)
