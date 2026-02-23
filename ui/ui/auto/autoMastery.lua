local autoMastery = {}

autoMastery.Enabled = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Get ANY weapon (melee, sword, fruit, gun)
local function getWeapon()
    for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            return tool
        end
    end
    for _, tool in pairs(LocalPlayer.Character:GetChildren()) do
        if tool:IsA("Tool") then
            return tool
        end
    end
    return nil
end

local function equipWeapon()
    local weapon = getWeapon()
    if weapon and weapon.Parent ~= LocalPlayer.Character then
        weapon.Parent = LocalPlayer.Character
    end
end

-- Find NPC with lowest HP (best for mastery)
local function getLowHPNPC()
    local target = nil
    local lowestHP = math.huge
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    for _, npc in pairs(workspace:GetDescendants()) do
        if npc:IsA("Model") 
            and npc:FindFirstChild("Humanoid") 
            and npc:FindFirstChild("HumanoidRootPart") 
            and npc.Humanoid.Health > 0 
        then
            if npc.Humanoid.Health < lowestHP then
                lowestHP = npc.Humanoid.Health
                target = npc
            end
        end
    end

    return target
end

-- Hybrid movement (safe + fast)
local function hybridMove(target)
    local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local distance = (root.Position - target.Position).Magnitude

    if distance > 350 then
        root.CFrame = target.CFrame + Vector3.new(0, 4, 0)
    else
        local tween = TweenService:Create(
            root,
            TweenInfo.new(0.25, Enum.EasingStyle.Linear),
            {CFrame = target.CFrame + Vector3.new(0, 4, 0)}
        )
        tween:Play()
    end
end

RunService.Heartbeat:Connect(function()
    if not autoMastery.Enabled then return end

    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local npc = getLowHPNPC()
    if npc then
        equipWeapon()
        hybridMove(npc.HumanoidRootPart)

        local weapon = getWeapon()
        if weapon then
            weapon:Activate()
        end
    end
end)

return autoMastery
