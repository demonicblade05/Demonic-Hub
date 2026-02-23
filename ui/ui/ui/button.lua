local Button = {}
Button.__index = Button

function Button.new(tab, text, callback)
    local self = setmetatable({}, Button)

    -- Create the button
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 200, 0, 30)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Text = text
    Btn.Parent = tab.Page

    -- Click event
    Btn.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    self.Button = Btn
    return self
end

return Button
