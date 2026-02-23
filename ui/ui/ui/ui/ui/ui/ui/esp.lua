local ESP = {}

ESP.Enabled = {
    NPC = false,
    Player = false,
    Boss = false,
    Fruit = false,
    Chest = false
}

ESP.Settings = {
    RefreshRate = 1,
    Color_NPC = Color3.fromRGB(255, 0, 0),
    Color_Player = Color3.fromRGB(0, 255, 255),
    Color_Boss = Color3.fromRGB(255, 50, 50),
    Color_Fruit = Color3.fromRGB(255, 100, 0),
    Color_Chest = Color3.fromRGB(255, 255, 0)
}

local function createBox(obj, color)
    if obj:FindFirstChild("ESP_BOX") then return end
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ESP_BOX"
    box.Adornee = obj
    box.Size = obj.Size
    box.Color3 = color
    box.Transparency = 0.5
    box.AlwaysOnTop = true
    box.Parent = obj
end

local function clearOldESP()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "ESP_BOX" then
            v:Destroy()
        end
    end
end

function ESP.Update()
    clearOldESP()

    if ESP.Enabled.NPC then
        for _, npc in pairs(workspace:GetDescendants()) do
            if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
                createBox(npc.HumanoidRootPart, ESP.Settings.Color_NPC)
            end
        end
    end

    if ESP.Enabled.Player then
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                createBox(plr.Character.HumanoidRootPart, ESP.Settings.Color_Player)
            end
        end
    end

    if ESP.Enabled.Boss then
        for _, npc in pairs(workspace:GetDescendants()) do
            if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") and npc.Name:lower():find("boss") then
                createBox(npc.HumanoidRootPart, ESP.Settings.Color_Boss)
            end
        end
    end

    if ESP.Enabled.Fruit then
        for _, fruit in pairs(workspace:GetDescendants()) do
            if fruit:IsA("Tool") and fruit:FindFirstChild("Handle") then
                createBox(fruit.Handle, ESP.Settings.Color_Fruit)
            end
        end
    end

    if ESP.Enabled.Chest then
        for _, chest in pairs(workspace:GetDescendants()) do
            if chest:IsA("Model") and chest:FindFirstChild("HumanoidRootPart") and chest.Name:lower():find("chest") then
                createBox(chest.HumanoidRootPart, ESP.Settings.Color_Chest)
            end
        end
    end
end

task.spawn(function()
    while true do
        ESP.Update()
        task.wait(ESP.Settings.RefreshRate)
    end
end)

return ESP
