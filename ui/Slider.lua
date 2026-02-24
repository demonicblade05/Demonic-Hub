local Slider = {}
Slider.__index = Slider

function Slider.new(parent, text, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0

    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(1, 0, 0.4, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Text = text .. ": " .. default

    local bar = Instance.new("Frame")
    bar.Parent = frame
    bar.Size = UDim2.new(1, -20, 0, 10)
    bar.Position = UDim2.new(0, 10, 0.6, 0)
    bar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    bar.BorderSizePixel = 0

    local fill = Instance.new("Frame")
    fill.Parent = bar
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    fill.BorderSizePixel = 0

    local dragging = false

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    bar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(pos, 0, 1, 0)
            local value = math.floor(min + (max - min) * pos)
            label.Text = text .. ": " .. value
            if callback then
                pcall(callback, value)
            end
        end
    end)

    return frame
end

return Slider
