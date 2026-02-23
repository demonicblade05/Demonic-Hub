local autoFruit = {}

autoFruit.Enabled = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local function getNearestFruit()
    local closest, dist = nil, math.huge
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
            local name = obj.Name:lower()
            if name:find("fruit") or name:find("bomb") or name:find("light") or name:find("dark") or name:find("quake") or name:find("magma") then
                local d = (obj.Handle.Position - root.Position).Magnitude
                if d < dist then
                    closest = obj
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
    if not autoFruit.Enabled then return end

    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local fruit = getNearestFruit()
    if fruit and fruit:FindFirstChild("Handle") then
        safeMove(fruit.Handle)
        task.wait(0.1)
        firetouchinterest(char.HumanoidRootPart, fruit.Handle, 0)
        firetouchinterest(char.HumanoidRootPart, fruit.Handle, 1)
    end
end)

return autoFruit
