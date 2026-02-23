local Toggle = {}
Toggle.__index = Toggle

function Toggle.new(tab, text, default, callback)
    local self = setmetatable({}, Toggle)

    self.Value = default or false

    -- Toggle frame
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 200, 0, 30)
    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Frame.Parent = tab.Page

    -- Label
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -40, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Text = text
    Label.Parent = Frame

    -- Toggle button
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 30, 0, 20)
    Button.Position = UDim2.new(1, -35, 0.5, -10)
    Button.BackgroundColor3 = self.Value and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(60, 60, 60)
    Button.Text = ""
    Button.Parent = Frame

    -- Toggle logic
    Button.MouseButton1Click:Connect(function()
        self.Value = not self.Value
        Button.BackgroundColor3 = self.Value and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(60, 60, 60)

        if callback then
            callback(self.Value)
        end
    end)

    self.Frame = Frame
    self.Button = Button
    self.Label = Label

    return self
end

return Toggle
