local autoNPC = {}

autoNPC.Enabled = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

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

local function getNearestNPC()
    local closest, dist = nil, math.huge
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    for _, npc in pairs(workspace:GetDescendants()) do
        if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
            local d = (npc.HumanoidRootPart.Position - root.Position).Magnitude
            if d < dist and npc.Humanoid.Health > 0 then
                closest = npc
                dist = d
            end
        end
    end

    return closest
end

local function hybridMove(target)
    local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local distance = (root.Position - target.Position).Magnitude

    if distance > 300 then
        root.CFrame = target.CFrame + Vector3.new(0, 3, 0)
    else
        local tween = game:GetService("TweenService"):Create(
            root,
            TweenInfo.new(0.2, Enum.EasingStyle.Linear),
            {CFrame = target.CFrame + Vector3.new(0, 3, 0)}
        )
        tween:Play()
    end
end

RunService.Heartbeat:Connect(function()
    if not autoNPC.Enabled then return end
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local npc = getNearestNPC()
    if npc then
        equipWeapon()
        hybridMove(npc.HumanoidRootPart)
        local weapon = getWeapon()
        if weapon then weapon:Activate() end
    end
end)

return autoNPC
