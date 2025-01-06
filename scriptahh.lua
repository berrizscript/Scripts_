local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

-- Configuration for launch and jump
local launchForce = 50 -- Adjust this value for backward speed
local jumpForce = 10 -- Adjust this value for jump height
local speedMultiplier = 2 -- Multiplier to make the launch and jump faster
local duration = 0.5 / speedMultiplier -- Adjust duration based on speed multiplier

-- Animation ID
local animationId = "10491993682"

local function launchBackward()
    local backwardVector = -humanoidRootPart.CFrame.LookVector -- Get the backward direction by negating the forward vector
    local bodyVelocity = Instance.new("BodyVelocity")

    -- Combine backward and upward forces, applying the speed multiplier to duration
    bodyVelocity.Velocity = (backwardVector * launchForce * speedMultiplier) + Vector3.new(0, jumpForce * speedMultiplier, 0)
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge) -- Allow movement in all directions
    bodyVelocity.P = 1250 -- Optional: Adjust damping effect
    bodyVelocity.Parent = humanoidRootPart

    -- Play the animation
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://" .. animationId
    local animationTrack = humanoid:LoadAnimation(animation)
    animationTrack:Play()

    -- Stop the animation after 0.5 seconds
    task.delay(0.09, function()
        animationTrack:Stop()
        animation:Destroy()
    end)

    -- Remove the force after the adjusted duration
    game:GetService("Debris"):AddItem(bodyVelocity, duration)
end

-- Trigger the launch instantly
launchBackward()
