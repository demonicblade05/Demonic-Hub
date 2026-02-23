local Dropdown = {}
Dropdown.__index = Dropdown

function Dropdown.new(tab, text, options, callback)
    local self = setmetatable({}, Dropdown)

    self.Value = options[1] or "None"
    self.Open = false

    -- Main frame
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 220, 0, 35)
    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Frame.Parent = tab.Page

    -- Label
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -10, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Text = text .. ": " .. self.Value
    Label.Parent = Frame

    -- Button to open dropdown
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 0, 15)
    Button.Position = UDim2.new(0, 5, 0, 20)
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Text = "▼"
    Button.Parent = Frame

    -- Options container
    local OptionsFrame = Instance.new("Frame")
    OptionsFrame.Size = UDim2.new(1, 0, 0, #options * 20)
    OptionsFrame.Position = UDim2.new(0, 0, 1, 0)
    OptionsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    OptionsFrame.Visible = false
    OptionsFrame.Parent = Frame

    -- Add options
    for i, option in ipairs(options) do
        local Opt = Instance.new("TextButton")
        Opt.Size = UDim2.new(1, 0, 0, 20)
        Opt.Position = UDim2.new(0, 0, 0, (i - 1) * 20)
        Opt.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Opt.TextColor3 = Color3.fromRGB(255, 255, 255)
        Opt.Text = option
        Opt.Parent = OptionsFrame

        Opt.MouseButton1Click:Connect(function()
            self.Value = option
            Label.Text = text + ": " .. option
            OptionsFrame.Visible = false
            self.Open = false

            if callback then
                callback(option)
            end
        end)
    end

    -- Toggle dropdown open/close
    Button.MouseButton1Click:Connect(function()
        self.Open = not self.Open
        OptionsFrame.Visible = self.Open
    end)

    self.Frame = Frame
    self.Button = Button
    self.OptionsFrame = OptionsFrame
    self.Label = Label

    return self
end

return Dropdown
