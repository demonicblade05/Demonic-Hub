getgenv().AutoAttack = false

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer

local function getClosestEnemy()
    local char = player.Character
    if not char then return end

    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local closest, dist = nil, math.huge

    for _, v in pairs(workspace:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
            local d = (v.HumanoidRootPart.Position - root.Position).Magnitude
            if d < dist then
                dist = d
                closest = v
            end
        end
    end

    return closest
end

RunService.RenderStepped:Connect(function()
    if not getgenv().AutoAttack then return end

    local char = player.Character
    if not char then return end

    local humanoid = char:FindFirstChild("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root then return end

    local target = getClosestEnemy()
    if not target then return end

    -- Move to enemy
    humanoid:MoveTo(target.HumanoidRootPart.Position)

    -- Attack enemy
    VirtualUser:Button1Down(Vector2.new(0,0))
    VirtualUser:Button1Up(Vector2.new(0,0))
end)
