local Slider = {}
Slider.__index = Slider

function Slider.new(tab, text, min, max, default, callback)
    local self = setmetatable({}, Slider)

    self.Value = default or min

    -- Main frame
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 220, 0, 40)
    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Frame.Parent = tab.Page

    -- Label
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Text = text .. ": " .. tostring(self.Value)
    Label.Parent = Frame

    -- Slider bar
    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(1, -20, 0, 10)
    Bar.Position = UDim2.new(0, 10, 0, 25)
    Bar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Bar.Parent = Frame

    -- Fill
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((self.Value - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    Fill.Parent = Bar

    -- Drag logic
    local UIS = game:GetService("UserInputService")
    local dragging = false

    Bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
            self.Value = math.floor(min + (max - min) * pos)
            Fill.Size = UDim2.new(pos, 0, 1, 0)
            Label.Text = text .. ": " .. tostring(self.Value)

            if callback then
                callback(self.Value)
            end
        end
    end)

    self.Frame = Frame
    self.Label = Label
    self.Bar = Bar
    self.Fill = Fill

    return self
end

return Slider
