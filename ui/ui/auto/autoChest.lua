local autoChest = {}

autoChest.Enabled = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local function getNearestChest()
    local closest, dist = nil, math.huge
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    for _, chest in pairs(workspace:GetDescendants()) do
        if chest:IsA("Model") and chest:FindFirstChild("HumanoidRootPart") then
            local name = chest.Name:lower()
            if name:find("chest") then
                local d = (chest.HumanoidRootPart.Position - root.Position).Magnitude
                if d < dist then
                    closest = chest
                    dist = d
                end
            end
        end
    end

    return closest
end

local function safeMove(target)
    local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local distance = (root.Position - target.Position).Magnitude

    if distance > 350 then
        root.CFrame = target.CFrame + Vector3.new(0, 3, 0)
    else
        local tween = TweenService:Create(
            root,
            TweenInfo.new(0.25, Enum.EasingStyle.Linear),
            {CFrame = target.CFrame + Vector3.new(0, 3, 0)}
        )
        tween:Play()
    end
end

RunService.Heartbeat:Connect(function()
    if not autoChest.Enabled then return end

    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local chest = getNearestChest()
    if chest and chest:FindFirstChild("HumanoidRootPart") then
        safeMove(chest.HumanoidRootPart)
        task.wait(0.1)
        firetouchinterest(char.HumanoidRootPart, chest.HumanoidRootPart, 0)
        firetouchinterest(char.HumanoidRootPart, chest.HumanoidRootPart, 1)
    end
end)

return autoChest
