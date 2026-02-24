local Toggle = {}
Toggle.__index = Toggle

function Toggle.new(parent, text, default, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Size = UDim2.new(1, -10, 0, 30)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0

    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Text = text

    local btn = Instance.new("TextButton")
    btn.Parent = frame
    btn.Size = UDim2.new(0.3, 0, 1, 0)
    btn.Position = UDim2.new(0.7, 0, 0, 0)
    btn.BackgroundColor3 = default and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
    btn.Text = default and "ON" or "OFF"
    btn.BorderSizePixel = 0

    local state = default

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = state and "ON" or "OFF"
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
        if callback then
            pcall(callback, state)
        end
    end)

    return frame
end

return Toggle
