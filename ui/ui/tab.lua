local Tab = {}
Tab.__index = Tab

function Tab.new(window, name)
    local self = setmetatable({}, Tab)

    -- Create the tab button
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 100, 0, 30)
    Button.Text = name
    Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Parent = window.Main

    -- Create the tab page
    local Page = Instance.new("Frame")
    Page.Size = UDim2.new(1, 0, 1, -40)
    Page.Position = UDim2.new(0, 0, 0, 40)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.Parent = window.Main

    -- Tab switching logic
    Button.MouseButton1Click:Connect(function()
        for _, tab in pairs(window.Tabs) do
            tab.Page.Visible = false
        end
        Page.Visible = true
    end)

    self.Button = Button
    self.Page = Page

    table.insert(window.Tabs, self)

    return self
end

return Tab
