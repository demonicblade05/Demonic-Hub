local Button = {}
Button.__index = Button

function Button.new(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text
    btn.BorderSizePixel = 0

    btn.MouseButton1Click:Connect(function()
        if callback then
            pcall(callback)
        end
    end)

    return btn
end

return Button
