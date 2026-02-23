local autoQuest = {}

autoQuest.Enabled = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local function getQuestNPC()
    for _, npc in pairs(workspace:GetDescendants()) do
        if npc:IsA("Model") and npc:FindFirstChild("Head") then
            local name = npc.Name:lower()
            if name:find("quest") or name:find("giver") or name:find("villager") then
                return npc
            end
        end
    end
    return nil
end

local function getQuestButton()
    for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
        if gui:IsA("TextButton") and gui.Text:lower():find("accept") then
            return gui
        end
    end
    return nil
end

local function acceptQuest()
    local npc = getQuestNPC()
    if not npc or not npc:FindFirstChild("Head") then return end

    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    root.CFrame = npc.Head.CFrame + Vector3.new(0, 3, 0)
    task.wait(0.3)

    fireproximityprompt(npc:FindFirstChildWhichIsA("ProximityPrompt"), 1)
    task.wait(0.5)

    local acceptBtn = getQuestButton()
    if acceptBtn then
        acceptBtn:Activate()
    end
end

local function hasQuest()
    for _, v in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
        if v:IsA("TextLabel") and v.Text:lower():find("defeat") then
            return true
        end
    end
    return false
end

RunService.Heartbeat:Connect(function()
    if not autoQuest.Enabled then return end

    if not hasQuest() then
        acceptQuest()
    end
end)

return autoQuest
