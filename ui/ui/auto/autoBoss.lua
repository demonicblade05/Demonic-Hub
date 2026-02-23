local autoBoss = {}

autoBoss.Enabled = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

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

local function getNearestBoss()
    local closest, dist = nil, math.huge
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    for _, npc in pairs(workspace:GetDescendants()) do
        if npc:IsA("Model") 
            and npc:FindFirstChild("Humanoid") 
            and npc:FindFirstChild("HumanoidRootPart") 
            and npc.Humanoid.Health > 0 
            and (
                npc.Name:lower():find("boss") or
                npc.Name:lower():find("captain") or
                npc.Name:lower():find("elite") or
                npc.Name:lower():find("king") or
                npc.Name:lower():find("queen") or
                npc.Name:lower():find("admiral")
            )
        then
            local d = (npc.HumanoidRootPart.Position - root.Position).Magnitude
            if d < dist then
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

    if distance > 350 then
        root.CFrame = target.CFrame + Vector3.new(0, 5, 0)
    else
        local tween = TweenService:Create(
            root,
            TweenInfo.new(0.25, Enum.EasingStyle.Linear),
            {CFrame = target.CFrame + Vector3.new(0, 5, 0)}
        )
        tween:Play()
    end
end

RunService.Heartbeat:Connect(function()
    if not autoBoss.Enabled then return end
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local boss = getNearestBoss()
    if boss then
        equipWeapon()
        hybridMove(boss.HumanoidRootPart)
        local weapon = getWeapon()
        if weapon then weapon:Activate() end
    end
end)

return autoBoss
