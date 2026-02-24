local Dropdown = {}
Dropdown.__index = Dropdown

function Dropdown.new(parent, text, list, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Size = UDim2.new(1, -10, 0, 30)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0

    local btn = Instance.new("TextButton")
    btn.Parent = frame
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text

    local open = false
    local container

    btn.MouseButton1Click:Connect(function()
        open = not open

        if open then
            container = Instance.new("Frame")
            container.Parent = parent
            container.Size = UDim2.new(1, -10, 0, #list * 25)
            container.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            container.BorderSizePixel = 0

            for _, item in ipairs(list) do
                local option = Instance.new("TextButton")
                option.Parent = container
                option.Size = UDim2.new(1, 0, 0, 25)
                option.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                option.TextColor3 = Color3.fromRGB(255, 255, 255)
                option.Text = item

                option.MouseButton1Click:Connect(function()
                    btn.Text = text .. ": " .. item
                    if callback then
                        pcall(callback, item)
                    end
                    container:Destroy()
                    open = false
                end)
            end
        else
            if container then container:Destroy() end
        end
    end)

    return frame
end

return Dropdown
