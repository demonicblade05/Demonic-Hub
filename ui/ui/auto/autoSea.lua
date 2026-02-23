local autoSea = {}

autoSea.Enabled = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Auto detect ANY weapon
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

-- Detect Sea Targets
local function getSeaTarget()
    local closest, dist = nil, math.huge
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") then
            local name = obj.Name:lower()

            if name:find("sea beast")
                or name:find("shark")
                or name:find("pirate")
                or name:find("marine")
                or name:find("boat")
                or name:find("ship")
            then
                local d = (obj.HumanoidRootPart.Position - root.Position).Magnitude
                if d < dist and obj:FindFirstChild("Humanoid") and obj.Humanoid.Health > 0 then
                    closest = obj
                    dist = d
                end
            end
        end
    end

    return closest
end

-- Hybrid movement (safe + fast)
local function hybridMove(target)
    local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local distance = (root.Position - target.Position).Magnitude

    if distance > 400 then
        root.CFrame = target.CFrame + Vector3.new(0, 8, 0)
    else
        local tween = TweenService:Create(
            root,
            TweenInfo.new(0.25, Enum.EasingStyle.Linear),
            {CFrame = target.CFrame + Vector3.new(0, 8, 0)}
        )
        tween:Play()
    end
end

RunService.Heartbeat:Connect(function()
    if not autoSea.Enabled then return end

    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local target = getSeaTarget()
    if target then
        equipWeapon()
        hybridMove(target.HumanoidRootPart)

        local weapon = getWeapon()
        if weapon then
            weapon:Activate()
        end
    end
end)

return autoSea
