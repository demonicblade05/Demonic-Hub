local npcESP = {}

function npcESP.HighlightNPC(npc)
    if npc:FindFirstChild("HumanoidRootPart") and not npc:FindFirstChild("ESP") then
        local box = Instance.new("BoxHandleAdornment")
        box.Name = "ESP"
        box.Adornee = npc.HumanoidRootPart
        box.Size = Vector3.new(4, 6, 4)
        box.Color3 = Color3.fromRGB(255, 0, 0)
        box.Transparency = 0.5
        box.ZIndex = 0
        box.AlwaysOnTop = true
        box.Parent = npc
    end
end

function npcESP.Scan()
    for _, npc in pairs(workspace:GetDescendants()) do
        if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
            npcESP.HighlightNPC(npc)
        end
    end
end

return npcESP
